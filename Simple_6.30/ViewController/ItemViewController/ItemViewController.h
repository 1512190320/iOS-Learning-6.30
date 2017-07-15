//
//  ItemViewController.h
//  Simple_6.30
//
//  Created by 程彦博 on 2017/7/5.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserItem;

@interface ItemViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

@property(nonatomic,strong) UserItem *item;

-(instancetype)initForNewItem: (BOOL)isNew;

@end
