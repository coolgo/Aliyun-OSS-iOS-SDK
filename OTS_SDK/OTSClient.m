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


#import "OTSClient.h"
#import "ServiceCredentials.h"
#import "DefaultServiceClient.h"
#import "OTSTableOperation.h"
#import "ClientConfiguration.h"
#import "OTSError.h"
#import "CreateTableResult.h"
#import "CreateTableGroupResult.h"
#import "OTSTransactionOperation.h"
#import "OTSDataOperation.h"
#import "PartitionKeyValue.h"
#import "SingleRowQueryCriteria.h"
#import "RangeRowQueryCriteria.h"
#import "OffsetRowQueryCriteria.h"
#import "RowPutChange.h"
#import "RowDeleteChange.h"
#import "CreateTableResult.h"
#import "ListTableResult.h"
#import "TableMeta.h"
#import "CreateTableGroupResult.h"
#import "ListTableGroupResult.h"
#import "Row.h"
@interface OTSClient()<OTSTableOperationDelegate,OTSTransactionOperationDelegate,OTSDataOperationDelegate>
@end
@implementation OTSClient
@synthesize delegate;
-(void) dealloc
{

    [_endpoint release];
    _endpoint = nil;
    [_credentials release];
    _credentials = nil;
    [_clientTableOp release];
    _clientTableOp = nil;
    [_clientTransactionOp release];
    _clientTransactionOp = nil;
    [_clientTransactionOp release];
    _clientTransactionOp = nil;
    [_clientDataOp release];
    _clientDataOp = nil;
    [_tableOp release];
    _tableOp = nil;
    
    [super dealloc];
}
-(id) init
{
    if (self = [self initWithEndPoint:@"http://service.ots.aliyun.com" AccessId:@"" andAccessKey:@"" ]) {
        ;
    }
    return self;
}
-(id) initWithAccessId:(NSString * ) accessID andAccessKey:(NSString * )accessKey
{
 //   ClientConfiguration * config = [ClientConfiguration clientConfiguration];
    if (self = [self initWithEndPoint:@"http://service.ots.aliyun.com" AccessId:accessID andAccessKey:accessKey ]) {
        ;
    }
    return self;
}
-(id) initWithEndPoint:(NSString * ) endpoint AccessId:(NSString * ) accessID andAccessKey:(NSString * )accessKey
{
    if (self = [super init]) {
        _endpoint = endpoint;
        [_endpoint retain];
        _credentials = [[ServiceCredentials alloc] initWithAccessId:accessID andAccessKey:accessKey];
        ClientConfiguration *config = [ClientConfiguration clientConfiguration];
        _clientTableOp = [[DefaultServiceClient alloc] initWithClientConfiguration:config ];
        _tableOp = [[OTSTableOperation alloc] initWithEndPoint:_endpoint credentials:_credentials client:_clientTableOp];
        _tableOp.delegate = self;
        
         _clientTransactionOp = [[DefaultServiceClient alloc] initWithClientConfiguration:config ];
        _transactionOp = [[OTSTransactionOperation alloc] initWithEndPoint:_endpoint credentials:_credentials client:_clientTransactionOp];
        _transactionOp.delegate = self;
        
        _clientDataOp = [[DefaultServiceClient alloc] initWithClientConfiguration:config ];
        _dataOp = [[OTSDataOperation alloc] initWithEndPoint:_endpoint credentials:_credentials client:_clientDataOp];
        _dataOp.delegate = self;
    }

    return self;
}

+(id) OTSClientWithAccessId:(NSString * ) accessID andAccessKey:(NSString * )accessKey
{
    OTSClient * c = [[OTSClient alloc] initWithAccessId:accessID andAccessKey:accessKey];
    return [c autorelease];
}
+(id) OTSClientWithEndPoint:(NSString * ) endpoint AccessId:(NSString * ) accessID andAccessKey:(NSString * )accessKey
{
    OTSClient * c = [[OTSClient alloc] initWithEndPoint:endpoint AccessId:accessID andAccessKey:accessKey];
    return [c autorelease];
}
-(void) createTable:(TableMeta*) tableMeta
{
    [_tableOp createTable:tableMeta];
}
-(void)listTables
{
    [_tableOp listTables];
}
-(void)deleteTable:(NSString*) tableName
{
    [_tableOp deleteTable:tableName];
}
-(void) featchTableMeta:(NSString*) tableName
{
    [_tableOp featchTableMeta:tableName];
}
-(void) createTableGroup:(NSString*) name partitionKeyType:(PartitionKeyType)partitionKeyType
{
    [_tableOp createTableGroup:name partitionKeyType:partitionKeyType];
}
-(void)listTableGroups
{
    [_tableOp listTableGroups];
}

-(void) deleteTableGroup:(NSString*)tableGroupName
{
    [_tableOp deleteTableGroup:tableGroupName];
}
-(void) startTransaction:(NSString*) entityName partitionKeyValue:(PartitionKeyValue *)partitionKeyValue
{
    [_transactionOp startTransaction:entityName partitionKeyValue:partitionKeyValue];
}

-(void) commitTransaction:(NSString*) transactionId 
{
    [_transactionOp commitTransaction:transactionId];
}

-(void) abortTransaction:(NSString*) transactionId 
{
    [_transactionOp abortTransaction:transactionId];
}

-(void) fetchRow:(SingleRowQueryCriteria*) singleRowQueryCriteria transactionID:(NSString*) transactionID
{
    [_dataOp fetchRow:singleRowQueryCriteria transactionID:transactionID];
}

-(void) fetchRowsByOffset:(OffsetRowQueryCriteria*) offsetRowQueryCriteria transactionID:(NSString*) transactionID
{
    [_dataOp fetchRowsByOffset:offsetRowQueryCriteria transactionID:transactionID];
}

-(void) fetchRowsByRange:(RangeRowQueryCriteria*) rangeRowQueryCriteria transactionID:(NSString*) transactionID
{
    [_dataOp fetchRowsByRange:rangeRowQueryCriteria transactionID:transactionID];
}

-(void) putData:(NSString*) tableName  rowPutChange:(RowPutChange*) rowPutChange transactionID:(NSString*) transactionID
{
    [_dataOp putData:tableName rowPutChange:rowPutChange transactionID:transactionID];
}

-(void) deleteData:(NSString*) tableName rowDeleteChange:(RowDeleteChange*) rowDeleteChange transactionID:(NSString*) transactionID
{
    [_dataOp deleteData:tableName rowDeleteChange:rowDeleteChange transactionID:transactionID];
}

//rowChanges NSArray<RowChange>
-(void) batchModifyData:(NSString*) tableName rowChanges:(NSArray*)rowChanges  transactionID:(NSString*) transactionID
{
    [_dataOp batchModifyData:tableName rowChanges:rowChanges transactionID:transactionID];
}

-(void) tableOperationNetworkError:(OTSTableOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientNetworkError:error:)]) {
        [self.delegate OTSClientNetworkError:self error:error];
    }
}


-(void) tableOperationCreateTableFinished:(OTSTableOperation*)op result:(CreateTableResult*)result
{
    if ([self.delegate respondsToSelector:@selector(OTSClientCreateTableFinished:result:)]) {
        [self.delegate OTSClientCreateTableFinished:self result:result];
    }
}

-(void) tableOperationCreateTableFailed:(OTSTableOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientCreateTableFailed:error:)]) {
        [self.delegate OTSClientCreateTableFailed:self error:error];
    }
}


-(void) tableOperationListTablesFinished:(OTSTableOperation*)op result:(ListTableResult*)result
{
    if ([self.delegate respondsToSelector:@selector(OTSClientListTablesFinished:result:)]) {
        [self.delegate OTSClientListTablesFinished:self result:result];
    }
}

-(void) tableOperationListTablesFailed:(OTSTableOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientListTablesFailed:error:)]) {
        [self.delegate OTSClientListTablesFailed:self error:error];
    }
}


-(void) tableOperationDeleteTableFinished:(OTSTableOperation*)op result:(NSString*)result
{
    if ([self.delegate respondsToSelector:@selector(OTSClientDeleteTableFinished:result:)]) {
        [self.delegate OTSClientDeleteTableFinished:self result:result];
    }
}

-(void) tableOperationDeleteTableFailed:(OTSTableOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientDeleteTableFailed:error:)]) {
        [self.delegate OTSClientDeleteTableFailed:self error:error];
    }
}


-(void) tableOperationFetchTableMetaFinished:(OTSTableOperation*)op result:(TableMeta*)result
{
    if ([self.delegate respondsToSelector:@selector(OTSClientFetchTableMetaFinished:result:)]) {
        [self.delegate OTSClientFetchTableMetaFinished:self result:result];
    }
}

-(void) tableOperationFetchTableMetaFailed:(OTSTableOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientFetchTableMetaFailed:error:)]) {
        [self.delegate OTSClientFetchTableMetaFailed:self error:error];
    }
}


-(void) tableOperationCreateTableGroupFinished:(OTSTableOperation*)op result:(CreateTableGroupResult*)result
{
    if ([self.delegate respondsToSelector:@selector(OTSClientCreateTableGroupFinished:result:)]) {
        [self.delegate OTSClientCreateTableGroupFinished:self result:result];
    }
}

-(void) tableOperationCreateTableGroupFailed:(OTSTableOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientCreateTableGroupFailed:error:)]) {
        [self.delegate OTSClientCreateTableGroupFailed:self error:error];
    }
}


-(void) tableOperationListTableGroupFinished:(OTSTableOperation*)op result:(ListTableGroupResult*)result
{
    if ([self.delegate respondsToSelector:@selector(OTSClientListTableGroupFinished:result:)]) {
        [self.delegate OTSClientListTableGroupFinished:self result:result];
    }
}

-(void) tableOperationListTableGroupFailed:(OTSTableOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientListTableGroupFailed:error:)]) {
        [self.delegate OTSClientListTableGroupFailed:self error:error];
    }
}


-(void) tableOperationDeleteTableGroupFinished:(OTSTableOperation*)op result:(NSString*)result
{
    if ([self.delegate respondsToSelector:@selector(OTSClientDeleteTableGroupFinished:result:)]) {
        [self.delegate OTSClientDeleteTableGroupFinished:self result:result];
    }
}

-(void) tableOperationDeleteTableGroupFailed:(OTSTableOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientDeleteTableGroupFailed:error:)]) {
        [self.delegate OTSClientDeleteTableGroupFailed:self error:error];
    }
}
// transactionOperation
-(void) transactionOperationNetworkError:(OTSTransactionOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientNetworkError:error:)]) {
        [self.delegate OTSClientNetworkError:self error:error];
    }
}


-(void) transactionOperationStartTransactionFinished:(OTSTransactionOperation*)op result:(NSString*)result
{
    if ([self.delegate respondsToSelector:@selector(OTSClientStartTransactionFinished:result:)]) {
        [self.delegate OTSClientStartTransactionFinished:self result:result];
    }
}

-(void) transactionOperationStartTransactionFailed:(OTSTransactionOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientStartTransactionFailed:error:)]) {
        [self.delegate OTSClientStartTransactionFailed:self error:error];
    }
}


-(void) transactionOperationCommitTransactionFinished:(OTSTransactionOperation*)op result:(NSString*)result
{
    if ([self.delegate respondsToSelector:@selector(OTSClientCommitTransactionFinished:result:)]) {
        [self.delegate OTSClientCommitTransactionFinished:self result:result];
    }
}

-(void) transactionOperationCommitTransactionFailed:(OTSTransactionOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientCommitTransactionFailed:error:)]) {
        [self.delegate OTSClientCommitTransactionFailed:self error:error];
    }
}


-(void) transactionOperationAbortTransactionFinished:(OTSTransactionOperation*)op result:(NSString*)result
{
    if ([self.delegate respondsToSelector:@selector(OTSClientAbortTransactionFinished:result:)]) {
        [self.delegate OTSClientAbortTransactionFinished:self result:result];
    }
}

-(void) transactionOperationAbortTransactionFailed:(OTSTransactionOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientAbortTransactionFailed:error:)]) {
        [self.delegate OTSClientAbortTransactionFailed:self error:error];
    }
}
-(void) dataOperationNetworkError:(OTSDataOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientNetworkError:error:)]) {
        [self.delegate OTSClientNetworkError:self error:error];
    }
}

-(void) dataOperationFetchRowFinished:(OTSDataOperation*)op result:(Row*)result
{
    if ([self.delegate respondsToSelector:@selector(OTSClientFetchRowFinished:result:)]) {
        [self.delegate OTSClientFetchRowFinished:self result:result];
    }
}

-(void) dataOperationFetchRowFailed:(OTSDataOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientFetchRowFailed:error:)]) {
        [self.delegate OTSClientFetchRowFailed:self error:error];
    }
}


-(void) dataOperationFetchRowsByOffsetFinished:(OTSDataOperation*)op result:(NSArray*)result
{
    if ([self.delegate respondsToSelector:@selector(OTSClientFetchRowsByOffsetFinished:result:)]) {
        [self.delegate OTSClientFetchRowsByOffsetFinished:self result:result];
    }
}

-(void) dataOperationFetchRowsByOffsetFailed:(OTSDataOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientFetchRowsByOffsetFailed:error:)]) {
        [self.delegate OTSClientFetchRowsByOffsetFailed:self error:error];
    }
}


-(void) dataOperationFetchRowsByRangeFinished:(OTSDataOperation*)op result:(NSArray*)result
{
    if ([self.delegate respondsToSelector:@selector(OTSClientFetchRowsByRangeFinished:result:)]) {
        [self.delegate OTSClientFetchRowsByRangeFinished:self result:result];
    }
}

-(void) dataOperationFetchRowsByRangeFailed:(OTSDataOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientFetchRowsByRangeFailed:error:)]) {
        [self.delegate OTSClientFetchRowsByRangeFailed:self error:error];
    }
}


-(void) dataOperationPutDataFinished:(OTSDataOperation*)op result:(NSString*)result
{
    if ([self.delegate respondsToSelector:@selector(OTSClientPutDataFinished:result:)]) {
        [self.delegate OTSClientPutDataFinished:self result:result];
    }
}

-(void) dataOperationPutDataFailed:(OTSDataOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientPutDataFailed:error:)]) {
        [self.delegate OTSClientPutDataFailed:self error:error];
    }
}


-(void) dataOperationDeleteDataFinished:(OTSDataOperation*)op result:(NSString*)result
{
    if ([self.delegate respondsToSelector:@selector(OTSClientDeleteDataFinished:result:)]) {
        [self.delegate OTSClientDeleteDataFinished:self result:result];
    }
}

-(void) dataOperationDeleteDataFailed:(OTSDataOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientDeleteDataFailed:error:)]) {
        [self.delegate OTSClientDeleteDataFailed:self error:error];
    }
}


-(void) dataOperationBatchModifyDataFinished:(OTSDataOperation*)op result:(NSString*)result
{
    if ([self.delegate respondsToSelector:@selector(OTSClientBatchModifyDataFinished:result:)]) {
        [self.delegate OTSClientBatchModifyDataFinished:self result:result];
    }
}

-(void) dataOperationBatchModifyDataFailed:(OTSDataOperation*)op error:(OTSError*)error
{
    if ([self.delegate respondsToSelector:@selector(OTSClientBatchModifyDataFailed:error:)]) {
        [self.delegate OTSClientBatchModifyDataFailed:self error:error];
    }
}


@end
