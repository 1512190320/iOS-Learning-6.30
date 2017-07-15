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

#pragma mark - NSCoding
//-----------归档------------
// 将self中所有属性的名称和值加入NSCoder   提供编码方法
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.itemKey forKey:@"itemKey"];
}

//  还原通过encodeWithCoder编码的对象，然后把对象赋给属性   提供解码方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        _name = [aDecoder decodeObjectForKey:@"name"];
        _itemKey = [aDecoder decodeObjectForKey:@"itemKey"];
        
        //如果不是对象而是变量类型的属性 要用decodeIntForKey
    }
    
    return self;
}
//-------------------------

@end
