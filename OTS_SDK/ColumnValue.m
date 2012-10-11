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


#import "ColumnValue.h"

@implementation ColumnValue
@synthesize type = _type;
@synthesize value = _value;
-(void) dealloc
{
    self.value = nil;
    [super dealloc];
}
-(id) initWithType:(ColumnType)type value:(NSString *)value
{
    if (self = [super init]) {
        _type = type;
        _value = value;
        [_value retain];
    }
    return  self;
}
+(id)ColumnValueWithType:(ColumnType)type value:(NSString *)value
{
    ColumnValue * cv = [[ColumnValue alloc] initWithType:type value:value];
    return [cv autorelease];
}
+(id)ColumnValueWithLong:(long)value
{
    ColumnValue * cv = [[ColumnValue alloc] initWithType:ColumnType_INTEGER value:[NSString stringWithFormat:@"%ld",value]];
    return [cv autorelease];
}
+(id)ColumnValueWithDouble:(double)value
{
    ColumnValue * cv = [[ColumnValue alloc] initWithType:ColumnType_DOUBLE value:[NSString stringWithFormat:@"%lf",value]];
    return [cv autorelease];
}
+(id)ColumnValueWithBool:(BOOL)value
{
    NSString * strValue = @"";
    if (value) {
        strValue = @"YES";
    }
    else {
        strValue = @"NO";
    }
    ColumnValue * cv = [[ColumnValue alloc] initWithType:ColumnType_BOOLEAN value:strValue];
    return [cv autorelease];
}
+(id) ColumnValueWithString:(NSString*) value
{
    ColumnValue * cv = [[ColumnValue alloc] initWithType:ColumnType_STRING value:value];
    return [cv autorelease];
}
-(long) toLong
{
    return [_value longLongValue];
}
-(double) toDouble
{
    return [_value doubleValue];
}
-(BOOL) toBool
{
    if ([_value isEqualToString:@"YES"]) {
        return YES;
    }
    else {
        return NO;
    }
}
-(NSString*) toString
{
    return _value;
}
- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[ColumnValue class]]) {
        ColumnValue *cv = (ColumnValue*)object;
        if (cv.type == _type && [_value isEqualToString:cv.value]) {
            return YES;
        }
        else {
            return NO;
        }
    }
    else {
        return NO;
    }
}
@end
