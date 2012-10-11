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
#import "PartitionKeyType.h"
@class ServiceCredentials;
@class OTSTableOperation;
@class OTSTransactionOperation;
@class OTSDataOperation;
@class DefaultServiceClient;
@class TableMeta;
@class PartitionKeyValue;
@class SingleRowQueryCriteria;
@class RangeRowQueryCriteria;
@class OffsetRowQueryCriteria;
@class RowPutChange;
@class RowDeleteChange;
@class OTSClient;
@class OTSError;
@class CreateTableResult;
@class ListTableResult;
@class TableMeta;
@class CreateTableGroupResult;
@class ListTableGroupResult;
@class Row;
/**
 OTSClientDelegate
 */
@protocol OTSClientDelegate <NSObject>
@optional
/**
 网络错误响应
 @param client OTSClient
 @param error OTSError
 */
-(void) OTSClientNetworkError:(OTSClient*)client error:(OTSError*)error;
/**
 创建表成功
 @param client OTSClient
 @param result CreateTableResult
 */
-(void) OTSClientCreateTableFinished:(OTSClient*)client result:(CreateTableResult*)result;
/**
 创建表失败
 @param client OTSClient
 @param error OTSError
 */
-(void) OTSClientCreateTableFailed:(OTSClient*)client error:(OTSError*)error;
/**
 罗列表成功
 @param client OTSClient
 @param result CreateTableResult
 */
-(void) OTSClientListTablesFinished:(OTSClient*)client result:(ListTableResult*)result;
/**
 罗列表失败
 @param client OTSClient
 @param error OTSError
 */
-(void) OTSClientListTablesFailed:(OTSClient*)client error:(OTSError*)error;
/**
 删除表成功
 @param client OTSClient
 @param result CreateTableResult
 */
-(void) OTSClientDeleteTableFinished:(OTSClient*)client result:(NSString*)result;
/**
 删除表失败
 @param client OTSClient
 @param error OTSError
 */
-(void) OTSClientDeleteTableFailed:(OTSClient*)client error:(OTSError*)error;
/**
 获取表元数据成功
 @param client OTSClient
 @param result CreateTableResult
 */
-(void) OTSClientFetchTableMetaFinished:(OTSClient*)client result:(TableMeta*)result;
/**
 获取表元数据失败
 @param client OTSClient
 @param error OTSError
 */
-(void) OTSClientFetchTableMetaFailed:(OTSClient*)client error:(OTSError*)error;
/**
 创建表组成功
 @param client OTSClient
 @param result CreateTableResult
 */
-(void) OTSClientCreateTableGroupFinished:(OTSClient*)client result:(CreateTableGroupResult*)result;
/**
 创建表组失败
 @param client OTSClient
 @param error OTSError
 */
-(void) OTSClientCreateTableGroupFailed:(OTSClient*)client error:(OTSError*)error;
/**
 罗列表组成功
 @param client OTSClient
 @param result CreateTableResult
 */
-(void) OTSClientListTableGroupFinished:(OTSClient*)client result:(ListTableGroupResult*)result;
/**
 罗列表组失败
 @param client OTSClient
 @param error OTSError
 */
-(void) OTSClientListTableGroupFailed:(OTSClient*)client error:(OTSError*)error;
/**
 删除表组成功
 @param client OTSClient
 @param result CreateTableResult
 */
-(void) OTSClientDeleteTableGroupFinished:(OTSClient*)client result:(NSString*)result;
/**
 删除表组失败
 @param client OTSClient
 @param error OTSError
 */
-(void) OTSClientDeleteTableGroupFailed:(OTSClient*)client error:(OTSError*)error;
/**
 开始事务成功
 @param client OTSClient
 @param result CreateTableResult
 */
-(void) OTSClientStartTransactionFinished:(OTSClient*)client result:(NSString*)result;
/**
 开始事务失败
 @param client OTSClient
 @param error OTSError
 */
-(void) OTSClientStartTransactionFailed:(OTSClient*)client error:(OTSError*)error;
/**
 提交事务成功
 @param client OTSClient
 @param result CreateTableResult
 */
-(void) OTSClientCommitTransactionFinished:(OTSClient*)client result:(NSString*)result;
/**
 提交事务失败
 @param client OTSClient
 @param error OTSError
 */
-(void) OTSClientCommitTransactionFailed:(OTSClient*)client error:(OTSError*)error;
/**
 中断事务成功
 @param client OTSClient
 @param result CreateTableResult
 */
-(void) OTSClientAbortTransactionFinished:(OTSClient*)client result:(NSString*)result;
/**
 中断事务失败
 @param client OTSClient
 @param error OTSError
 */
-(void) OTSClientAbortTransactionFailed:(OTSClient*)client error:(OTSError*)error;
/**
 获取Row成功
 @param client OTSClient
 @param result CreateTableResult
 */
-(void) OTSClientFetchRowFinished:(OTSClient*)client result:(Row*)result;
/**
 获取Row失败
 @param client OTSClient
 @param error OTSError
 */
-(void) OTSClientFetchRowFailed:(OTSClient*)client error:(OTSError*)error;
/**
 通过offset获取Row成功
 @param client OTSClient
 @param result CreateTableResult
 */
-(void) OTSClientFetchRowsByOffsetFinished:(OTSClient*)client result:(NSArray*)result;
/**
 通过offset获取Row失败
 @param client OTSClient
 @param error OTSError
 */
-(void) OTSClientFetchRowsByOffsetFailed:(OTSClient*)client error:(OTSError*)error;
/**
 通过rang获取Row成功
 @param client OTSClient
 @param result CreateTableResult
 */
-(void) OTSClientFetchRowsByRangeFinished:(OTSClient*)client result:(NSArray*)result;
/**
 通过rang获取Row失败
 @param client OTSClient
 @param error OTSError
 */
-(void) OTSClientFetchRowsByRangeFailed:(OTSClient*)client error:(OTSError*)error;
/**
 写表数据成功
 @param client OTSClient
 @param result CreateTableResult
 */
-(void) OTSClientPutDataFinished:(OTSClient*)client result:(NSString*)result;
/**
 写表数据失败
 @param client OTSClient
 @param error OTSError
 */
-(void) OTSClientPutDataFailed:(OTSClient*)client error:(OTSError*)error;
/**
 删除表数据成功
 @param client OTSClient
 @param result CreateTableResult
 */
-(void) OTSClientDeleteDataFinished:(OTSClient*)client result:(NSString*)result;
/**
 删除表数据失败
 @param client OTSClient
 @param error OTSError
 */
-(void) OTSClientDeleteDataFailed:(OTSClient*)client error:(OTSError*)error;
/**
 批量修改表数据成功
 @param client OTSClient
 @param result CreateTableResult
 */
-(void) OTSClientBatchModifyDataFinished:(OTSClient*)client result:(NSString*)result;
/**
 批量修改表数据失败
 @param client OTSClient
 @param error OTSError
 */
-(void) OTSClientBatchModifyDataFailed:(OTSClient*)client error:(OTSError*)error;
@end
/**
 OTSClient 类，OTS相关操作类
 */
@interface OTSClient : NSObject
{
@private
    NSString *_endpoint;
    ServiceCredentials *_credentials;
    DefaultServiceClient *_clientTableOp;
    DefaultServiceClient *_clientTransactionOp;
    DefaultServiceClient *_clientDataOp;
    OTSTableOperation *_tableOp;
    OTSTransactionOperation *_transactionOp;
    OTSDataOperation *_dataOp;
    id<OTSClientDelegate> delegate;
}
/**
 OTSClientDelegate 代理对象
 */
@property(nonatomic,assign)id<OTSClientDelegate> delegate;
/**
 初始化方法
 @param accessID NSString
 @param accessKey NSString
 */
-(id) initWithAccessId:(NSString * ) accessID 
          andAccessKey:(NSString * )accessKey;
/**
 初始化方法 
 @param endpoint NSString
 @param accessID NSString
 @param accessKey NSString
 */
-(id) initWithEndPoint:(NSString * ) endpoint 
              AccessId:(NSString * ) accessID 
          andAccessKey:(NSString * )accessKey;

/**
 静态初始化方法 返回autorelease 对象
 @param accessID NSString
 @param accessKey NSString
 */
+(id) OTSClientWithAccessId:(NSString * ) accessID 
               andAccessKey:(NSString * )accessKey;
/**
 静态初始化方法 返回autorelease 对象 
 @param endpoint NSString
 @param accessID NSString
 @param accessKey NSString
 */
+(id) OTSClientWithEndPoint:(NSString * ) endpoint 
                   AccessId:(NSString * ) accessID 
               andAccessKey:(NSString * )accessKey;
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
 创建表组
 @param name NSString
 @param partitionKeyType PartitionKeyType
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
/**
 获取Row
 @param singleRowQueryCriteria SingleRowQueryCriteria
 @param transactionId NSString
 */
-(void) fetchRow:(SingleRowQueryCriteria*) singleRowQueryCriteria transactionID:(NSString*) transactionID;
/**
 通过Offset获取Row
 @param offsetRowQueryCriteria OffsetRowQueryCriteria
 @param transactionId NSString
 */
-(void) fetchRowsByOffset:(OffsetRowQueryCriteria*) offsetRowQueryCriteria transactionID:(NSString*) transactionID;
/**
 通过Range获取Row
 @param rangeRowQueryCriteria RangeRowQueryCriteria
 @param transactionId NSString
 */
-(void) fetchRowsByRange:(RangeRowQueryCriteria*) rangeRowQueryCriteria transactionID:(NSString*) transactionID;
/**
 写表数据
 @param tableName NSString
 @param rowPutChange RowPutChange
 @param transactionId NSString
 */
-(void) putData:(NSString*) tableName  rowPutChange:(RowPutChange*) rowPutChange transactionID:(NSString*) transactionID;
/**
 删除表数据
 @param tableName NSString
 @param rowDeleteChange RowDeleteChange
 @param transactionId NSString
 */
-(void) deleteData:(NSString*) tableName rowDeleteChange:(RowDeleteChange*) rowDeleteChange transactionID:(NSString*) transactionID;
/**
 批量修改表数据
 @param tableName NSString
 @param rowChanges NSArray
 @param transactionId NSString
 */
-(void) batchModifyData:(NSString*) tableName rowChanges:(NSArray*)rowChanges  transactionID:(NSString*) transactionID;
@end
