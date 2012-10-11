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
/*
 
 */
#import "OTSErrorCode.h"

@implementation OTSErrorCode
+(NSString*) OTSErrorCodeToString:(OTSErrorCodeType)errorCodeType
{
  
    
    NSString * string = @"";
    switch (errorCodeType) {

        case OTSErrorCodeType_AUTHORIZATION_FAILURE:
        {
            string = @"OTSAuthFailed";
        }
            break;
        case OTSErrorCodeType_INVALID_PARAMETER:
        {
            string = @"OTSParameterInvalid";
        }
            break;
        case OTSErrorCodeType_QUOTA_EXHAUSTED:
        {
            string = @"OTSQuotaExhausted";
        }
            break;
        case OTSErrorCodeType_STORAGE_DATA_OUT_OF_RANGE:
        {
            string = @"OTSStorageDataOutOfRange";
        }
            break;
        case OTSErrorCodeType_STORAGE_INTERNAL_ERROR:
        {
            string = @"OTSStorageInternalError";
        }
            break;
        case OTSErrorCodeType_STORAGE_INVALID_PRIMARY_KEY:
        {
            string = @"OTSStorageInvalidPK";
        }
            break;
       
        case OTSErrorCodeType_STORAGE_OBJECT_ALREAY_EXIST:
        {
            string = @"OTSStorageObjectAlreadyExist";
        }
            break;
        case OTSErrorCodeType_STORAGE_OBJECT_NOT_EXIST:
        {
            string = @"OTSStorageObjectNotExist";
        }
            break;
        case OTSErrorCodeType_STORAGE_PARAMETER_INVALID:
        {
            string = @"OTSStorageParameterInvalid";
        }
            break;
        case OTSErrorCodeType_STORAGE_PARTITION_NOT_READY:
        {
            string = @"OTSStoragePartitionNotReady";
        }
            break;
        case OTSErrorCodeType_STORAGE_PRIMARY_KEY_ALREADY_EXIST:
        {
            string = @"OTSStoragePrimaryKeyAlreadyExist";
        }
            break;
        case OTSErrorCodeType_STORAGE_PRIMARY_KEY_NOT_EXIST:
        {
            string = @"OTSStoragePrimaryKeyNotExist";
        }
            break;
        case OTSErrorCodeType_STORAGE_SERVER_BUSY:
        {
            string = @"OTSStorageServerBusy";
        }
            break;
        case OTSErrorCodeType_STORAGE_SESSION_NOT_EXIST:
        {
            string = @"OTSStorageSessionNotExist";
        }
            break;
        case OTSErrorCodeType_STORAGE_TIMEOUT:
        {
            string = @"OTSStorageTimeout";
        }
            break;
        case OTSErrorCodeType_STORAGE_TRANSACTION_LOCK_KEY_FAIL:
        {
            string = @"OTSStorageTxnLockKeyFail";
        }
            break;
        case OTSErrorCodeType_STORAGE_UNKNOWN_ERROR:
        {
            string = @"OTSStorageUnknownError";
        }
            break;
        case OTSErrorCodeType_STORAGE_VIEW_INCOMPLETE_PRIMARY_KEY:
        {
            string = @"OTSStorageViewIncompletePK";
        }
            break;
        case OTSErrorCodeType_UNMATCHED_META:
        {
            string = @"OTSMetaNotMatch";
        }
            break;
        case OTSErrorCodeType_INTERNAL_SERVER_ERROR:
        {
            string = @"OTSInternalServerError";
        }
            break;
           
        default:
            break;
    }
    return string;
}

+(OTSErrorCodeType)OTSErrorCodeFromString:(NSString*)strErrorCodeType
{
    OTSErrorCodeType type = OTSErrorCodeType_STORAGE_UNKNOWN_ERROR;
    if ([strErrorCodeType isEqualToString: @"OTSAuthFailed"]) {
        type = OTSErrorCodeType_AUTHORIZATION_FAILURE;
    }else if ([strErrorCodeType isEqualToString: @"OTSInternalServerError"]) {
        type = OTSErrorCodeType_INTERNAL_SERVER_ERROR;
    }else if ([strErrorCodeType isEqualToString: @"OTSParameterInvalid"]) {
        type = OTSErrorCodeType_INVALID_PARAMETER;
    }else if ([strErrorCodeType isEqualToString: @"OTSQuotaExhausted"]) {
        type = OTSErrorCodeType_QUOTA_EXHAUSTED;
    }else if ([strErrorCodeType isEqualToString: @"OTSStorageDataOutOfRange"]) {
        type = OTSErrorCodeType_STORAGE_DATA_OUT_OF_RANGE;
    }else if ([strErrorCodeType isEqualToString: @"OTSStorageInternalError"]) {
        type = OTSErrorCodeType_STORAGE_INTERNAL_ERROR;
    }else if ([strErrorCodeType isEqualToString: @"OTSStorageInvalidPK"]) {
        type = OTSErrorCodeType_STORAGE_INVALID_PRIMARY_KEY;
    }else if ([strErrorCodeType isEqualToString: @"OTSStorageObjectAlreadyExist"]) {
        type = OTSErrorCodeType_STORAGE_OBJECT_ALREAY_EXIST;
    }else if ([strErrorCodeType isEqualToString: @"OTSStorageObjectNotExist"]) {
        type = OTSErrorCodeType_STORAGE_OBJECT_NOT_EXIST;
    }else if ([strErrorCodeType isEqualToString: @"OTSStorageParameterInvalid"]) {
        type = OTSErrorCodeType_STORAGE_PARAMETER_INVALID;
    }else if ([strErrorCodeType isEqualToString: @"OTSStoragePartitionNotReady"]) {
        type = OTSErrorCodeType_STORAGE_PARTITION_NOT_READY;
    }else if ([strErrorCodeType isEqualToString: @"OTSStoragePrimaryKeyAlreadyExist"]) {
        type = OTSErrorCodeType_STORAGE_PRIMARY_KEY_ALREADY_EXIST;
    }else if ([strErrorCodeType isEqualToString: @"OTSStoragePrimaryKeyNotExist"]) {
        type = OTSErrorCodeType_STORAGE_PRIMARY_KEY_NOT_EXIST;
    }else if ([strErrorCodeType isEqualToString: @"OTSStorageServerBusy"]) {
        type = OTSErrorCodeType_STORAGE_SERVER_BUSY;
    }else if ([strErrorCodeType isEqualToString: @"OTSStorageSessionNotExist"]) {
        type = OTSErrorCodeType_STORAGE_SESSION_NOT_EXIST;
    }else if ([strErrorCodeType isEqualToString: @"OTSStorageTimeout"]) {
        type = OTSErrorCodeType_STORAGE_TIMEOUT;
    }else if ([strErrorCodeType isEqualToString: @"OTSStorageTxnLockKeyFail"]) {
        type = OTSErrorCodeType_STORAGE_TRANSACTION_LOCK_KEY_FAIL;
    }else if ([strErrorCodeType isEqualToString: @"OTSStorageUnknownError"]) {
        type = OTSErrorCodeType_STORAGE_UNKNOWN_ERROR;
    }else if ([strErrorCodeType isEqualToString: @"OTSStorageViewIncompletePK"]) {
        type = OTSErrorCodeType_STORAGE_VIEW_INCOMPLETE_PRIMARY_KEY;
    }else if ([strErrorCodeType isEqualToString: @"OTSMetaNotMatch"]) {
        type = OTSErrorCodeType_UNMATCHED_META;
    }
    return type;
}
@end
