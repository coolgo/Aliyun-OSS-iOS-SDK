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


#import "RowQueryCriteria.h"

@implementation RowQueryCriteria
@synthesize tableName = _tableName;
@synthesize viewName = _viewName;
@synthesize columnNames = _columnNames;
-(void) dealloc
{
    self.tableName = nil;
    self.viewName = nil;
    self.columnNames = nil;
    [super dealloc];
}
-(id) initWithTableName:(NSString*)tableName 
{
    if (self = [self initWithTableName:tableName viewName:@""]) {
        ;
    }
    return self;
}
-(id) initWithTableName:(NSString *)tableName viewName:(NSString *)viewName 
{
    if (self = [super init]) {
        _tableName = tableName;
        [_tableName retain];
        _viewName = viewName;
        [_viewName retain];

        _columnNames = [[NSMutableArray alloc] initWithCapacity:10];
       
    }
    return self;
}
+(id) RowQueryCriteriaWithTableName:(NSString *)tableName viewName:(NSString *)viewName 
{
    RowQueryCriteria * rqc = [[ RowQueryCriteria alloc] initWithTableName:tableName viewName:viewName];
    return [rqc autorelease];
}
-(void) addColumnName:(NSString*)columnName
{
    if(columnName != nil)
    {
        [_columnNames addObject:columnName];
    }
}
-(void) addColumnNames:(NSArray*)columnNames
{
    if(columnNames != nil)
    {
        [_columnNames addObjectsFromArray:columnNames];
    }
}
@end
