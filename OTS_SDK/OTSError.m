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

#import "OTSError.h"
#import "TBXML.h"
@implementation OTSError
@synthesize errorCode = _errorCode;
@synthesize errorMessage = _errorMessage;
@synthesize errorRequestId = _errorRequestId;
@synthesize errorHostId = _errorHostId;
-(void) dealloc
{
    [_errorCode release]; _errorCode= nil;
    [_errorMessage release];_errorMessage = nil;
    [_errorRequestId release];_errorRequestId = nil;
    [_errorHostId release];_errorHostId = nil;
    [super dealloc];
}
-(id) initWithErrorCode:(NSString*) code 
                message:(NSString*) message 
              requestId:(NSString*) requestId 
                 hostId:(NSString*) hostId
{
    if (self = [super init]) {
        _errorCode = code;
        [_errorCode retain];
        _errorMessage = message;
        [_errorMessage retain];
        _errorRequestId = requestId;
        [_errorRequestId retain];
        _errorHostId = hostId;
        [_errorHostId retain];
        
    }
    return self;
}

+(id) OTSErrorWithErrorCode:(NSString*) code 
                    message:(NSString*) message 
                  requestId:(NSString*) requestId 
                     hostId:(NSString*) hostId
{
    OTSError * error = [[OTSError alloc] initWithErrorCode:code 
                                                   message:message 
                                                 requestId:requestId 
                                                    hostId:hostId];
    return [error autorelease];
}
/*
<CreateTableResult>
<Code>OK</Code>
<RequestID>261cf040-5601-74c0-42c8-17771fdf787c</RequestID>
<HostID>dGNwOi8vMTAuMjQyLjcyLjk6NDA1Nzc=</HostID>
</CreateTableResult>
 */
-(id) initWithData:(NSData *) data
{
    NSString * code = @"";
    NSString * message = @"";
    NSString * requestId = @"";
    NSString * hostId = @"";
    if (data != nil) 
    {        
        TBXML * tbxml=[[TBXML alloc]  initWithXMLData:data];
        TBXMLElement *rootXMLElement = tbxml.rootXMLElement;
        if (rootXMLElement != nil) {
            TBXMLElement *codeXMLElement = [TBXML childElementNamed:@"Code" parentElement: rootXMLElement];
            if (codeXMLElement != nil) {
                code = [TBXML textForElement:codeXMLElement];
            }
            
            TBXMLElement *messageXMLElement = [TBXML childElementNamed:@"Message" parentElement: rootXMLElement];
            if (messageXMLElement != nil) {
                message = [TBXML textForElement:messageXMLElement];
            }
            
            TBXMLElement *requestIdXMLElement = [TBXML childElementNamed:@"RequestID" parentElement: rootXMLElement];
            if (requestIdXMLElement != nil) {
                requestId = [TBXML textForElement:requestIdXMLElement]; 
            }
            
            TBXMLElement *hostIdXMLElement = [TBXML childElementNamed:@"HostID" parentElement: rootXMLElement];
            if (hostIdXMLElement != nil) {
                hostId = [TBXML textForElement:hostIdXMLElement];
            }
        }
        [tbxml release];
        tbxml = nil; 
    }
    
    if(self = [self initWithErrorCode:code 
                              message:message 
                            requestId:requestId 
                               hostId:hostId]
       )
    {
        ;
    }
    return self;
}
+(id) OTSErrorWithData:(NSData *) data
{
    OTSError * error = [[OTSError alloc] initWithData:data];
    return [error autorelease];
}
@end
