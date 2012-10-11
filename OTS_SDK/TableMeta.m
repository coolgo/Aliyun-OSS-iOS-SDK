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

#import "TableMeta.h"
#import "ViewMeta.h"
#import "OTSUtil.h"
#import "PrimaryKey.h"
#import "TBXML.h"
@interface TableMeta()
-(void) loadResultPrimaryKey;
@end
@implementation TableMeta
@synthesize tableName = _tableName;
@synthesize tableGroupName = _tableGroupName;
@synthesize pagingKeyLen = _pagingKeyLen;
@synthesize primaryKeys = _primaryKeys;
@synthesize views = _views;
-(void) dealloc
{
    self.tableName = nil;
    self.tableGroupName = nil;
    if (_primaryKeys != nil) {
        [_primaryKeys release];
        _primaryKeys = nil;
    }
    if (_views != nil) {
        [_views release];
        _views = nil;
    }
    [super dealloc];
}
-(id) initWithTableName:(NSString *)tableName resultPrimaryKeys:(NSMutableArray *)resultPrimaryKeys
{
    if (self = [super init]) {
        _tableName = tableName;
        [_tableName retain];
        _resultPrimaryKeys = resultPrimaryKeys;
        [_resultPrimaryKeys retain];
        _primaryKeys = [[NSMutableDictionary alloc] initWithCapacity:5];
        _views = [[NSMutableArray alloc] initWithCapacity:5];
        [self loadResultPrimaryKey];
    }
    return self;
}

-(NSMutableDictionary*) getPrimaryKeys
{
    
    return _primaryKeys;
}
-(void) addPrimaryKey:(NSString*) key type:(PrimaryKeyType) type
{
    if (key != nil &&[OTSUtil nameValid:key]) {
        [_primaryKeys setObject:[OTSUtil PrimaryKeyTypeToString:type] forKey:key];
    }
}
-(void) addView:(ViewMeta*) viewMeta
{
    if (viewMeta != nil) {
        [_views addObject:viewMeta];
    }
}
-(void) loadResultPrimaryKey
{
    if (_resultPrimaryKeys != nil) {
        for(PrimaryKey * key in _resultPrimaryKeys)
        {
            [_primaryKeys setObject:key.type forKey:key.name];
        }
        [_resultPrimaryKeys release];
        _resultPrimaryKeys = nil;
    }
}
/*
 <GetTableMetaResult>
 <TableMeta>
 <TableName>ttytwqtt22</TableName>
 <PrimaryKey>
 <Name>id</Name>
 <Type>INTEGER</Type>
 </PrimaryKey>
 <PrimaryKey>
 <Name>Name</Name>
 <Type>STRING</Type>
 </PrimaryKey>
 <PagingKeyLen>0</PagingKeyLen>
 <View>
 <Name>ttyt22ggtt22</Name>
 <PrimaryKey>
 <Name>id</Name>
 <Type>INTEGER</Type>
 </PrimaryKey>
 <PrimaryKey>
 <Name>Name</Name>
 <Type>STRING</Type>
 </PrimaryKey>
 <PagingKeyLen>0</PagingKeyLen>
 </View>
 </TableMeta>
 <RequestID>5226a9c5-64a8-57ad-33d3-96bb5d334ef4</RequestID>
 <HostID>MTAuMjQyLjY4LjUz</HostID>
 </GetTableMetaResult>
 */
-(id) initWithData:(NSData *) data
{
    NSString *tableName = @"";
    NSString *tableGroupName = @"";
    int pagingKeyLen = 0;
    NSMutableArray *resultPrimaryKeys =[[NSMutableArray alloc] initWithCapacity:5] ;
    NSMutableArray *views = [[NSMutableArray alloc] initWithCapacity:5] ;
    if (data != nil) 
    {        
        TBXML * tbxml=[[TBXML alloc]  initWithXMLData:data];
        TBXMLElement *rootXMLElement = tbxml.rootXMLElement;
        if (rootXMLElement != nil) {
            TBXMLElement *tableMetaXMLElement = [TBXML childElementNamed:@"TableMeta" parentElement: rootXMLElement];
           
            if(tableMetaXMLElement != nil)
            {
                TBXMLElement *tableNameXMLElement = [TBXML childElementNamed:@"TableName" parentElement: tableMetaXMLElement];
                if (tableNameXMLElement != nil) {
                    tableName = [TBXML textForElement:tableNameXMLElement]; 
                }
                TBXMLElement *tableGroupNameXMLElement = [TBXML childElementNamed:@"TableGroupName" parentElement: tableMetaXMLElement];
                if (tableGroupNameXMLElement != nil) {
                    tableGroupName = [TBXML textForElement:tableGroupNameXMLElement]; 
                }
                TBXMLElement *primaryKeyXMLElement = [TBXML childElementNamed:@"PrimaryKey" parentElement: tableMetaXMLElement];
                while (primaryKeyXMLElement) {
                    NSString * name = @"";
                    NSString * type = @"";
                    TBXMLElement *nameXMLElement = [TBXML childElementNamed:@"Name" parentElement: primaryKeyXMLElement];
                    if (nameXMLElement != nil) {
                        name = [TBXML textForElement:nameXMLElement]; 
                    }
                    TBXMLElement *typeXMLElement = [TBXML childElementNamed:@"Type" parentElement: primaryKeyXMLElement];
                    if (typeXMLElement != nil) {
                        type = [TBXML textForElement:typeXMLElement]; 
                    }
                    PrimaryKey * pk = [[PrimaryKey alloc] initWithName:name Type:type];
                    [resultPrimaryKeys addObject:pk];
                    [pk release];
                    primaryKeyXMLElement = [TBXML nextSiblingNamed:@"PrimaryKey" searchFromElement:primaryKeyXMLElement];
                }
                TBXMLElement *pagingKeyLenXMLElement = [TBXML childElementNamed:@"PagingKeyLen" parentElement: tableMetaXMLElement];
                if (pagingKeyLenXMLElement != nil) {
                    pagingKeyLen = [[TBXML textForElement:pagingKeyLenXMLElement] intValue]; 
                }
                TBXMLElement *vieweXMLElement = [TBXML childElementNamed:@"View" parentElement: tableMetaXMLElement];
                while(vieweXMLElement) {
                    NSString *vieweName = @"";
                    int viewPagingKeyLen = 0;
                   NSMutableArray *viewResultPrimaryKeys =[[NSMutableArray alloc] initWithCapacity:5] ;
                    TBXMLElement *viewNameXMLElement = [TBXML childElementNamed:@"Name" parentElement: vieweXMLElement];
                    if (viewNameXMLElement != nil) {
                        vieweName = [TBXML textForElement:viewNameXMLElement]; 
                    }
                    TBXMLElement *primaryKeyXMLElement = [TBXML childElementNamed:@"PrimaryKey" parentElement: vieweXMLElement];
                    while (primaryKeyXMLElement) {
                        NSString * name = @"";
                        NSString * type = @"";
                        TBXMLElement *nameXMLElement = [TBXML childElementNamed:@"Name" parentElement: primaryKeyXMLElement];
                        if (nameXMLElement != nil) {
                            name = [TBXML textForElement:nameXMLElement]; 
                        }
                        TBXMLElement *typeXMLElement = [TBXML childElementNamed:@"Type" parentElement: primaryKeyXMLElement];
                        if (typeXMLElement != nil) {
                            type = [TBXML textForElement:typeXMLElement]; 
                        }
                        PrimaryKey * pk = [[PrimaryKey alloc] initWithName:name Type:type];
                        [viewResultPrimaryKeys addObject:pk];
                        [pk release];
                        primaryKeyXMLElement = [TBXML nextSiblingNamed:@"PrimaryKey" searchFromElement:primaryKeyXMLElement];
                        
                    }
                    TBXMLElement *pagingKeyLenXMLElement = [TBXML childElementNamed:@"PagingKeyLen" parentElement: vieweXMLElement];
                    if (pagingKeyLenXMLElement != nil) {
                        viewPagingKeyLen = [[TBXML textForElement:pagingKeyLenXMLElement] intValue]; 
                    }
                    ViewMeta * vm = [[ViewMeta alloc] initWithViewName:vieweName resultPrimaryKeys:viewResultPrimaryKeys resultAttributeColumns:nil];
                    [viewResultPrimaryKeys release];
                    vm.pagingKeyLen = viewPagingKeyLen;
                    [views addObject:vm];
                    [vm release];
                    vieweXMLElement = [TBXML nextSiblingNamed:@"View" searchFromElement:vieweXMLElement];
                }
                
            }
           
        }
        [tbxml release];
        tbxml = nil; 
    }
    
    if(self = [self initWithTableName:tableName resultPrimaryKeys:resultPrimaryKeys]
       )
    {
        self.tableGroupName = tableGroupName;
        if (_views != nil) {
            [_views release];
            _views = nil;
        }
        _views = views;
        [_views retain];
        self.pagingKeyLen = pagingKeyLen;
    }
    [resultPrimaryKeys release];
    [views release];
    return self;
}

+(id) TableMetaWithData:(NSData *) data
{
    TableMeta * tm = [[TableMeta alloc] initWithData:data];
    return [tm autorelease];
}
@end
