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


#import "PrimaryKeyRange.h"
#import "PrimaryKeyValue.h"
@implementation PrimaryKeyRange
@synthesize primaryKeyName = _primaryKeyName;
@synthesize begin = _begin;
@synthesize end = _end;
@synthesize type = _type;
-(void) dealloc
{
    self.primaryKeyName = nil;
    self.begin = nil;
    self.end = nil;
    [super dealloc];
}
-(id) initWithKeyName:(NSString*)keyName begin:(PrimaryKeyValue*)begin end:(PrimaryKeyValue*)end type:(PrimaryKeyType)type
{
    NSAssert(!(keyName == nil),@"keyName nil");
    NSAssert(!(begin == nil),@"begin nil");
    NSAssert(!(end == nil),@"end nil");
    if ([PrimaryKeyRange isInf:begin] && begin.type != type) {
        NSLog(@"%@",@"begin的数据类型应与type给定的一致。");
    }
    if ([PrimaryKeyRange isInf:end] && end.type != type) {
        NSLog(@"%@",@"end的数据类型应与type给定的一致。");
    }
    if (self = [super init]) {
        _primaryKeyName = keyName;
        [_primaryKeyName retain];
        _begin = begin;
        [_begin retain];
        _end = end;
        [_end retain];
        _type = type;
        
    }
    return self;
}
+(id) PrimaryKeyRangeWithKeyName:(NSString*)keyName begin:(PrimaryKeyValue*)begin end:(PrimaryKeyValue*)end type:(PrimaryKeyType)type
{
    PrimaryKeyRange * pkr = [[PrimaryKeyRange alloc] initWithKeyName:keyName begin:begin end:end type:type];
    return [pkr autorelease];
}
+(PrimaryKeyValue*) INF_MAX
{
    PrimaryKeyValue * pkv = [[PrimaryKeyValue alloc] initWithType:PrimaryKeyType_STRING value:@"INF_MAX"];
    return [pkv autorelease];
}
+(PrimaryKeyValue*) INF_MIN
{
    PrimaryKeyValue * pkv = [[PrimaryKeyValue alloc] initWithType:PrimaryKeyType_STRING value:@"INF_MIN"];
    return [pkv autorelease];
}
+(BOOL)isInf:(PrimaryKeyValue*)value
{
    return ([value.value isEqualToString:@"INF_MAX"] ||[value.value isEqualToString:@"INF_MIN"]);
}
@end
