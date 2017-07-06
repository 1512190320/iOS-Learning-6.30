//
//  UserItem.m
//  Simple_6.30
//
//  Created by 程彦博 on 2017/7/3.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import "UserItem.h"

@implementation UserItem

- (instancetype)initWithItemName:(NSString *)name{
    self = [super init];
    
    if(self){
        _name = name;
        NSUUID *uuid = [[NSUUID alloc] init];
        NSString *key = [uuid UUIDString];
        _itemKey = key;
    }
    return self;
}

@end
