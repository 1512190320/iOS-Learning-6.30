//
//  NetWork.m
//  Simple_6.30
//
//  Created by 程彦博 on 2017/10/15.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import "NetWork.h"

@implementation NetWork

// 创建静态对象 防止外部访问
__strong static NetWork *_instance = nil;
__strong static AFHTTPSessionManager *AFHTTPMgr;

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

// 为了使实例易于外界访问 我们一般提供一个类方法
// 类方法命名规范 share类名|default类名|类名
+(instancetype)shareNetWork
{
    static NetWork *sharedNetWork = nil;
    
    //    if(!sharedUser){
    //        sharedUser = [[self alloc] initPrivate];
    //    }
    
    ////线程安全的单例 保证多线程应用中也只创建一个对象 效果和上面的代码相同
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        //一下是AFHTTPOerrationManager的配置
        AFHTTPMgr=[AFHTTPSessionManager manager];
        //申明返回的结果是json类型
        AFHTTPMgr.responseSerializer=[AFJSONResponseSerializer serializer];
        //申明请求的数据是json类型
        AFHTTPMgr.requestSerializer=[AFJSONRequestSerializer serializer];
        //如果报接受类型不一致请替换一致text/xml或别的
        //AFHTTPMgr.responseSerializer.acceptableContentTypes= [NSSet setWithObject:@"text/xml"];
        //设置超时时间
        AFHTTPMgr.requestSerializer.timeoutInterval=50;
    });
    return _instance;
}
// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}

-(void)getDogFact{
    //接口地址
    NSString *url=[NSString stringWithFormat:@"http://dog-api.kinduff.com/api/facts"];
    //参数
    NSDictionary *parameters=[[NSDictionary alloc]initWithObjectsAndKeys:@"5",@"number", nil];
    //发请求
    NSLog(@"发送请求");
    [AFHTTPMgr GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功");
        NSLog(@"%@",responseObject);
        //将返回数据传入代理方法
        [self.delegate getDogFactSuccessFeedback:responseObject];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败");
        [self.delegate getDogFactFailFeedback:error];
    }];
}


@end
