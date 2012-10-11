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
#import "OTSRequestSigner.h"
#import "ServiceCredentials.h"
#import "RequestMessage.h"
#import "DateUtil.h"
#import "HmacSHA1Signature.h"
#import "HttpUtil.h"
#import "GHNSData+Base64.h"
@interface OTSRequestSigner()
-(void) addRequiredParameters:(NSMutableDictionary*)params credentials:(ServiceCredentials*) credentials;
-(void) addSignature:(NSString*)otsAction params:(NSMutableDictionary*)params credentials:(ServiceCredentials *)credentials;
-(NSString*)getSignature:(NSString*) otsAction  params:(NSMutableDictionary*)params credentials:(ServiceCredentials*) credentials;
@end
@implementation OTSRequestSigner
-(void) dealloc
{
    if (_otsAction != nil) {
        [_otsAction release];
        _otsAction = nil;
    }
    if (_credentials != nil) {
        [_credentials release];
        _credentials = nil;
    }
    [super dealloc];
}
-(id) initWithAction:(NSString*)otsAction credentials:(ServiceCredentials *)credentials
{
    if (self = [super init]) {
        _otsAction = otsAction;
        [_otsAction retain]; 
        _credentials = credentials;
        [_credentials retain];
    }
    return self;
}
-(void) sign:(RequestMessage*) requestMessage
{
    [self addRequiredParameters:requestMessage.parameters credentials:_credentials];
    [self addSignature:_otsAction params:requestMessage.parameters credentials:_credentials];
}
-(void) addSignature:(NSString*)otsAction params:(NSMutableDictionary*)params credentials:(ServiceCredentials *)credentials 
{
    [params setObject:[self getSignature:otsAction params:params credentials:credentials] forKey:@"Signature"];
}

-(void) addRequiredParameters:(NSMutableDictionary*)params credentials:(ServiceCredentials*) credentials
{
    if (params == nil) {
        params = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    HmacSHA1Signature  * signer = [HmacSHA1Signature defaultHmacSHA1Signature];
    [params  setObject:[DateUtil formatRfc822Date:[NSDate date]] forKey:@"Date"];
    [params  setObject:credentials.accessID forKey:@"OTSAccessKeyId"];
    [params  setObject:@"1" forKey:@"APIVersion"];
    [params  setObject:[signer getAlgorithm] forKey:@"SignatureMethod"];
    [params  setObject:[signer getVersion] forKey:@"SignatureVersion"];
}
-(NSString*)getSignature:(NSString*) otsAction  params:(NSMutableDictionary*)params credentials:(ServiceCredentials*) credentials
{
   // HttpUtil 
    
    NSString * string = [NSString stringWithFormat:@"/%@\n%@",otsAction,[HttpUtil  paramToQueryString:params encoding:NSUTF8StringEncoding] ];
     
     HmacSHA1Signature  * signer = [HmacSHA1Signature defaultHmacSHA1Signature];
    NSString * strRtn =   [signer computeSignature:string withSecret:credentials.accessKey];
 //   NSLog(@"%@",string);
 //   NSLog(@"%@",strRtn);
  //  return [[strRtn dataUsingEncoding:NSUTF8StringEncoding ] gh_base64];
    return strRtn;
}


@end
