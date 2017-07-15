//
//  UserImage.m
//  Simple_6.30
//
//  Created by 程彦博 on 2017/7/6.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import "UserImage.h"

@interface UserImage ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation UserImage

+ (instancetype)sharedUser
{
    static UserImage *sharedUser;
    
    if (!sharedUser) {
        sharedUser = [[self alloc] initPrivate];
    }
    
    //线程安全的单例 保证多线程应用中也只创建一个对象 效果和上面的代码相同
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        sharedUser = [[self alloc] initPrivate];
    });
    
    return sharedUser;
}

// No one should call init
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"这是一个单例"
                                   reason:@"用 sharedUser替代"
                                 userInfo:nil];
    return nil;
}

// Secret designated initializer
- (instancetype)initPrivate
{
    self = [super init];
    
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    //[self.dictionary setObject:image forKey:key]; 两种写法一样
    self.dictionary[key] = image;
}

- (UIImage *)imageForKey:(NSString *)key
{
    //return [self.dictionary objectForKey:key]; 两种写法一样
    return self.dictionary[key];
}

- (void)deleteImageForKey:(NSString *)key
{
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
}

@end

