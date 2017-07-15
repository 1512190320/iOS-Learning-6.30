//
//  User.m
//  Simple_6.30
//
//  Created by 程彦博 on 2017/6/30.
//  Copyright © 2017年 cyb. All rights reserved.
//


// -----------单例模式---------------
#import "User.h"
#import "UserItem.h"
#import "UserImage.h"

@interface User ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation User

+(instancetype)sharedUser{
    static User *sharedUser = nil;
    
//    if(!sharedUser){
//        sharedUser = [[self alloc] initPrivate];
//    }
    
    ////线程安全的单例 保证多线程应用中也只创建一个对象 效果和上面的代码相同
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        sharedUser = [[self alloc] initPrivate];
    });
    
    return sharedUser;
}

-(instancetype)initPrivate{
    self = [super init];
    if(self){
        _privateItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

//覆盖allItem的getter
-(NSArray *)allItems{
    return self.privateItems;
}

-(instancetype)init{
    @throw [NSException exceptionWithName:@"这是一个单例"
                                   reason:@"用 sharedUser替代"
                                 userInfo:nil];
    return nil;
}

-(UserItem *)creatItem:(NSString *) n{
    UserItem *item = [[UserItem alloc] initWithItemName:n];
    //item.name = n;
    
    [self.privateItems addObject:item];
    return item;
}

-(void)removeItem:(UserItem *)item{
    NSString *key = item.itemKey;
    [[UserImage sharedUser] deleteImageForKey:key];
//    //比较对象的数据 会枚举数组，调用isEqual检查是否一样，最后删除一样的
//    [self.privateItems removeObject:item];
    //比较对象的指针
    [self.privateItems removeObjectIdenticalTo:item];
    
    
}

-(void)moveItemAtIndex:(NSUInteger)from toIndex:(NSUInteger)to{
    if(from == to)
        return;
    UserItem *item = self.privateItems[from];
    //删除原位置的
    [self.privateItems removeObjectAtIndex:from];
    //在新位置插入
    [self.privateItems insertObject:item atIndex:to];
    
}
@end
