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

#import "OTSTableOperation.h"
#import "TableMeta.h"
#import "OTSUtil.h"
#import "PrimaryKeyType.h"
#import "ViewMeta.h"
#import "OTSErrorCode.h"
#import "OTSError.h"
#import "ResponseMessage.h"
#import "CreateTableResult.h"
#import "PartitionKeyType.h"
#import "CreateTableGroupResult.h"
#import "ListTableResult.h"
#import "ListTableGroupResult.h"
#import "OrderedDictionary.h"

@interface OTSTableOperation()
-(OrderedDictionary*) makeRequestParameters:(TableMeta*) tableMeta;
-(void) sendFailedMessage:(ResponseMessage*) rm;
-(void) sendFinishedMessage:(ResponseMessage*) rm;
-(void) sendInvalidNetWorkError;
@end
@implementation OTSTableOperation
@synthesize delegate;
-(void) dealloc
{
    [super dealloc];
}
-(void) createTable:(TableMeta*) tableMeta
{
    NSAssert(!(tableMeta == nil),@"tableMeta nil");
    OrderedDictionary * params =[self makeRequestParameters:tableMeta];
    NSArray *keys = [NSArray arrayWithObjects:@"method",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"CreateTable", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];

    [self invokeNoResult:@"CreateTable" httpMethod:HttpMethod_GET params:params userInfo:userInfo];
}

-(void) createTableGroup:(NSString*) name partitionKeyType:(PartitionKeyType)partitionKeyType
{
    NSAssert(!(name == nil),@"name nil");
    NSAssert([OTSUtil nameValid:name],@"name not Valid");
    OrderedDictionary * params =[[OrderedDictionary alloc] initWithCapacity:2];
    [params insertObject:name forKey:@"TableGroupName" atIndex:[params count]];
    [params insertObject:[OTSUtil PrimaryKeyTypeToString:partitionKeyType] forKey:@"PartitionKeyType"  atIndex:[params count]];
    NSArray *keys = [NSArray arrayWithObjects:@"method",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"CreateTableGroup", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    [self invokeNoResult:@"CreateTableGroup"  httpMethod:HttpMethod_GET params:params userInfo:userInfo];
    [params release];
    
}

-(void) listTableGroups
{
    NSArray *keys = [NSArray arrayWithObjects:@"method",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"ListTableGroup", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
     OrderedDictionary * params =[[OrderedDictionary alloc] initWithCapacity:2];
    [self invokeNoResult:@"ListTableGroup"  httpMethod:HttpMethod_GET params:params userInfo:userInfo];
    [params release];
}
-(void) deleteTableGroup:(NSString*)tableGroupName
{
    NSAssert(!(tableGroupName == nil),@"tableGroupName nil");
    NSAssert([OTSUtil nameValid:tableGroupName],@"tableGroupName not Valid");
    NSArray *keys = [NSArray arrayWithObjects:@"method",@"tableGroupName",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"DeleteTableGroup",tableGroupName, nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    OrderedDictionary * params =[[OrderedDictionary alloc] initWithCapacity:2];
    [params insertObject:tableGroupName forKey:@"TableGroupName"  atIndex:[params count]];
    [self invokeNoResult:@"DeleteTableGroup"  httpMethod:HttpMethod_GET params:params userInfo:userInfo];
    [params release];
}

-(void)listTables
{
    NSArray *keys = [NSArray arrayWithObjects:@"method",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"ListTable", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    OrderedDictionary * params =[[OrderedDictionary alloc] initWithCapacity:2];

    [self invokeNoResult:@"ListTable"  httpMethod:HttpMethod_GET params:params userInfo:userInfo];
    [params release];
}
/*
 CodingUtils.assertParameterNotNull(paramString, "tableName");
 OTSUtil.ensureNameValid(paramString);
 HashMap localHashMap = new HashMap();
 localHashMap.put("TableName", paramString);
 invokeNoResult("DeleteTable", HttpMethod.GET, localHashMap);
 */
-(void)deleteTable:(NSString*) tableName
{
    NSAssert(!(tableName == nil),@"tableName nil");
    NSAssert([OTSUtil nameValid:tableName],@"tableName not Valid");
    NSArray *keys = [NSArray arrayWithObjects:@"method",@"tableName",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"DeleteTable",tableName, nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    OrderedDictionary * params =[[OrderedDictionary alloc] initWithCapacity:2];
    [params insertObject:tableName forKey:@"TableName"  atIndex:[params count]];
    [self invokeNoResult:@"DeleteTable"  httpMethod:HttpMethod_GET params:params userInfo:userInfo];
    [params release];

}

-(void) featchTableMeta:(NSString*) tableName
{
    NSAssert(!(tableName == nil),@"tableName nil");
    NSAssert([OTSUtil nameValid:tableName],@"tableName not Valid");
    NSArray *keys = [NSArray arrayWithObjects:@"method",@"tableName",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"GetTableMeta",tableName, nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    OrderedDictionary * params =[[OrderedDictionary alloc] initWithCapacity:2];
    [params insertObject:tableName forKey:@"TableName"    atIndex:[params count]];
    [self invokeNoResult:@"GetTableMeta"  httpMethod:HttpMethod_GET params:params userInfo:userInfo];
    [params release];
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
        if ([strMethod isEqualToString:@"CreateTable"]) {
             if ([self.delegate respondsToSelector:@selector(tableOperationCreateTableFinished:result:)])
             {
                 CreateTableResult * result = [[[CreateTableResult alloc] initWithData:rm.content] autorelease];
                 [self.delegate tableOperationCreateTableFinished:self result:result];
             }
            
        }
        if ([strMethod isEqualToString:@"createTableGroup"]) {
            if ([self.delegate respondsToSelector:@selector(tableOperationCreateTableGroupFinished:result:)])
            {
                CreateTableGroupResult * result = [[[CreateTableGroupResult alloc] initWithData:rm.content] autorelease];
                [self.delegate tableOperationCreateTableGroupFinished:self result:result];
            }
            
        }
        if ([strMethod isEqualToString:@"ListTableGroup"]) {
            if ([self.delegate respondsToSelector:@selector(tableOperationListTableGroupFinished:result:)])
            {
                ListTableGroupResult * result = [[[ListTableGroupResult alloc] initWithData:rm.content] autorelease];
                [self.delegate tableOperationListTableGroupFinished:self result:result];
            }
            
        }
        if ([strMethod isEqualToString:@"DeleteTableGroup"]) {
            if ([self.delegate respondsToSelector:@selector(tableOperationDeleteTableGroupFinished:result:)])
            {
                NSString * strResult = [rm.userInfo objectForKey:@"tableGroupName"];
                [self.delegate tableOperationDeleteTableGroupFinished:self result:strResult];
            }
            
        }
        if ([strMethod isEqualToString:@"ListTable"]) {
            if ([self.delegate respondsToSelector:@selector(tableOperationListTablesFinished:result:)])
            {
                ListTableResult * result = [[[ListTableResult alloc] initWithData:rm.content] autorelease];
                [self.delegate tableOperationListTablesFinished:self result:result];
            }
            
        }
        if ([strMethod isEqualToString:@"DeleteTable"]) {
            if ([self.delegate respondsToSelector:@selector(tableOperationDeleteTableFinished:result:)])
            {
                NSString * strResult = [rm.userInfo objectForKey:@"tableName"];
                [self.delegate tableOperationDeleteTableFinished:self result:strResult];
            }
            
        }
        if ([strMethod isEqualToString:@"GetTableMeta"]) {
            if ([self.delegate respondsToSelector:@selector(tableOperationFetchTableMetaFinished:result:)])
            {
                TableMeta * result = [[[TableMeta alloc] initWithData:rm.content] autorelease];
                [self.delegate tableOperationFetchTableMetaFinished:self result:result];
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
        if ([strMethod isEqualToString:@"CreateTable"]) {
            if ([self.delegate respondsToSelector:@selector(tableOperationCreateTableFailed:error:)])
            {
                OTSError * error = [OTSError OTSErrorWithData:rm.content];
                [self.delegate tableOperationCreateTableFailed:self error:error];
            }
            
        }
        if ([strMethod isEqualToString:@"CreateTableGroup"]) {
            if ([self.delegate respondsToSelector:@selector(tableOperationCreateTableGroupFailed:error:)])
            {
                OTSError * error = [OTSError OTSErrorWithData:rm.content];
                [self.delegate tableOperationCreateTableGroupFailed:self error:error];
            }
            
        }
        if ([strMethod isEqualToString:@"ListTableGroup"]) {
            if ([self.delegate respondsToSelector:@selector(tableOperationListTableGroupFailed:error:)])
            {
                OTSError * error = [OTSError OTSErrorWithData:rm.content];
                [self.delegate tableOperationListTableGroupFailed:self error:error];
            }
            
        }
        if ([strMethod isEqualToString:@"DeleteTableGroup"]) {
            if ([self.delegate respondsToSelector:@selector(tableOperationDeleteTableGroupFailed:error:)])
            {
                OTSError * error = [OTSError OTSErrorWithData:rm.content];
                [self.delegate tableOperationDeleteTableGroupFailed:self error:error];
            }
            
        }
        if ([strMethod isEqualToString:@"ListTable"]) {
            if ([self.delegate respondsToSelector:@selector(tableOperationListTablesFailed:error:)])
            {
                OTSError * error = [OTSError OTSErrorWithData:rm.content];
                [self.delegate tableOperationListTablesFailed:self error:error];
            }
            
        }
        if ([strMethod isEqualToString:@"DeleteTable"]) {
            if ([self.delegate respondsToSelector:@selector(tableOperationDeleteTableFailed:error:)])
            {
                OTSError * error = [OTSError OTSErrorWithData:rm.content];
                [self.delegate tableOperationDeleteTableFailed:self error:error];
            }
            
        }
        if ([strMethod isEqualToString:@"GetTableMeta"]) {
            if ([self.delegate respondsToSelector:@selector(tableOperationFetchTableMetaFailed:error:)])
            {
                OTSError * error = [OTSError OTSErrorWithData:rm.content];
                [self.delegate tableOperationFetchTableMetaFailed:self error:error];
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
    if ([self.delegate respondsToSelector:@selector(tableOperationNetworkError:error:)]) 
    {
        NSString * errorCode = [OTSErrorCode OTSErrorCodeToString: OTSErrorCodeType_STORAGE_UNKNOWN_ERROR];
        OTSError * error = [OTSError OTSErrorWithErrorCode:errorCode
                                                   message:@"" 
                                                 requestId:@"" 
                                                    hostId:@""];  
        [self.delegate tableOperationNetworkError:self error:error];
        
    }
}
-(OrderedDictionary*) makeRequestParameters:(TableMeta*) tableMeta
{
    BOOL isVaildName = [OTSUtil nameValid:tableMeta.tableName];
    //   NSAssert(!isVaildName,@"tableName invaild");
    if (!isVaildName) {
        NSLog(@"%@",@"tableName invaild");
        return nil;
    }
    
    //   NSAssert(!([tableMeta.primaryKeys count] == 0),@"TableMetaHasNoPK");
    if ([tableMeta.primaryKeys count] == 0) {
        NSLog(@"%@",@"TableMetaHasNoPK");
        return nil;
    }
    if (tableMeta.pagingKeyLen >= [tableMeta.primaryKeys count]) {
        NSLog(@"%@",@"PagingLenNoLessThanPKCount");
        return nil;
    }
    OrderedDictionary * dict = [[OrderedDictionary alloc] initWithCapacity:5]; 
  //  [dict setObject:tableMeta.tableName forKey:@"TableName"];
    [dict insertObject:tableMeta.tableName forKey:@"TableName" atIndex:[dict count]];
    int i = 1;
    NSEnumerator * keyEnumerator = [tableMeta.primaryKeys keyEnumerator];
    id key;
    while (key = [keyEnumerator nextObject]) {
        NSString * strType = [tableMeta.primaryKeys objectForKey:key];
        NSString * str = [NSString stringWithFormat:@"PK.%d.",i++];
      //  [dict setObject:key forKey:[NSString stringWithFormat:@"%@Name",str]];
        [dict insertObject:key forKey:[NSString stringWithFormat:@"%@Name",str] atIndex:[dict count]];
     //   [dict setObject:strType forKey:[NSString stringWithFormat:@"%@Type",str]];
         [dict insertObject:strType forKey:[NSString stringWithFormat:@"%@Type",str] atIndex:[dict count]];
    }
    if (tableMeta.pagingKeyLen > 0) {
        [dict insertObject:[NSString stringWithFormat:@"%d",tableMeta.pagingKeyLen] forKey:@"PagingKeyLen"  atIndex:[dict count]];
        
    }
    int j = 1;
    
    for (ViewMeta * viewMeta in tableMeta.views) {
        NSString * str1 = [NSString stringWithFormat:@"View.%d.",j++];
        [dict insertObject:viewMeta.viewName forKey:[NSString stringWithFormat:@"%@Name",str1] atIndex:[dict count]];
        int k = 1;
        NSEnumerator * viewKeyEnumerator = [viewMeta.primaryKeys keyEnumerator];
        id viewKey;
        while (viewKey = [viewKeyEnumerator nextObject]) {
            NSString * strValue = [viewMeta.primaryKeys objectForKey:viewKey];
            NSString * str2 = [NSString stringWithFormat:@"%@PK.%d.",str1,k++];
            [dict insertObject:viewKey forKey:[NSString stringWithFormat:@"%@Name",str2] atIndex:[dict count]];
            [dict insertObject:strValue forKey:[NSString stringWithFormat:@"%@Type",str2] atIndex:[dict count]];
        }
        int m = 1;
        NSEnumerator * colKeyEnumerator = [viewMeta.attributeColumns keyEnumerator];
        id colKey;
        while (colKey = [colKeyEnumerator nextObject]) {
            NSString * strValue2 = [viewMeta.attributeColumns objectForKey:colKey];
            NSString * str3 = [NSString stringWithFormat:@"%@Column.%d.",str1,m++];
            [dict insertObject:colKey forKey:[NSString stringWithFormat:@"%@Name",str3] atIndex:[dict count]];
            [dict insertObject:strValue2 forKey:[NSString stringWithFormat:@"%@Type",str3] atIndex:[dict count]];
        }
        if (viewMeta.pagingKeyLen >0) {
            [dict insertObject:[NSString stringWithFormat:@"%d",viewMeta.pagingKeyLen] forKey:[NSString stringWithFormat:@"%@PagingKeyLen",str1] atIndex:[dict count]];
        }
    }
    if (tableMeta.tableGroupName != nil &&!([tableMeta.tableGroupName isEqualToString:@""]) ) {
        [dict insertObject:tableMeta.tableGroupName forKey:@"TableGroupName" atIndex:[dict count]];
    }
    return [dict autorelease];
}

@end
