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
#import "PrimaryKeyType.h"
@class PrimaryKeyValue;
/**
 PrimaryKeyRange 类
 */
@interface PrimaryKeyRange : NSObject
{
@private
    NSString *_primaryKeyName;
    PrimaryKeyValue  *_begin;
    PrimaryKeyValue  *_end;
    PrimaryKeyType _type;
}
/**
 primary Key Name
 */
@property(nonatomic,retain)NSString *primaryKeyName;
/**
 begin
 */
@property(nonatomic,retain)PrimaryKeyValue *begin;
/**
 end
 */
@property(nonatomic,retain)PrimaryKeyValue *end;
/**
 PrimaryKeyType
 */
@property(nonatomic,assign)PrimaryKeyType type;
/**
 初始化方法
 @param keyName NSString
 @param begin PrimaryKeyValue
 @param end PrimaryKeyValue
 @param type PrimaryKeyType
 */
-(id) initWithKeyName:(NSString*)keyName begin:(PrimaryKeyValue*)begin end:(PrimaryKeyValue*)end type:(PrimaryKeyType)type;
/**
  静态初始化方法 返回autorelease 对象
 @param keyName NSString
 @param begin PrimaryKeyValue
 @param end PrimaryKeyValue
 @param type PrimaryKeyType
 */
+(id) PrimaryKeyRangeWithKeyName:(NSString*)keyName begin:(PrimaryKeyValue*)begin end:(PrimaryKeyValue*)end type:(PrimaryKeyType)type;
/**
 静态方法 返回autorelease 对象
 创建INF_MAX
 */
+(PrimaryKeyValue*) INF_MAX;
/**
 静态方法 返回autorelease 对象
 创建INF_MIN
 */
+(PrimaryKeyValue*) INF_MIN;
/**
 静态方法 是否为INF_MIN 或INF_MAX
 @param value PrimaryKeyValue
 */
+(BOOL)isInf:(PrimaryKeyValue*)value;
@end
