//
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
#import "NSArray+Rows.h"
#import "TBXML.h"
#import "Row.h"
#import "RowColumnValue.h"
#import "RowColumn.h"
/*
 <GetRowsByRangeResult>
 <Table name="b2">
 <Row>
 <Column PK="true">
 <Name>id</Name>
 <Value type="INTEGER">3</Value>
 </Column>
 </Row>
 <Row>
 <Column PK="true">
 <Name>id</Name>
 <Value type="INTEGER">4</Value>
 </Column>
 </Row>
 </Table>
 <RequestID>0ea1d3d2-74fe-d1eb-0334-c1e54c1f7c31</RequestID>
 <HostID>MTAuMjQyLjc1LjE=</HostID>
 </GetRowsByRangeResult>
 */
@implementation NSArray (Rows)
-(id) initWithXMLData:(NSData*)data
{
  //  NSString *tableName = @"";
    NSMutableArray* innerColumns = [[NSMutableArray alloc] initWithCapacity:5];
    if (data != nil) 
    {        
        TBXML * tbxml=[[TBXML alloc]  initWithXMLData:data];
        TBXMLElement *rootXMLElement = tbxml.rootXMLElement;
        if (rootXMLElement != nil) 
        {
            TBXMLElement *tableXMLElement = [TBXML childElementNamed:@"Table" parentElement: rootXMLElement];
           /*
            tableName = [TBXML valueOfAttributeNamed:@"name" forElement:tableXMLElement]; 
            */
            TBXMLElement * rowXMLElement = [TBXML childElementNamed:@"Row" parentElement: tableXMLElement];
            while (rowXMLElement) 
            {
                NSMutableArray* resultColumns = [[NSMutableArray alloc] initWithCapacity:5];
                
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
                Row * row = [[Row alloc] initWithResultColumns:resultColumns];
                [resultColumns release];
                [innerColumns addObject:row];
                [row release];
                rowXMLElement = [TBXML nextSiblingNamed:@"Row" searchFromElement:rowXMLElement];
            }
        }
        [tbxml release];
        tbxml = nil;
    }
    if (self = [self initWithArray:innerColumns]) {
        ;
    }
    [innerColumns release];
    return self;
}
@end
