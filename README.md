Aliyun
OSS
iOS
SDK
使用说明

baocai
zhang

www.giser.net

1
简介

Aliyun
OSS
iOS
SDK 使用Objective-­‐c 实现了Aliyun
OSS 提供的功能，主要包括
Bucket 的创建、删除、浏览。Object 的创建、删除浏览以及多点上传等功能，
关于OSS 提供的服务请参考OSS
API 说明文档。

2
主要内容

Aliyun
OSS
iOS
SDK 主要包括源代码（BSD 协议开源）、说明文档、示例工程、
在线帮助文档和本地帮助文档等。
在线帮助文档地址：http://osssdkhelp.sinaapp.com/
本SDK 同样支持在Mac
OS
X 系统中使用，并提供了相关工程。

3
主要依赖

本SDK 依赖下列主要lib 和framework：

Foundation.framework

CFNetwork.framework

SystemConfiguration.framework

MobileCoreServices.framework

libz.dylib

4
第三方库

本SDK 使用到的第三方类库包括以下部分：

Reachability

ASIHttpRequest

GHKit

tbxml

5
使用步骤

1)
将OSSSDK 和第三方库的源代码或framework 加入到你的应用工程中

在开发中既可以使用源代码的方式也可以使用framework 的方式来使用本SDK
。
2)
添加依赖库的引用，将3 中提到的依赖添加到工程依赖中,依赖库列表如下：

Foundation.framework

CFNetwork.framework

SystemConfiguration.framework

MobileCoreServices.framework

libz.dylib

3） 在build setting 选项中将Other linker Flags 设为-ObjC，

4）使用OSS SDK 进行OSS 对象操作

4.1 在需要使用OSS SDK 的文件中包含OSS 头文件

#import "OSS.h"

4.2
声明OSSClient 类

OSSClient * _client;

4.3 初始化client 对象

_client = [[OSSClient alloc] initWithAccessId:accessid
andAccessKey:accesskey];

其中accessid 为OSS 访问需要的accessid，accesskey 为accessid 对应的key。

accessed 和accesskey 的获取请参考OSS 帮助文档。

4.4 设置client 对象的代理，用来响应client 的请求结果
类实现OSSClientDelegate 协议

@interface ViewController ()<OSSClientDelegate>

将delegate 设为self

_client.delegate = self;

4.5 使用client 的方法进行OSS 对象操作，例如创建bucket
[_client createBucket:@"barrycc11"];

4.6 实现OSSClientDelegate 中关于createBucket 的方法，主要是创建成功和创建
失败的方法，用来获取请求的结果。

-(void)bucketCreateFinish:(OSSClient*) client
result:(Bucket*) bucket

{

NSLog(@"%@",bucket);

}

-(void)bucketCreateFailed:(OSSClient*) client
error:(OSSError*) error

{

NSLog(@"%@",error.errorMessage);

}

其他OSS 对象的操作同样使用上面的流程进行处理。
关于其他方法的使用请参考示例工程和帮助文档。