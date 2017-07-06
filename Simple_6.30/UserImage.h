//
//  UserImage.h
//  Simple_6.30
//
//  Created by 程彦博 on 2017/7/6.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserImage : NSObject

+ (instancetype)sharedUser;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
