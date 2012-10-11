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
@class Row;
@class OTSDataOperation;
@class SingleRowQueryCriteria;
@class OffsetRowQueryCriteria;
@class RangeRowQueryCriteria;
@class RowPutChange;
@class RowDeleteChange;
/**
 OTSDataOperationDelegate
 */
@protocol OTSDataOperationDelegate <NSObject>
/**
 网络错误响应
 @param op OTSDataOperation
 @param error OTSError
 */
-(void) dataOperationNetworkError:(OTSDataOperation*)op error:(OTSError*)error;
/**
 获取Row成功
 @param op OTSDataOperation
 @param result Row
 */
-(void) dataOperationFetchRowFinished:(OTSDataOperation*)op result:(Row*)result;
/**
 获取Row失败
 @param op OTSDataOperation
 @param error OTSError
 */
-(void) dataOperationFetchRowFailed:(OTSDataOperation*)op error:(OTSError*)error;
/**
 通过Offset获取Row成功
 @param op OTSDataOperation
 @param result NSArray
 */
-(void) dataOperationFetchRowsByOffsetFinished:(OTSDataOperation*)op result:(NSArray*)result;//<Row>
/**
 通过Offset获取Row失败
 @param op OTSDataOperation
 @param error OTSError
 */
-(void) dataOperationFetchRowsByOffsetFailed:(OTSDataOperation*)op error:(OTSError*)error;
/**
 通过Range获取Row成功
 @param op OTSDataOperation
 @param result NSArray
 */
-(void) dataOperationFetchRowsByRangeFinished:(OTSDataOperation*)op result:(NSArray*)result;//<Row>
/**
 通过Range获取Row失败
 @param op OTSDataOperation
 @param error OTSError
 */
-(void) dataOperationFetchRowsByRangeFailed:(OTSDataOperation*)op error:(OTSError*)error;
/**
 写表数据成功
 @param op OTSDataOperation
 @param result NSString
 */
-(void) dataOperationPutDataFinished:(OTSDataOperation*)op result:(NSString*)result;
/**
 写表数据失败
 @param op OTSDataOperation
 @param error OTSError
 */
-(void) dataOperationPutDataFailed:(OTSDataOperation*)op error:(OTSError*)error;
/**
 删除表数据成功
 @param op OTSDataOperation
 @param result NSString
 */
-(void) dataOperationDeleteDataFinished:(OTSDataOperation*)op result:(NSString*)result;
/**
 删除表数据失败
 @param op OTSDataOperation
 @param error OTSError
 */
-(void) dataOperationDeleteDataFailed:(OTSDataOperation*)op error:(OTSError*)error;
/**
 批量修改表数据成功
 @param op OTSDataOperation
 @param result NSString
 */
-(void) dataOperationBatchModifyDataFinished:(OTSDataOperation*)op result:(NSString*)result;
/**
 批量修改表数据失败
 @param op OTSDataOperation
 @param error OTSError
 */
-(void) dataOperationBatchModifyDataFailed:(OTSDataOperation*)op error:(OTSError*)error;

@end
/**
 OTSDataOperation类，Data相关操作
 */
@interface OTSDataOperation : OTSOperation
{
    @private
    id<OTSDataOperationDelegate> delegate;
}
/**
 OTSDataOperationDelegate 代理对象
 */
@property(nonatomic,assign)id<OTSDataOperationDelegate> delegate;
/**
 获取Row
 @param singleRowQueryCriteria SingleRowQueryCriteria
 @param transactionID NSString
 */
-(void) fetchRow:(SingleRowQueryCriteria*) singleRowQueryCriteria transactionID:(NSString*) transactionID;
/**
 通过Offset获取Row
 @param offsetRowQueryCriteria OffsetRowQueryCriteria
 @param transactionID NSString
 */
-(void) fetchRowsByOffset:(OffsetRowQueryCriteria*) offsetRowQueryCriteria transactionID:(NSString*) transactionID;
/**
 通过Rang获取Row
 @param rangeRowQueryCriteria RangeRowQueryCriteria
 @param transactionID NSString
 */
-(void) fetchRowsByRange:(RangeRowQueryCriteria*) rangeRowQueryCriteria transactionID:(NSString*) transactionID;
/**
 写表数据
 @param tableName NSString
 @param rowPutChange RowPutChange
 @param transactionID NSString
 */
-(void) putData:(NSString*) tableName  rowPutChange:(RowPutChange*) rowPutChange transactionID:(NSString*) transactionID;
/**
 删除表数据
 @param tableName NSString
 @param rowDeleteChange RowDeleteChange
 @param transactionID NSString
 */
-(void) deleteData:(NSString*) tableName rowDeleteChange:(RowDeleteChange*) rowDeleteChange transactionID:(NSString*) transactionID;
//rowChanges NSArray<RowChange>
/**
 批量修改表数据
 @param tableName NSString
 @param rowChanges NSArray
 @param transactionID NSString
 */
-(void) batchModifyData:(NSString*) tableName rowChanges:(NSArray*)rowChanges  transactionID:(NSString*) transactionID;

@end
