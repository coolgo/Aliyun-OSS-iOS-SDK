/*
 Copyright 2012 baocai zhang. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 THIS SOFTWARE IS PROVIDED BY THE FREEBSD PROJECT ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE FREEBSD PROJECT OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 The views and conclusions contained in the software and documentation are those of the authors and should not be interpreted as representing official policies, either expressed or implied, of the FreeBSD Project.
 */
/*
 @author baocai zhang
 website:www.giser.net
 email:zhangbaocaicug@gmail.com
 */

#import "OTSOperation.h"

#import "OTSError.h"
@class PartitionKeyValue;
@class OTSTransactionOperation;
/**
 OTSTransactionOperationDelegate
 */
@protocol OTSTransactionOperationDelegate <NSObject>
/**
 网络错误响应
 @param op OTSTransactionOperation
 @param error OTSError
 */
-(void) transactionOperationNetworkError:(OTSTransactionOperation*)op error:(OTSError*)error;
/**
 开始事务成功
 @param op OTSTransactionOperation
 @param result NSString
 */
-(void) transactionOperationStartTransactionFinished:(OTSTransactionOperation*)op result:(NSString*)result;
/**
 开始事务失败
 @param op OTSTransactionOperation
 @param error OTSError
 */
-(void) transactionOperationStartTransactionFailed:(OTSTransactionOperation*)op error:(OTSError*)error;
/**
 提交事务成功
 @param op OTSTransactionOperation
 @param result NSString
 */
-(void) transactionOperationCommitTransactionFinished:(OTSTransactionOperation*)op result:(NSString*)result;
/**
 提交事务失败
 @param op OTSTransactionOperation
 @param error OTSError
 */
-(void) transactionOperationCommitTransactionFailed:(OTSTransactionOperation*)op error:(OTSError*)error;
/**
 中断事务成功
 @param op OTSTransactionOperation
 @param result NSString
 */
-(void) transactionOperationAbortTransactionFinished:(OTSTransactionOperation*)op result:(NSString*)result;
/**
 中断事务失败
 @param op OTSTransactionOperation
 @param error OTSError
 */
-(void) transactionOperationAbortTransactionFailed:(OTSTransactionOperation*)op error:(OTSError*)error;

@end
/**
 OTSTransactionOperation， 事务类相关操作
 */
@interface OTSTransactionOperation : OTSOperation
{
@private
    id<OTSTransactionOperationDelegate> delegate;
}
/**
 OTSTransactionOperationDelegate 代理对象
 */
@property(nonatomic,assign)id<OTSTransactionOperationDelegate> delegate;
/**
开始事务
 @param entityName NSString
 @param partitionKeyValue PartitionKeyValue
 */
-(void) startTransaction:(NSString*) entityName partitionKeyValue:(PartitionKeyValue *)partitionKeyValue;
/**
 提交事务
 @param transactionId NSString
 */
-(void) commitTransaction:(NSString*) transactionId ;
/**
 中断事务
 @param transactionId NSString
 */
-(void) abortTransaction:(NSString*) transactionId ;
@end
