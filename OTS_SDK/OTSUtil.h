
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
#import "ColumnType.h"
#import "PrimaryKeyValue.h"
#import "PartitionKeyType.h"
#import "PartitionKeyValue.h"
#import "ColumnValue.h"
#import "CheckingMode.h"
@class RowQueryCriteria;

/**
 OTS相关操作通用处理类
 */
@interface OTSUtil : NSObject
{
    
}
/**
 静态方法  将String转换成ColumnType类型
 @param string NSString
 */
+(ColumnType)ColumnTypeFromString:(NSString*)string;
/**
 静态方法  将ColumnType转换成String类型
 @param columnType ColumnType
 */
+(NSString*)ColumnTypeToString:(ColumnType)columnType;

/**
 静态方法  将String转换成PrimaryKeyType类型
 @param string NSString
 */
+(PrimaryKeyType)PrimaryKeyTypeFromString:(NSString*)string;
/**
 静态方法  将PrimaryKeyType转换成String类型
 @param type PrimaryKeyType
 */
+(NSString*)PrimaryKeyTypeToString:(PrimaryKeyType)type;

/**
 静态方法  将String转换成PartitionKeyType类型
 @param string NSString
 */
+(PartitionKeyType)PartitionKeyTypeFromString:(NSString*)string;
/**
 静态方法  将PartitionKeyType转换成String类型
 @param type PrimaryKeyType
 */
+(NSString*)PartitionKeyTypeToString:(PartitionKeyType)type;


/**
 静态方法  判断名字是否有效
 @param name NSString
 */
+(BOOL) nameValid:(NSString*) name;
/**
 静态方法  判断是否为主键
 @param value PrimaryKeyValue
 */
+(BOOL)isPKInf:(PrimaryKeyValue*) value;
/**
 静态方法  将PartitionKeyValue转成参数字符串
 @param value PartitionKeyValue
 */
+(NSString*)PartitionKeyValueToParameterString:(PartitionKeyValue*)value;
/**
 静态方法  将PrimaryKeyValue转成参数字符串
 @param value PrimaryKeyValue
 */
+(NSString*)PrimaryKeyValueToParameterString:(PrimaryKeyValue*)value;
/**
 静态方法  将ColumnValue转成参数字符串
 @param value ColumnValue
 */
+(NSString*)ColumnValueToParameterString:(ColumnValue*)value;
/**
 静态方法  将CheckingMode转成字符串
 @param mode CheckingMode
 */
+(NSString*)CheckingModeToString:(CheckingMode) mode;
/**
 静态方法  将RowQueryCriteria转成EntityName
 @param rowQueryCriteria RowQueryCriteria
 */
+(NSString*)RowQueryCriteriaToEntityName:(RowQueryCriteria*)rowQueryCriteria;
/**
 静态方法  比较PrimaryKeyValue
 @param primaryKeyValue1 PrimaryKeyValue
 @param primaryKeyValue2 PrimaryKeyValue
 */
+(int) compare:(PrimaryKeyValue*)primaryKeyValue1 primaryKeyValue2: (PrimaryKeyValue*)primaryKeyValue2;
@end
