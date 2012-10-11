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

#import <Foundation/Foundation.h>
#import "ColumnType.h"
/**
 ColumnValue 类，列值
 */
@interface ColumnValue : NSObject
{
@private
    ColumnType _type;
    NSString *_value;
}
/**
 列类型
 */
@property(nonatomic,assign)ColumnType type;
/**
 列值
 */
@property(nonatomic,retain)NSString *value;
/**
 初始化方法
 @param type ColumnType
 @param value NSString
 */
-(id) initWithType:(ColumnType) type value:(NSString*) value;
/**
 静态初始化方法 返回autorelease 对象
 @param type ColumnType
 @param value NSString
 */
+(id) ColumnValueWithType:(ColumnType) type value:(NSString*) value;
/**
 静态初始化方法 返回autorelease 对象
 @param value long
 */
+(id) ColumnValueWithLong:(long) value;
/**
 静态初始化方法 返回autorelease 对象
 @param value BOOL
 */
+(id) ColumnValueWithBool:(BOOL) value;
/**
 静态初始化方法 返回autorelease 对象
 @param value double
 */
+(id) ColumnValueWithDouble:(double) value;
/**
 静态初始化方法 返回autorelease 对象
 @param value NSString
 */
+(id) ColumnValueWithString:(NSString*) value;
/**
 返回long类型值
 */
-(long) toLong;
/**
 返回BOOL类型值
 */
-(BOOL) toBool;
/**
 返回double类型值
 */
-(double) toDouble;
/**
 返回String类型值
 */
-(NSString*) toString;
@end
