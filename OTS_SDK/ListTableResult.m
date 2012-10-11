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
#import "ListTableResult.h"
#import "TBXML.h"
@implementation ListTableResult
@synthesize tableNames = _tableNames;
@synthesize requestId = _requestId;
@synthesize hostId = _hostId;

-(void) dealloc
{
    [_requestId release];_requestId = nil;
    [_hostId release];_hostId = nil;
    [_tableNames release];  _tableNames = nil;
    [super dealloc];
}
-(id) initWithRequestId:(NSString*) requestId 
                 hostId:(NSString*) hostId 
        tableNames:(NSArray  *) tableNames
{
    if (self = [super init]) {
        _requestId = requestId;
        [_requestId retain];
        _hostId = hostId;
        [_hostId retain];
        _tableNames = tableNames;
        [_tableNames retain];
        
    }
    return self;
}

+(id) ListTableGroupResultWithRequestId:(NSString*) requestId 
                                 hostId:(NSString*) hostId
                        tableNames:(NSArray  *) tableNames
{
    ListTableResult * ctr = [[ListTableResult alloc] initWithRequestId:requestId 
                                                                          hostId:hostId tableNames:tableNames];
    return [ctr autorelease];
}
 
-(id) initWithData:(NSData *) data
{
    NSString * requestId = @"";
    NSString * hostId = @"";
    NSMutableArray * names = [[NSMutableArray alloc] initWithCapacity:5];
    if (data != nil) 
    {        
        TBXML * tbxml=[[TBXML alloc]  initWithXMLData:data];
        TBXMLElement *rootXMLElement = tbxml.rootXMLElement;
        
        if (rootXMLElement != nil) {
             TBXMLElement *requestIdXMLElement = [TBXML childElementNamed:@"RequestID" parentElement: rootXMLElement];
            if (requestIdXMLElement != nil) {
                requestId = [TBXML textForElement:requestIdXMLElement]; 
            }
            
            TBXMLElement *hostIdXMLElement = [TBXML childElementNamed:@"HostID" parentElement: rootXMLElement];
            if (hostIdXMLElement != nil) {
                hostId = [TBXML textForElement:hostIdXMLElement];
            }
            TBXMLElement *tableNamesXMLElement = [TBXML childElementNamed:@"TableNames" parentElement: rootXMLElement];
            if (tableNamesXMLElement != nil) {
                TBXMLElement *tableNameXMLElement = [TBXML childElementNamed:@"TableName" parentElement:tableNamesXMLElement];
                while (tableNameXMLElement) {
                    NSString * str = [TBXML textForElement:tableNameXMLElement];
                    [names addObject:str];
                    tableNameXMLElement = [TBXML nextSiblingNamed:@"TableName" searchFromElement:tableNameXMLElement];
                }
            }
        }
        
        [tbxml release];
        tbxml = nil; 
    }
    
    if(self = [self initWithRequestId:requestId 
                               hostId:hostId tableNames:names]
       )
    {
        ;
    }
    [names release];
    return self;
}
+(id) ListTableResultWithData:(NSData *) data
{
    ListTableResult * ctr = [[ListTableResult alloc] initWithData:data];
    return [ctr autorelease];
}
@end
