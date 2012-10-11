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
#import "OTSUtil.h"
#import "PrimaryKeyRange.h"
#import "PartitionKeyValue.h"
#import "RowQueryCriteria.h"

@implementation OTSUtil

+(ColumnType)ColumnTypeFromString:(NSString*)string
{
    ColumnType rtn = ColumnType_STRING;
    if ([[string uppercaseString] isEqualToString:@"STRING"]) {
        rtn = ColumnType_STRING;
    }else  if ([[string uppercaseString] isEqualToString:@"INTEGER"]){
        rtn = ColumnType_INTEGER;
    }else  if ([[string uppercaseString] isEqualToString:@"BOOLEAN"]){
        rtn = ColumnType_BOOLEAN;
    }else  if ([[string uppercaseString] isEqualToString:@"DOUBLE"]){
        rtn = ColumnType_DOUBLE;
    }
    return rtn;
}
+(NSString*)ColumnTypeToString:(ColumnType)columnType
{
    NSString * rtn = @"";
    switch (columnType) {
        case ColumnType_STRING:
        {
            rtn = @"STRING";
        }
            break;
        case ColumnType_INTEGER:
        {
            rtn = @"INTEGER";
        }
            break;
        case ColumnType_BOOLEAN:
        {
            rtn = @"BOOLEAN";
        }
            break;
        case ColumnType_DOUBLE:
        {
            rtn = @"DOUBLE";
        }
            break;
            
        default:
            break;
    }
    return rtn;
}
+(PrimaryKeyType)PrimaryKeyTypeFromString:(NSString*)string
{
    ColumnType rtn = PrimaryKeyType_STRING;
    if ([[string uppercaseString] isEqualToString:@"STRING"]) {
        rtn = PrimaryKeyType_STRING;
    }else  if ([[string uppercaseString] isEqualToString:@"INTEGER"]){
        rtn = PrimaryKeyType_INTEGER;
    }else  if ([[string uppercaseString] isEqualToString:@"BOOLEAN"]){
        rtn = PrimaryKeyType_BOOLEAN;
    }
    return rtn;
}
+(NSString*)PrimaryKeyTypeToString:(PrimaryKeyType)type
{
    NSString * rtn = @"";
    switch (type) {
        case PrimaryKeyType_STRING:
        {
            rtn = @"STRING";
        }
            break;
        case PrimaryKeyType_INTEGER:
        {
            rtn = @"INTEGER";
        }
            break;
        case PrimaryKeyType_BOOLEAN:
        {
            rtn = @"BOOLEAN";
        }
            break;
            
        default:
            break;
    }
    return rtn;
}
+(NSString*)CheckingModeToString:(CheckingMode) mode
{
    NSString * rtn = @"";
    switch (mode) {
        case CheckingMode_NO:
        {
            rtn = @"NO";
        }
            break;
        case CheckingMode_INSERT:
        {
            rtn = @"INSERT";
        }
            break;
        case CheckingMode_UPDATE:
        {
            rtn = @"UPDATE";
        }
            break;
            
        default:
            break;
    }
    return rtn;
}
+(PartitionKeyType)PartitionKeyTypeFromString:(NSString*)string
{
    PartitionKeyType rtn = PartitionKeyType_STRING;
    if ([[string uppercaseString] isEqualToString:@"STRING"]) {
        rtn = PartitionKeyType_STRING;
    }else  if ([[string uppercaseString] isEqualToString:@"INTEGER"]){
        rtn = PartitionKeyType_INTEGER;
    }
    return rtn;
}

+(NSString*)PartitionKeyTypeToString:(PartitionKeyType)type
{
    NSString * rtn = @"";
    switch (type) {
        case PartitionKeyType_STRING:
        {
            rtn = @"STRING";
        }
            break;
        case PartitionKeyType_INTEGER:
        {
            rtn = @"INTEGER";
        }

        default:
            break;
    }
    return rtn;
}

+(BOOL) nameValid:(NSString*) name
{
    if (name == nil)
    {
        return NO;
    }
    NSString * regex        = @"^[a-zA-Z_][\\w]{0,99}$";  
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];  
    BOOL isMatch            = [pred evaluateWithObject:name]; 
    return isMatch ;
}
+(BOOL)isPKInf:(PrimaryKeyValue*) value
{
    return ([value.value isEqualToString:@"INF_MAX"] ||[value.value isEqualToString:@"INF_MIN"]);
}
+(NSString*)PartitionKeyValueToParameterString:(PartitionKeyValue*)value
{
    
    if (value.type == PartitionKeyType_STRING) {
        return [NSString stringWithFormat:@"'%@'",value.value];
    }
    else
    {
        return value.value;
    }
}
+(NSString*)PrimaryKeyValueToParameterString:(PrimaryKeyValue*)value
{
    if ([OTSUtil isPKInf:value]) {
        return value.value;
    }else {
        if (value.type == PrimaryKeyType_STRING) {
            return [NSString stringWithFormat:@"'%@'",value.value];
        }
        else
        {
            return value.value;
        }
    }
    
}
+(NSString*)ColumnValueToParameterString:(ColumnValue*)value
{
    if (value.type == ColumnType_STRING) {
        return [NSString stringWithFormat:@"'%@'",value.value];
    }
    else
    {
        return value.value;
    }
}
+(int) compare:(PrimaryKeyValue*)primaryKeyValue1 primaryKeyValue2: (PrimaryKeyValue*)primaryKeyValue2
{
    if (primaryKeyValue1 == nil && primaryKeyValue2 == nil) {
        return 0;
    }
    if (primaryKeyValue1 == nil) {
        return -1;
    }
    if (primaryKeyValue2 == nil) {
        return 1;
    }
    if ([primaryKeyValue1 isEqual:[PrimaryKeyRange INF_MIN]]) {
        return [primaryKeyValue2 isEqual:[PrimaryKeyRange INF_MIN]]?0:-1;
    }
    if ([primaryKeyValue1 isEqual:[PrimaryKeyRange INF_MAX]]) {
        return [primaryKeyValue2 isEqual:[PrimaryKeyRange INF_MAX]]?0:1;
    }
    if ([primaryKeyValue2 isEqual:[PrimaryKeyRange INF_MIN]]) {
        return [primaryKeyValue1 isEqual:[PrimaryKeyRange INF_MIN]]?0:1;
    }
    if ([primaryKeyValue2 isEqual:[PrimaryKeyRange INF_MAX]]) {
        return [primaryKeyValue1 isEqual:[PrimaryKeyRange INF_MAX]]?0:-1;
    }
    if (primaryKeyValue1.type == PrimaryKeyType_INTEGER) {
        long l1 = [primaryKeyValue1 toLong];
        long l2 = [primaryKeyValue2 toLong];
        if (l1 > l2) {
            return 1;
        }
        if (l1 < l2) {
            return -1;
        }
        return 0;
    }
    if (primaryKeyValue1.type == PrimaryKeyType_BOOLEAN) {
        if ([primaryKeyValue1.value isEqualToString:primaryKeyValue2.value]) {
            return 0;
        }
        if ([primaryKeyValue1 toBool] == YES) {
            return 1;
        }
        return -1;
    }
    return (NSComparisonResult)[primaryKeyValue1.value compare:primaryKeyValue2.value];
}
+(NSString*)RowQueryCriteriaToEntityName:(RowQueryCriteria*)rowQueryCriteria
{
    NSMutableString * rtnString = [[NSMutableString alloc] initWithCapacity:50];
    [rtnString appendString:rowQueryCriteria.tableName];
    if (rowQueryCriteria.viewName != nil &&![rowQueryCriteria.viewName isEqualToString:@""] ) {
        [rtnString appendString:@"."];
        [rtnString appendString:rowQueryCriteria.viewName];
    }
    return [rtnString autorelease];
}

@end
