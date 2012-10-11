//
//  ViewController.h
//  samples_ios
//
//  Created by baocai zhang on 12-8-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AliyunOpenServiceSDK/OSS.h>
#import <AliyunOpenServiceSDK/OTS.h>
@interface ViewController : UIViewController
{
    OSSClient * _client;
    OTSClient * _otsClient;
}
@end
