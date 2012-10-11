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

#import "OTSTransactionOperation.h"
#import "PartitionKeyValue.h"
#import "OTSUtil.h"
#import "ResponseMessage.h"
#import "StartTransactionResult.h"
#import "OTSErrorCode.h"
@implementation OTSTransactionOperation
@synthesize delegate;

-(void) startTransaction:(NSString*) entityName partitionKeyValue:(PartitionKeyValue *)partitionKeyValue
{
    NSAssert(!(entityName == nil),@"transactionName nil");
    NSAssert(!(partitionKeyValue == nil),@"partitionKeyValue nil");
    OrderedDictionary * params =[[OrderedDictionary alloc] initWithCapacity:2];
    [params insertObject:entityName forKey:@"EntityName" atIndex:[params count]];
    [params insertObject:[OTSUtil PartitionKeyValueToParameterString:partitionKeyValue] forKey:@"PartitionKeyValue"  atIndex:[params count]];
    [params insertObject:[OTSUtil PrimaryKeyTypeToString:partitionKeyValue.type] forKey:@"PartitionKeyType"  atIndex:[params count]];
    NSArray *keys = [NSArray arrayWithObjects:@"method",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"StartTransaction", nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    [self invokeNoResult:@"StartTransaction"  httpMethod:HttpMethod_GET params:params userInfo:userInfo];
    [params release];

}

-(void) commitTransaction:(NSString*) transactionId 
{
    NSAssert(!(transactionId == nil),@"transactionId nil");
    OrderedDictionary * params =[[OrderedDictionary alloc] initWithCapacity:2];
    [params insertObject:transactionId forKey:@"TransactionID" atIndex:[params count]];
        NSArray *keys = [NSArray arrayWithObjects:@"method",@"transactionId",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"CommitTransaction",transactionId, nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    [self invokeNoResult:@"CommitTransaction"  httpMethod:HttpMethod_GET params:params userInfo:userInfo];
    [params release];
   
}

-(void) abortTransaction:(NSString*) transactionId 
{
    NSAssert(!(transactionId == nil),@"transactionId nil");
    OrderedDictionary * params =[[OrderedDictionary alloc] initWithCapacity:2];
    [params insertObject:transactionId forKey:@"TransactionID" atIndex:[params count]];
    NSArray *keys = [NSArray arrayWithObjects:@"method",@"transactionId",nil];
    NSArray *objs = [NSArray arrayWithObjects:@"AbortTransaction",transactionId, nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    [self invokeNoResult:@"AbortTransaction"  httpMethod:HttpMethod_GET params:params userInfo:userInfo];
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
        if ([strMethod isEqualToString:@"StartTransaction"]) {
            if ([self.delegate respondsToSelector:@selector(transactionOperationStartTransactionFinished:result:)])
            {
                StartTransactionResult * result = [[[StartTransactionResult alloc] initWithData:rm.content] autorelease];
                [self.delegate transactionOperationStartTransactionFinished:self result:result.transactionID];
            }
            
        }
        if ([strMethod isEqualToString:@"CommitTransaction"]) {
            if ([self.delegate respondsToSelector:@selector(transactionOperationCommitTransactionFinished:result:)])
            {
                NSString * transactionId = [rm.userInfo objectForKey:@"transactionId"];
                [self.delegate transactionOperationCommitTransactionFinished:self result:transactionId];
            }
            
        }
        if ([strMethod isEqualToString:@"AbortTransaction"]) {
            if ([self.delegate respondsToSelector:@selector(transactionOperationAbortTransactionFinished:result:)])
            {
                NSString * transactionId = [rm.userInfo objectForKey:@"transactionId"];
                [self.delegate transactionOperationAbortTransactionFinished:self result:transactionId];
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
        if ([strMethod isEqualToString:@"StartTransaction"]) {
            if ([self.delegate respondsToSelector:@selector(transactionOperationStartTransactionFailed:error:)])
            {
                OTSError * error = [OTSError OTSErrorWithData:rm.content];
                [self.delegate transactionOperationStartTransactionFailed:self error:error];
            }
            
        }
        if ([strMethod isEqualToString:@"CommitTransaction"]) {
            if ([self.delegate respondsToSelector:@selector(transactionOperationCommitTransactionFailed:error:)])
            {
                OTSError * error = [OTSError OTSErrorWithData:rm.content];
                [self.delegate transactionOperationCommitTransactionFailed:self error:error];
            }
            
        }
        if ([strMethod isEqualToString:@"AbortTransaction"]) {
            if ([self.delegate respondsToSelector:@selector(transactionOperationAbortTransactionFailed:error:)])
            {
                OTSError * error = [OTSError OTSErrorWithData:rm.content];
                [self.delegate transactionOperationAbortTransactionFailed:self error:error];
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
    if ([self.delegate respondsToSelector:@selector(transactionOperationNetworkError:error:)]) 
    {
        NSString * errorCode = [OTSErrorCode OTSErrorCodeToString: OTSErrorCodeType_STORAGE_UNKNOWN_ERROR];
        OTSError * error = [OTSError OTSErrorWithErrorCode:errorCode
                                                   message:@"" 
                                                 requestId:@"" 
                                                    hostId:@""];  
        [self.delegate transactionOperationNetworkError:self error:error];
        
    }
}
@end
