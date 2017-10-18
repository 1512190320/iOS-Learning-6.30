//
//  NetWork.h
//  Simple_6.30
//
//  Created by 程彦博 on 2017/10/15.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
//代理
@protocol NetWorkDelegate <NSObject>
/**
 *  代理回调方法
 *
 *  @param feedbackInfo 服务器返回的数据
 */
-(void)getDogFactSuccessFeedback:(id)feedbackInfo;
-(void)getDogFactFailFeedback:(id)failInfo;

@end

@interface NetWork : NSObject
@property (nonatomic,strong) id<NetWorkDelegate> delegate;
+(instancetype)shareNetWork;
/**
 *  获得一个dog fact
 */
-(void)getDogFact;

@end
