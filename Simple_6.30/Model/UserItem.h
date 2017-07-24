//
//  UserItem.h
//  Simple_6.30
//
//  Created by 程彦博 on 2017/7/3.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserItem : NSObject<NSCoding>

@property(nonatomic,strong) NSString *name;
@property(nonatomic,copy) NSString *itemKey;
@property(nonatomic,strong)UIImage *thunbNail;

- (instancetype)initWithItemName:(NSString *)name;
-(void)setThunbNailFormImage:(UIImage *)image;

@end
