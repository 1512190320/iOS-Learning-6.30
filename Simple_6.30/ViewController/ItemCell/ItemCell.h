//
//  ItemCell.h
//  Simple_6.30
//
//  Created by 程彦博 on 2017/7/24.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UIImageView *imgView;
@property (nonatomic,weak) IBOutlet UILabel *mainLable;
@property (nonatomic,weak) IBOutlet UILabel *subLable;
@property (nonatomic,weak) IBOutlet UILabel *rightLable;

@property(nonatomic,copy) void (^actionBlock)(void);

@end
