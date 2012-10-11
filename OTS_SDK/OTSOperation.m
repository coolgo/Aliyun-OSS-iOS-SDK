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
#import "ServiceCredentials.h"
#import "ExecutionContext.h"
#import "OTSRequestSigner.h"
@interface OTSOperation()<ServiceClientDelegate>
@end
@implementation OTSOperation
-(void) dealloc
{
    if(_endpoint != nil)
    {
        [_endpoint release];
        _endpoint = nil;
    }
    if(_credentials != nil)
    {
        [_credentials release];
        _credentials = nil;
    }
    if(_client != nil)
    {
        [_client release];
        _client = nil;
    }
    [super dealloc];
}
-(id) initWithEndPoint:(NSString * ) endpoint credentials:(ServiceCredentials *)credentials client:(DefaultServiceClient *)client
{
    if (self = [super init]) {
        _endpoint = endpoint;
        [_endpoint retain];
        _credentials = credentials;
        [_credentials retain];
        _client = client;
        _client.delegate = self;
        [_client retain];
    }
    return self;
}
-(void) invoke:(NSString*) otsAction  httpMethod:(HttpMethod) httpMethod params:(OrderedDictionary*)params  userInfo:(NSDictionary*)userInfo
{
    [_client sendRequest:[self buildRequest:otsAction   httpMethod:httpMethod params:params  userInfo:(NSDictionary*)userInfo] executionContext:[self createContext:otsAction]];
}
-(void) invokeNoResult:(NSString*) otsAction httpMethod:(HttpMethod) httpMethod params:(OrderedDictionary*)params  userInfo:(NSDictionary*)userInfo
{
    [_client sendRequest:[self buildRequest:otsAction  httpMethod:httpMethod params:params  userInfo:(NSDictionary*)userInfo]  executionContext:[self createContext:otsAction]];
}
-(ExecutionContext*)  createContext:(NSString *) otsAction
{
    ExecutionContext *executionContext =[[ExecutionContext alloc] init ];
    executionContext.charset = NSUTF8StringEncoding;
    OTSRequestSigner * signer = [[OTSRequestSigner alloc] initWithAction:otsAction credentials:_credentials];
    executionContext.signer = signer;
    [signer release];
    return [executionContext autorelease];
}
-(RequestMessage*)  buildRequest:(NSString *) otsAction   httpMethod: (HttpMethod) httpMethod params:(OrderedDictionary*)params  userInfo:(NSDictionary*)userInfo
{
    return[OTSOperation buildRequest:_endpoint otsAction:otsAction  httpMethod:httpMethod params:params credentials:_credentials  userInfo:(NSDictionary*)userInfo];
}
+(RequestMessage*) buildRequest:(NSString *) uri otsAction:(NSString *) otsAction   httpMethod: (HttpMethod) httpMethod params:(OrderedDictionary*)params credentials:(ServiceCredentials *)credentials userInfo:(NSDictionary*)userInfo
{
    RequestMessage *requestMessage =[[ RequestMessage alloc] init];
    requestMessage.method = httpMethod;
    requestMessage.endpoint = uri;
    requestMessage.resourcePath = otsAction;
    if (params == nil) {
        params = [OrderedDictionary dictionaryWithCapacity:10];
    }
    requestMessage.parameters = params;
    requestMessage.userInfo = userInfo;
    return [requestMessage autorelease];

}

-(void)serviceClientRequestFinished:(DefaultServiceClient*)defaultServiceClient result:(id) result
{
    
}
-(void)serviceClientRequestFailed:(DefaultServiceClient*)defaultServiceClient error:(id) error
{
    
}

@end
