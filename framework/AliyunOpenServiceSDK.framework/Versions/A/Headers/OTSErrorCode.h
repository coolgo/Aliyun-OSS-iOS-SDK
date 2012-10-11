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

/**
 OTSErrorCodeType枚举类型，定义错误码
 */

typedef enum
{
    OTSErrorCodeType_AUTHORIZATION_FAILURE = 5999,
    OTSErrorCodeType_INVALID_PARAMETER = 6000,
    OTSErrorCodeType_QUOTA_EXHAUSTED  =   6002,
    OTSErrorCodeType_STORAGE_DATA_OUT_OF_RANGE =6003,
    OTSErrorCodeType_STORAGE_INTERNAL_ERROR =6004,
    OTSErrorCodeType_STORAGE_INVALID_PRIMARY_KEY= 6005,
    OTSErrorCodeType_STORAGE_OBJECT_ALREAY_EXIST= 6006,
    OTSErrorCodeType_STORAGE_OBJECT_NOT_EXIST =6007,
    OTSErrorCodeType_STORAGE_PARAMETER_INVALID =6008,
    OTSErrorCodeType_STORAGE_PARTITION_NOT_READY = 6009,
    OTSErrorCodeType_STORAGE_PRIMARY_KEY_ALREADY_EXIST = 6010,
    OTSErrorCodeType_STORAGE_PRIMARY_KEY_NOT_EXIST = 60011,
    OTSErrorCodeType_STORAGE_SERVER_BUSY = 6012,
    OTSErrorCodeType_STORAGE_SESSION_NOT_EXIST = 6013,
    OTSErrorCodeType_STORAGE_TIMEOUT = 6014,
    OTSErrorCodeType_STORAGE_TRANSACTION_LOCK_KEY_FAIL = 6015,
    OTSErrorCodeType_STORAGE_UNKNOWN_ERROR = 6016,
    OTSErrorCodeType_STORAGE_VIEW_INCOMPLETE_PRIMARY_KEY = 6017,
    OTSErrorCodeType_UNMATCHED_META = 6018,
    OTSErrorCodeType_INTERNAL_SERVER_ERROR = 6019

}OTSErrorCodeType;
/**
 OTSErrorCode类，处理错误码相关操作
 */
@interface OTSErrorCode : NSObject
{
    
}
/**
 静态方法，错误码转成成对应的字符串
 @param errorCodeType OTSErrorCodeType
 */
+(NSString*) OTSErrorCodeToString:(OTSErrorCodeType)errorCodeType;
/**
 静态方法，字符串转成成对应的错误码
 @param strErrorCodeType NSString
 */
+(OTSErrorCodeType)OTSErrorCodeFromString:(NSString*)strErrorCodeType;
@end

