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

#import "CreateTableResult.h"
#import "TBXML.h"
@implementation CreateTableResult
@synthesize code = _code;
@synthesize requestId = _requestId;
@synthesize hostId = _hostId;
-(void) dealloc
{
    [_code release]; _code= nil;
    [_requestId release];_requestId = nil;
    [_hostId release];_hostId = nil;
    [super dealloc];
}
-(id) initWithCode:(NSString*) code 
              requestId:(NSString*) requestId 
                 hostId:(NSString*) hostId
{
    if (self = [super init]) {
        _code = code;
        [_code retain];
        _requestId = requestId;
        [_requestId retain];
        _hostId = hostId;
        [_hostId retain];
        
    }
    return self;
}

+(id) CreateTableResultWithCode:(NSString*) code 
                  requestId:(NSString*) requestId 
                     hostId:(NSString*) hostId
{
    CreateTableResult * ctr = [[CreateTableResult alloc] initWithCode:code 
                                                 requestId:requestId 
                                                    hostId:hostId];
    return [ctr autorelease];
}
-(id) initWithData:(NSData *) data
{
    NSString * code = @"";
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
    
    if(self = [self initWithCode:code 
                            requestId:requestId 
                               hostId:hostId]
       )
    {
        ;
    }
    return self;
}
+(id) CreateTableResultWithData:(NSData *) data
{
    CreateTableResult * ctr = [[CreateTableResult alloc] initWithData:data];
    return [ctr autorelease];
}
@end
