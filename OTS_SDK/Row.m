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

#import "Row.h"
#import "RowColumn.h"
#import "RowColumnValue.h"
#import "GHNSData+Base64.h"
#import "ColumnValue.h"
#import "OTSUtil.h"
#import "TBXML.h"
@interface Row()
-(void) lazyLoadResultColumns;
-(NSString*) decodeValue:(RowColumnValue*) value;
@end
@implementation Row
@synthesize columns = _columns;
@synthesize resultColumns = _resultColumns;
-(void) dealloc
{
    if (_columns != nil) {
        [_columns release];
        _columns = nil;
    }
    self.resultColumns =  nil;
    [super dealloc];
}
-(id) initWithResultColumns:(NSArray*)resultColumns
{
    if (self = [super init]) {
        _resultColumns = resultColumns;
        [_resultColumns retain];
        _columns = [[NSMutableDictionary alloc] initWithCapacity:10];
        [self lazyLoadResultColumns];
    }
    return self;
}
+(id) RowWithResultColumns:(NSArray*)resultColumns
{
    Row * row = [[Row alloc] initWithResultColumns:resultColumns];
    return [row autorelease]; 
}
-(NSMutableDictionary *)getColumns
{
    
    return  _columns;
}
-(void) lazyLoadResultColumns
{
    if (_resultColumns != nil) {
        for (RowColumn *rc in _resultColumns) {
            ColumnValue * cv = [[ColumnValue alloc] initWithType:[OTSUtil ColumnTypeFromString: rc.value.type ] value:[self decodeValue:rc.value]];
            [_columns setObject:cv forKey:rc.name];
            [cv release];
        }
        //只需运行一次即可
        [_resultColumns release];
        _resultColumns = nil;
    }
  
}
-(NSString*) decodeValue:(RowColumnValue*) value
{
    if (value.encoding == nil || [value.encoding isEqualToString:@""]) {
        return value.value;
    }
    if ([[value.value lowercaseString] isEqualToString:@"base64"]) {
        return [[value.value dataUsingEncoding:NSUTF8StringEncoding] gh_base64]; 
    }
    return value.value;

}
/*
 <GetRowResult>
 <Table name="b2">
 <Row>
 <Column>
 <Name>name</Name>
 <Value type="STRING">a</Value>
 </Column>
 <Column>
 <Name>type</Name>
 <Value type="DOUBLE">10.5</Value>
 </Column>
 <Column PK="true">
 <Name>id</Name>
 <Value type="INTEGER">3</Value>
 </Column>
 </Row>
 </Table>
 <RequestID>62a98b67-54bc-9adb-2676-407b435427ba</RequestID>
 <HostID>MTAuMjQyLjcyLjI=</HostID>
 </GetRowResult>
 */
-(id) initWithData:(NSData*) data
{
   // NSString *tableName = @"";
    NSMutableArray* resultColumns = [[NSMutableArray alloc] initWithCapacity:5];
    if (data != nil) 
    {        
        TBXML * tbxml=[[TBXML alloc]  initWithXMLData:data];
        TBXMLElement *rootXMLElement = tbxml.rootXMLElement;
        if (rootXMLElement != nil) {
            
            TBXMLElement *tableXMLElement = [TBXML childElementNamed:@"Table" parentElement: rootXMLElement];
            /*
           tableName = [TBXML valueOfAttributeNamed:@"name" forElement:tableXMLElement]; 
            */
             TBXMLElement * rowXMLElement = [TBXML childElementNamed:@"Row" parentElement: tableXMLElement];
            TBXMLElement * colXMLElement = [TBXML childElementNamed:@"Column" parentElement: rowXMLElement];

            while(colXMLElement)
            {
                NSString * strName = @"";
                NSString * strType = @"";
                NSString * strValue = @"";
                TBXMLElement * nameXMLElement = [TBXML childElementNamed:@"Name" parentElement: colXMLElement];
                if (nameXMLElement != nil) {
                    strName = [TBXML textForElement:nameXMLElement];
                }
                TBXMLElement * valueXMLElement = [TBXML childElementNamed:@"Name" parentElement: colXMLElement];
                if (valueXMLElement != nil) {
                    strValue = [TBXML textForElement:valueXMLElement];
                    strType = [TBXML valueOfAttributeNamed:@"type" forElement:tableXMLElement];
                }
                RowColumnValue * value = [[RowColumnValue alloc] initWithType:strType encoding:@"UTF-8" value:strValue];
                RowColumn * rc = [[RowColumn alloc] initWithName:strName value:value];
                [value release];
                [resultColumns addObject:rc];
                [rc release];
                colXMLElement = [TBXML nextSiblingNamed:@"Column" searchFromElement:colXMLElement];
            }
           

        }
        [tbxml release];
        tbxml = nil;
        if (self = [self initWithResultColumns:resultColumns]) {
            ;
        }        
    }
    [resultColumns release];
    return self;
}
@end
