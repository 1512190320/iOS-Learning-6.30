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

- (NSString *)imagePathForKey:(NSString *)key;

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
        
        //内存过低警告
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(clearCache:)
                   name:UIApplicationDidReceiveMemoryWarningNotification
                 object:nil];

    }
    
    return self;
}

- (void)clearCache:(NSNotification *)note
{
    NSLog(@"flushing %lu images out of the cache", (unsigned long)[self.dictionary count]);
    [self.dictionary removeAllObjects];
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    //[self.dictionary setObject:image forKey:key]; 两种写法一样
    self.dictionary[key] = image;
    
//---------归档-----------
    //获取保存图片的全路径
    NSString *imagePath = [self imagePathForKey:key];
    
    //从图片提取jpeg格式数据
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    
    //将jpeg格式文件写入文件
    [data writeToFile:imagePath atomically:YES];
//-----------------------
}

- (UIImage *)imageForKey:(NSString *)key
{
    //return [self.dictionary objectForKey:key]; 两种写法一样
    //return self.dictionary[key];
//--------------归档---------------
    UIImage *result = self.dictionary[key];
    
    if(!result){
        NSString *imagePath = [self imagePathForKey:key];
        result = [UIImage imageWithContentsOfFile:imagePath];
        
        if(result){
            self.dictionary[key] = result;
        }
        else{
            NSLog(@"出错 无法找到 %@",[self imagePathForKey:key]);
        }
    }
    return result;
}

- (void)deleteImageForKey:(NSString *)key
{
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
    
//---------------归档-------------------
    NSString *imagePath = [self imagePathForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
}

- (NSString *)imagePathForKey:(NSString *)key{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:key];
}

@end

