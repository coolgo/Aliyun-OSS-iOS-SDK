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
#import "OTSDataOperation.h"
#import "SingleRowQueryCriteria.h"
#import "OTSUtil.h"
#import "OffsetRowQueryCriteria.h"
#import "RangeRowQueryCriteria.h"
#import "RowChange.h"
#import "RowPutChange.h"
#import "RowDeleteChange.h"
#import "PrimaryKeyRange.h"
#import "ColumnValue.h"
#import "OTSErrorCode.h"
#import "ResponseMessage.h"
#import "Row.h"
#import "NSArray+Rows.h"
@implementation OTSDataOperation
@synthesize delegate;

-(void) fetchRow:(SingleRowQueryCriteria*) singleRowQueryCriteria transactionID:(NSString*) transactionID
{
    NSAssert(!(singleRowQueryCriteria == nil),@"singleRowQueryCriteria nil");
//    NSAssert(!(transactionID == nil),@"transactionID nil");
    NSArray *keys = [NSArray arrayWithObjects:@"method",@"transactionID",nil];
    NSString * strT = @"";
    if (transactionID != nil) {
        strT = transactionID;
    }
    NSArray *objs = [NSArray arrayWithObjects:@"fetchRow",strT, nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    OrderedDictionary * params =[self makeRowParameters:singleRowQueryCriteria transactionID:transactionID];
    
    [self invokeNoResult:@"GetRow"  httpMethod:HttpMethod_GET params:params userInfo:userInfo];
  //  [params release];
}

-(OrderedDictionary *) makeRowParameters:(SingleRowQueryCriteria*) singleRowQueryCriteria transactionID:(NSString*) transactionID
{

    OrderedDictionary * params =[[OrderedDictionary alloc] initWithCapacity:2];
    [params setObject:[OTSUtil RowQueryCriteriaToEntityName:singleRowQueryCriteria] forKey:@"TableName"];
    int i = 1;
    NSEnumerator * keyEnumerator = [singleRowQueryCriteria.primaryKeys keyEnumerator];
    id key;
    while (key = [keyEnumerator nextObject]) {
       PrimaryKeyValue * value = [singleRowQueryCriteria.primaryKeys objectForKey:key];
        NSString * str = [NSString stringWithFormat:@"PK.%d.",i++];
        [params setObject:key forKey:[NSString stringWithFormat:@"%@Name",str]];
        [params setObject:[OTSUtil PrimaryKeyValueToParameterString:value] forKey:[NSString stringWithFormat:@"%@Value",str]];
        [params setObject:[OTSUtil PrimaryKeyTypeToString:value.type ] forKey:[NSString stringWithFormat:@"%@Type",str]];
    }
    int j = 1;
    for (NSString * strName in singleRowQueryCriteria.columnNames) {
        NSString * str = [NSString stringWithFormat:@"Column.%d.Name",j++];
        [params setObject:strName forKey:str];
        
    }
    if (transactionID != nil && ![transactionID isEqualToString:@""]) {
        [params setObject:transactionID forKey:@"TransactionID"];
    }
    return [params autorelease];
    
}
-(void) fetchRowsByOffset:(OffsetRowQueryCriteria*) offsetRowQueryCriteria transactionID:(NSString*) transactionID
{
    NSAssert(!(offsetRowQueryCriteria == nil),@"singleRowQueryCriteria nil");
//    NSAssert(!(transactionID == nil),@"transactionID nil");
    NSAssert(!([offsetRowQueryCriteria.pagingKeys count] == 0),@"MustSetPrimaryKey");
    NSAssert(!(offsetRowQueryCriteria.top < 0),@"MustSetCriteriaTop");
    NSString * strT = @"";
    if (transactionID != nil) {
        strT = transactionID;
    }

    NSArray *keys = [NSArray arrayWithObjects:@"method",@"transactionID",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"fetchRowsByOffset",strT, nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    OrderedDictionary * params =[self makeRowsByOffsetParameters:offsetRowQueryCriteria transactionID:transactionID];
    
    [self invokeNoResult:@"GetRowsByOffset"  httpMethod:HttpMethod_POST params:params userInfo:userInfo];
  //  [params release];
}
-(OrderedDictionary *) makeRowsByOffsetParameters:(OffsetRowQueryCriteria*) offsetRowQueryCriteria transactionID:(NSString*) transactionID
{
    OrderedDictionary * params =[[OrderedDictionary alloc] initWithCapacity:2];
    [params setObject:[OTSUtil RowQueryCriteriaToEntityName:offsetRowQueryCriteria] forKey:@"TableName"];
    int i = 1;
    NSEnumerator * keyEnumerator = [offsetRowQueryCriteria.pagingKeys keyEnumerator];
    id key;
    while (key = [keyEnumerator nextObject]) {
        PrimaryKeyValue * value = [offsetRowQueryCriteria.pagingKeys objectForKey:key];
        NSString * str = [NSString stringWithFormat:@"Paging.%d.",i++];
        [params setObject:key forKey:[NSString stringWithFormat:@"%@Name",str]];
        [params setObject:[OTSUtil PrimaryKeyValueToParameterString:value] forKey:[NSString stringWithFormat:@"%@Value",str]];
        [params setObject:[OTSUtil PrimaryKeyTypeToString:value.type ] forKey:[NSString stringWithFormat:@"%@Type",str]];
    }
    int j = 1;
    for (NSString * strName in offsetRowQueryCriteria.columnNames) {
        NSString * str = [NSString stringWithFormat:@"Column.%d.Name",j++];
        [params setObject:strName forKey:[NSString stringWithFormat:@"%@",str]];
    }
     [params setObject:[NSString stringWithFormat:@"%d",offsetRowQueryCriteria.offset] forKey:@"Offset"];
    [params setObject:[NSString stringWithFormat:@"%d",offsetRowQueryCriteria.top] forKey:@"Top"];
    if (offsetRowQueryCriteria.isReverse) {
        [params setObject:@"TRUE" forKey:@"IsReverse"];
    }
    else {
         [params setObject:@"FALSE" forKey:@"IsReverse"];
    }    
    if (transactionID != nil && ![transactionID isEqualToString:@""]) {
        [params setObject:transactionID forKey:@"TransactionID"];
    }
    return [params autorelease];
}
-(void) fetchRowsByRange:(RangeRowQueryCriteria*) rangeRowQueryCriteria transactionID:(NSString*) transactionID
{
    NSAssert(!(rangeRowQueryCriteria == nil),@"rangeRowQueryCriteria nil");
//    NSAssert(!(transactionID == nil),@"transactionID nil");
    NSAssert(!(rangeRowQueryCriteria.range  == nil),@"MustSetCriteriaRange");
    BOOL isReverse = rangeRowQueryCriteria.isReverse;
    NSAssert(!((!isReverse)&& [[PrimaryKeyRange INF_MAX] isEqual:rangeRowQueryCriteria.range.begin]),@"BeginIsInfMax");
     NSAssert(!((isReverse)&& [[PrimaryKeyRange INF_MIN] isEqual:rangeRowQueryCriteria.range.begin]),@"BeginIsInfMin");
    int i =[OTSUtil compare:rangeRowQueryCriteria.range.begin primaryKeyValue2:rangeRowQueryCriteria.range.end];
    NSAssert(!( ((!isReverse) && (i > 0)) || ((isReverse) && (i < 0))),@"BeginEndIncorrect");
    NSString * strT = @"";
    if (transactionID != nil) {
        strT = transactionID;
    }

    NSArray *keys = [NSArray arrayWithObjects:@"method",@"transactionID",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"fetchRowsByRange",strT, nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    OrderedDictionary * params =[self makeRowsByRangeParameters:rangeRowQueryCriteria transactionID:transactionID];
  //  
    [self invokeNoResult:@"GetRowsByRange"  httpMethod:HttpMethod_POST params:params userInfo:userInfo];
   // [params release];
}
-(OrderedDictionary *) makeRowsByRangeParameters:(RangeRowQueryCriteria*) rangeRowQueryCriteria transactionID:(NSString*) transactionID
{
    OrderedDictionary * params =[[OrderedDictionary alloc] initWithCapacity:2];
    [params setObject:[OTSUtil RowQueryCriteriaToEntityName:rangeRowQueryCriteria] forKey:@"TableName"];
    int i = 1;
    NSEnumerator * keyEnumerator = [rangeRowQueryCriteria.primaryKeys keyEnumerator];
    id key;
    while (key = [keyEnumerator nextObject]) {
        PrimaryKeyValue * value = [rangeRowQueryCriteria.primaryKeys objectForKey:key];
        NSString * str = [NSString stringWithFormat:@"PK.%d.",i++];
        [params setObject:key forKey:[NSString stringWithFormat:@"%@Name",str]];
        [params setObject:[OTSUtil PrimaryKeyValueToParameterString:value] forKey:[NSString stringWithFormat:@"%@Value",str]];
        [params setObject:[OTSUtil PrimaryKeyTypeToString:value.type ] forKey:[NSString stringWithFormat:@"%@Type",str]];
    }
    PrimaryKeyRange * range= rangeRowQueryCriteria.range;
    NSString * strPk = [NSString stringWithFormat:@"PK.%d.",i];
    [params setObject:range.primaryKeyName forKey: [NSString stringWithFormat:@"%@Name",strPk]];
    [params setObject:[OTSUtil PrimaryKeyValueToParameterString:range.begin] forKey: [NSString stringWithFormat:@"%@RangeBegin",strPk]];
    [params setObject:[OTSUtil PrimaryKeyValueToParameterString:range.end] forKey: [NSString stringWithFormat:@"%@RangeEnd",strPk]];
    [params setObject:[OTSUtil PrimaryKeyTypeToString: range.type] forKey: [NSString stringWithFormat:@"%@RangeType",strPk]];
    int j = 1;
    
    for (NSString * strName in rangeRowQueryCriteria.columnNames) {
        NSString * str = [NSString stringWithFormat:@"Column.%d.Name",j++];
        [params setObject:strName forKey:[NSString stringWithFormat:@"%@",str]];
    }
    if (rangeRowQueryCriteria.top >= 0) {
         [params setObject:[NSString stringWithFormat:@"%d",rangeRowQueryCriteria.top] forKey:@"Top"];
    }
    if (rangeRowQueryCriteria.isReverse) {
        [params setObject:[NSString stringWithFormat:@"%@",@"TRUE"] forKey:@"IsReverse"];
    }
    else {
         [params setObject:[NSString stringWithFormat:@"%@",@"FALSE"] forKey:@"IsReverse"];
    }
    if (transactionID != nil && ![transactionID isEqualToString:@""]) {
        [params setObject:transactionID forKey:@"TransactionID"];
    }
     
    return [params autorelease];
}
-(void) putData:(NSString*) tableName  rowPutChange:(RowPutChange*) rowPutChange transactionID:(NSString*) transactionID
{
    NSAssert(!(tableName == nil),@"tableName nil");
    NSAssert(!(rowPutChange == nil),@"rowPutChange nil");
 //   NSAssert(!(transactionID == nil),@"transactionID nil");
    NSAssert(!([rowPutChange.primaryKeys count] == 0),@"MustSetPrimaryKey");
    NSString * strT = @"";
    if (transactionID != nil) {
        strT = transactionID;
    }

    NSArray *keys = [NSArray arrayWithObjects:@"method",@"transactionID",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"putData",strT, nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    OrderedDictionary * params =[self makePutDataParameters:tableName rowPutChange:rowPutChange transactionID:transactionID];
    //  
    [self invokeNoResult:@"PutData"  httpMethod:HttpMethod_POST params:params userInfo:userInfo];
  //  [params release];
    
}
-(OrderedDictionary*) makePutDataParameters:(NSString*) tableName rowPutChange:(RowPutChange*) rowPutChange transactionID:(NSString*) transactionID
{
    OrderedDictionary * params =[[OrderedDictionary alloc] initWithCapacity:2];
    [params setObject:tableName forKey:@"TableName"];
    int i = 1;
    NSEnumerator * keyEnumerator = [rowPutChange.primaryKeys keyEnumerator];
    id key;
    while (key = [keyEnumerator nextObject]) {
        PrimaryKeyValue * value = [rowPutChange.primaryKeys objectForKey:key];
        NSString * str = [NSString stringWithFormat:@"PK.%d.",i++];
        [params setObject:key forKey:[NSString stringWithFormat:@"%@Name",str]];
        [params setObject:[OTSUtil PrimaryKeyValueToParameterString:value] forKey:[NSString stringWithFormat:@"%@Value",str]];
        [params setObject:[OTSUtil PrimaryKeyTypeToString:value.type ] forKey:[NSString stringWithFormat:@"%@Type",str]];
    }
    int m = 1;
    NSEnumerator * colKeyEnumerator = [rowPutChange.attributeColumns keyEnumerator];
    id colKey;
    while (colKey = [colKeyEnumerator nextObject]) {
        ColumnValue * value = [rowPutChange.attributeColumns objectForKey:colKey];
        NSString * str3 = [NSString stringWithFormat:@"Column.%d.",m++];
        [params setObject:colKey forKey:[NSString stringWithFormat:@"%@Name",str3]];
        [params setObject:[OTSUtil ColumnValueToParameterString:value] forKey:[NSString stringWithFormat:@"%@Value",str3]];
        [params setObject:[OTSUtil ColumnTypeToString: value.type] forKey:[NSString stringWithFormat:@"%@Type",str3]];
    }
    [params setObject:[OTSUtil CheckingModeToString: rowPutChange.checking]  forKey:@"Checking"];
    if (transactionID != nil && ![transactionID isEqualToString:@""]) {
        [params setObject:transactionID forKey:@"TransactionID"];
    }
    return [params autorelease];
    
}
-(void) deleteData:(NSString*) tableName rowDeleteChange:(RowDeleteChange*) rowDeleteChange transactionID:(NSString*) transactionID
{
    NSAssert(!(tableName == nil),@"tableName nil");
    NSAssert(!(rowDeleteChange == nil),@"rowPutChange nil");
 //   NSAssert(!(transactionID == nil),@"transactionID nil");
    NSAssert(!([rowDeleteChange.primaryKeys count] == 0),@"MustSetPrimaryKey");
    NSString * strT = @"";
    if (transactionID != nil) {
        strT = transactionID;
    }

    NSArray *keys = [NSArray arrayWithObjects:@"method",@"transactionID",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"deleteData",strT, nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    OrderedDictionary * params =[self makeDeleteDataParameters:tableName rowDeleteChange:rowDeleteChange transactionID:transactionID];
    //  
    [self invokeNoResult:@"DeleteData"  httpMethod:HttpMethod_POST params:params userInfo:userInfo];
   // [params release];
}
-(OrderedDictionary*) makeDeleteDataParameters:(NSString*) tableName rowDeleteChange:(RowDeleteChange*) rowDeleteChange transactionID:(NSString*) transactionID
{
    OrderedDictionary * params =[[OrderedDictionary alloc] initWithCapacity:2];
    [params setObject:tableName forKey:@"TableName"];
    int i = 1;
    NSEnumerator * keyEnumerator = [rowDeleteChange.primaryKeys keyEnumerator];
    id key;
    while (key = [keyEnumerator nextObject]) {
        PrimaryKeyValue * value = [rowDeleteChange.primaryKeys objectForKey:key];
        NSString * str = [NSString stringWithFormat:@"PK.%d.",i++];
        [params setObject:key forKey:[NSString stringWithFormat:@"%@Name",str]];
        [params setObject:[OTSUtil PrimaryKeyValueToParameterString:value] forKey:[NSString stringWithFormat:@"%@Value",str]];
        [params setObject:[OTSUtil PrimaryKeyTypeToString:value.type ] forKey:[NSString stringWithFormat:@"%@Type",str]];
    }
    int j = 1;
    for (NSString * strName in rowDeleteChange.columnNames) {
        NSString * str = [NSString stringWithFormat:@"Column.%d.Name",j++];
        [params setObject:strName forKey:[NSString stringWithFormat:@"%@",str]];
    }
    if (transactionID != nil && ![transactionID isEqualToString:@""]) {
        [params setObject:transactionID forKey:@"TransactionID"];
    }
    return [params autorelease];
    
}
//rowChanges NSArray<RowChange>
-(void) batchModifyData:(NSString*) tableName rowChanges:(NSArray*)rowChanges  transactionID:(NSString*) transactionID
{
    NSAssert(!(tableName == nil),@"tableName nil");
    NSAssert(!(rowChanges == nil),@"rowChanges nil");
  //  NSAssert(!(transactionID == nil),@"transactionID nil");
    NSAssert(!([rowChanges count] == 0),@"RowChangesIsEmpty");
    NSString * strT = @"";
    if (transactionID != nil) {
        strT = transactionID;
    }
    NSArray *keys = [NSArray arrayWithObjects:@"method",@"transactionID",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"batchModifyData",strT, nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    OrderedDictionary * params =[self makeBatchModifyDataParameters:tableName rowChanges:rowChanges transactionID:transactionID];
    //  
    [self invokeNoResult:@"BatchModifyData"  httpMethod:HttpMethod_POST params:params userInfo:userInfo];
}
-(OrderedDictionary*) makeBatchModifyDataParameters:(NSString*) tableName rowChanges:(NSArray*)rowChanges  transactionID:(NSString*) transactionID
{
    OrderedDictionary * params =[[OrderedDictionary alloc] initWithCapacity:2];
    [params setObject:tableName forKey:@"TableName"];
    int i = 1;
    for (RowChange * rowChange in rowChanges) {
        NSAssert(!([rowChange.primaryKeys count] == 0),@"MustSetPrimaryKey");
         NSString * str = [NSString stringWithFormat:@"Modify.%d.",i++];
        [params setObject:[rowChange getModifyType] forKey:[NSString stringWithFormat:@"%@Type",str]];
        int j = 1;
        NSEnumerator * keyEnumerator = [rowChange.primaryKeys keyEnumerator];
        id key;
        while (key = [keyEnumerator nextObject]) {
            PrimaryKeyValue * value = [rowChange.primaryKeys objectForKey:key];
            NSString * str2 = [NSString stringWithFormat:@"%@PK.%d.",str,j++];
            [params setObject:key forKey:[NSString stringWithFormat:@"%@Name",str2]];
            [params setObject:[OTSUtil PrimaryKeyValueToParameterString:value] forKey:[NSString stringWithFormat:@"%@Value",str2]];
            [params setObject:[OTSUtil PrimaryKeyTypeToString:value.type ] forKey:[NSString stringWithFormat:@"%@Type",str2]];
        }
        
        if ([rowChange isKindOfClass:[RowPutChange class]]) {
            int m = 1;
            NSEnumerator * colKeyEnumerator = [((RowPutChange*)rowChange).attributeColumns keyEnumerator];
            id colKey;
            while (colKey = [colKeyEnumerator nextObject]) {
                ColumnValue * value = [((RowPutChange*)rowChange).attributeColumns objectForKey:colKey];
                NSString * str3 = [NSString stringWithFormat:@"%@Column.%d.",str,m++];
                [params setObject:colKey forKey:[NSString stringWithFormat:@"%@Name",str3]];
                [params setObject:[OTSUtil ColumnValueToParameterString:value] forKey:[NSString stringWithFormat:@"%@Value",str3]];
                [params setObject:[OTSUtil ColumnTypeToString: value.type] forKey:[NSString stringWithFormat:@"%@Type",str3]];
                 [params setObject:[OTSUtil CheckingModeToString: ((RowPutChange*)rowChange).checking]  forKey:[NSString stringWithFormat:@"%@Checking",str]];
            }
        }
        else {
            int jj = 1;
            for (NSString * strName in ((RowDeleteChange*)rowChange).columnNames) {
                NSString * str = [NSString stringWithFormat:@"Column.%d.Name",jj++];
                [params setObject:strName forKey:str];
            }
        }
        if (transactionID != nil && ![transactionID isEqualToString:@""]) {
            [params setObject:transactionID forKey:@"TransactionID"];
        }

    }
    return [params autorelease];
}
-(void)serviceClientRequestFinished:(DefaultServiceClient*)defaultServiceClient result:(id) result
{
    [super serviceClientRequestFinished:defaultServiceClient result:result];
    if([result isKindOfClass:[ResponseMessage  class]])
    {
        ResponseMessage * rm = (ResponseMessage*) result;
        
        //successed
        if ([rm isSuccessful]) 
        {
            [self sendFinishedMessage:rm];
        }
        // failed
        else 
        {
            [self sendFailedMessage:rm];
        }
    }
    // other failed
    else {
        
        [self sendInvalidNetWorkError];
    }
}
-(void) sendFinishedMessage:(ResponseMessage*) rm
{
    NSString * strMethod = nil;
    if(rm.userInfo != nil &&
       [rm.userInfo objectForKey:@"method"]!= nil)
    {
        strMethod = [rm.userInfo objectForKey:@"method"];
        if ([strMethod isEqualToString:@"fetchRow"]) {
            if ([self.delegate respondsToSelector:@selector(dataOperationFetchRowFinished:result:)])
            {
                
                Row * result = [[[Row alloc] initWithData:rm.content] autorelease];
                [self.delegate dataOperationFetchRowFinished:self result:result];                 
            }
            
        }
        if ([strMethod isEqualToString:@"fetchRowsByOffset"]) {
            if ([self.delegate respondsToSelector:@selector(dataOperationFetchRowsByOffsetFinished:result:)])
            {
                
                NSArray * result = [[[NSArray alloc] initWithXMLData:rm.content] autorelease];
                [self.delegate dataOperationFetchRowsByOffsetFinished:self result:result];
                 
            }
            
        }
        if ([strMethod isEqualToString:@"fetchRowsByRange"]) {
            if ([self.delegate respondsToSelector:@selector(dataOperationFetchRowsByRangeFinished:result:)])
            {
                
               NSArray * result = [[[NSArray alloc] initWithXMLData:rm.content] autorelease];
                [self.delegate dataOperationFetchRowsByRangeFinished:self result:result];
                 
            }
            
        }
        if ([strMethod isEqualToString:@"deleteData"]) {
            if ([self.delegate respondsToSelector:@selector(dataOperationDeleteDataFinished:result:)])
            {
                
                NSString * strResult = @"OK";
                [self.delegate dataOperationDeleteDataFinished:self result:strResult];
                 
            }
            
        }
        if ([strMethod isEqualToString:@"putData"]) {
            if ([self.delegate respondsToSelector:@selector(dataOperationPutDataFinished:result:)])
            {
                NSString * strResult = @"OK";
                [self.delegate dataOperationPutDataFinished:self result:strResult];
                 
            }
            
        }
        if ([strMethod isEqualToString:@"batchModifyData"]) {
            if ([self.delegate respondsToSelector:@selector(dataOperationBatchModifyDataFinished:result:)])
            {
                
                NSString * strResult = [rm.userInfo objectForKey:@"transactionID"];
                [self.delegate dataOperationBatchModifyDataFinished:self result:strResult];
            }
            
        }
    }
}
-(void) sendFailedMessage:(ResponseMessage*) rm
{
    NSString * strMethod = nil;
    if(rm.userInfo != nil &&
       [rm.userInfo objectForKey:@"method"]!= nil)
    {
        strMethod = [rm.userInfo objectForKey:@"method"];
        if ([strMethod isEqualToString:@"fetchRow"]) {
            if ([self.delegate respondsToSelector:@selector(dataOperationFetchRowFailed:error:)])
            {
                OTSError * error = [OTSError OTSErrorWithData:rm.content];
                [self.delegate dataOperationFetchRowFailed:self error:error];
            }
            
        }
        if ([strMethod isEqualToString:@"fetchRowsByOffset"]) {
            if ([self.delegate respondsToSelector:@selector(dataOperationFetchRowsByOffsetFailed:error:)])
            {
                OTSError * error = [OTSError OTSErrorWithData:rm.content];
                [self.delegate dataOperationFetchRowsByOffsetFailed:self error:error];
            }
            
        }
        if ([strMethod isEqualToString:@"fetchRowsByRange"]) {
            if ([self.delegate respondsToSelector:@selector(dataOperationFetchByRangeFailed:error:)])
            {
                OTSError * error = [OTSError OTSErrorWithData:rm.content];
                [self.delegate dataOperationFetchRowsByRangeFailed:self error:error];
            }
            
        }
        if ([strMethod isEqualToString:@"deleteData"]) {
            if ([self.delegate respondsToSelector:@selector(dataOperationDeleteDataFailed:error:)])
            {
                OTSError * error = [OTSError OTSErrorWithData:rm.content];
                [self.delegate dataOperationDeleteDataFailed:self error:error];
            }
            
        }
        if ([strMethod isEqualToString:@"putData"]) {
            if ([self.delegate respondsToSelector:@selector(dataOperationPutDataFailed:error:)])
            {
                OTSError * error = [OTSError OTSErrorWithData:rm.content];
                [self.delegate dataOperationPutDataFailed:self error:error];
            }
            
        }
        if ([strMethod isEqualToString:@"batchModifyData"]) {
            if ([self.delegate respondsToSelector:@selector(dataOperationBatchModifyDataFailed:error:)])
            {
                OTSError * error = [OTSError OTSErrorWithData:rm.content];
                [self.delegate dataOperationBatchModifyDataFailed:self error:error];
            }
            
        }
    }
}

-(void)serviceClientRequestFailed:(DefaultServiceClient*)defaultServiceClient error:(OSSError*) error
{
    [super serviceClientRequestFailed:defaultServiceClient error:error];
    [self sendInvalidNetWorkError];
    
}
-(void) sendInvalidNetWorkError
{ 
    if ([self.delegate respondsToSelector:@selector(dataOperationNetworkError:error:)]) 
    {
        NSString * errorCode = [OTSErrorCode OTSErrorCodeToString: OTSErrorCodeType_STORAGE_UNKNOWN_ERROR];
        OTSError * error = [OTSError OTSErrorWithErrorCode:errorCode
                                                   message:@"" 
                                                 requestId:@"" 
                                                    hostId:@""];  
        [self.delegate dataOperationNetworkError:self error:error];
        
    }
}
@end
