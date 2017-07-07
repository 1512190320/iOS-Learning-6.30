//
//  MainViewController.h
//  Simple_6.30
//
//  Created by 程彦博 on 2017/6/30.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "UserItem.h"

@interface MainViewController : UIViewController
{
    NSInteger curr;
}

@property (nonatomic,weak) IBOutlet UILabel *name;
@property (nonatomic,weak) IBOutlet UIButton *nextButton;


@end
