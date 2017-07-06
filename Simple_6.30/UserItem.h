//
//  UserItem.h
//  Simple_6.30
//
//  Created by 程彦博 on 2017/7/3.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserItem : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *itemKey;

- (instancetype)initWithItemName:(NSString *)name;

@end
