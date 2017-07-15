
//
//  User.h
//  Simple_6.30
//
//  Created by 程彦博 on 2017/6/30.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserItem;

@interface User : NSObject

//由于allItem的readonly属性以及它的getter被覆盖，allItems不会生成实例变量
@property (nonatomic, readonly) NSArray *allItems;

+(instancetype)sharedUser;
-(UserItem *)creatItem:(NSString *)n;
-(void)removeItem:(UserItem *)item;
-(void)moveItemAtIndex:(NSUInteger)from
               toIndex:(NSUInteger)to;
//归档
-(Boolean)saveChanges;


@end
