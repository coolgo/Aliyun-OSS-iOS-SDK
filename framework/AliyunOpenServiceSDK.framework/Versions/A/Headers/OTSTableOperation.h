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

#import <Foundation/Foundation.h>
#import "OTSOperation.h"
#import "PartitionKeyType.h" 
@class OTSTableOperation;
@class TableMeta;
@class OTSError;
@class CreateTableResult;
@class CreateTableGroupResult;
@class ListTableGroupResult;
@class ListTableResult;
@class TableMeta;
/**
 OTSTableOperationDelegate
 */
@protocol OTSTableOperationDelegate <NSObject>
/**
 网络错误响应
 @param op OTSTableOperation
 @param error OTSError
 */
-(void) tableOperationNetworkError:(OTSTableOperation*)op error:(OTSError*)error;
/**
 创建表成功
 @param op OTSTableOperation
 @param result CreateTableResult
 */
-(void) tableOperationCreateTableFinished:(OTSTableOperation*)op result:(CreateTableResult*)result;
/**
 创建表失败
 @param op OTSTableOperation
 @param error OTSError
 */
-(void) tableOperationCreateTableFailed:(OTSTableOperation*)op error:(OTSError*)error;
/**
 罗列表成功
 @param op OTSTableOperation
 @param result ListTableResult
 */
-(void) tableOperationListTablesFinished:(OTSTableOperation*)op result:(ListTableResult*)result;
/**
 罗列表失败
 @param op OTSTableOperation
 @param error OTSError
 */
-(void) tableOperationListTablesFailed:(OTSTableOperation*)op error:(OTSError*)error;
/**
 删除表成功
 @param op OTSTableOperation
 @param result NSString
 */
-(void) tableOperationDeleteTableFinished:(OTSTableOperation*)op result:(NSString*)result;
/**
 删除表失败
 @param op OTSTableOperation
 @param error OTSError
 */
-(void) tableOperationDeleteTableFailed:(OTSTableOperation*)op error:(OTSError*)error;
/**
 获取表元数据成功
 @param op OTSTableOperation
 @param result TableMeta
 */
-(void) tableOperationFetchTableMetaFinished:(OTSTableOperation*)op result:(TableMeta*)result;
/**
 获取表元数据失败
 @param op OTSTableOperation
 @param error OTSError
 */
-(void) tableOperationFetchTableMetaFailed:(OTSTableOperation*)op error:(OTSError*)error;
/**
 创建表组成功
 @param op OTSTableOperation
 @param result CreateTableGroupResult
 */
-(void) tableOperationCreateTableGroupFinished:(OTSTableOperation*)op result:(CreateTableGroupResult*)result;
/**
 创建表组失败
 @param op OTSTableOperation
 @param error OTSError
 */
-(void) tableOperationCreateTableGroupFailed:(OTSTableOperation*)op error:(OTSError*)error;
/**
 罗列表组成功
 @param op OTSTableOperation
 @param result CreateTableGroupResult
 */
-(void) tableOperationListTableGroupFinished:(OTSTableOperation*)op result:(ListTableGroupResult*)result;
/**
 罗列表组失败
 @param op OTSTableOperation
 @param error OTSError
 */
-(void) tableOperationListTableGroupFailed:(OTSTableOperation*)op error:(OTSError*)error;
/**
 罗删除表组成功
 @param op OTSTableOperation
 @param result CreateTableGroupResult
 */
-(void) tableOperationDeleteTableGroupFinished:(OTSTableOperation*)op result:(NSString*)result;
/**
 删除表组失败
 @param op OTSTableOperation
 @param error OTSError
 */
-(void) tableOperationDeleteTableGroupFailed:(OTSTableOperation*)op error:(OTSError*)error;
@end
/**
 OTSTableOperation类，table相关操作
 */
@interface OTSTableOperation : OTSOperation
{
    id<OTSTableOperationDelegate> delegate;
}
/**
 OTSTableOperationDelegate 代理对象
 */
@property(nonatomic,assign)id<OTSTableOperationDelegate> delegate;
/**
 创建表
 @param tableMeta TableMeta
 */
-(void) createTable:(TableMeta*) tableMeta;
/**
 罗列表
 */
-(void)listTables;
/**
 删除表
 @param tableName NSString
 */
-(void)deleteTable:(NSString*) tableName;
/**
 获取表元数据
 @param tableName NSString
 */
-(void) featchTableMeta:(NSString*) tableName;
/**
 获取表组
 @param name NSString
 @param  partitionKeyType  PartitionKeyType
 */
-(void) createTableGroup:(NSString*) name partitionKeyType:(PartitionKeyType)partitionKeyType;
/**
 罗列表组
 */
-(void) listTableGroups;
/**
 删除表组
 @param tableGroupName NSString
 */
-(void) deleteTableGroup:(NSString*)tableGroupName;
@end
