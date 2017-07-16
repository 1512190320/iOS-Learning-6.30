//
//  LoginViewController.h
//  Simple_6.30
//
//  Created by 程彦博 on 2017/7/16.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface LoginViewController : UIViewController<MBProgressHUDDelegate,UITextFieldDelegate>{
    MBProgressHUD *_progressHUD;
}

@end
