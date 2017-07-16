//
//  LoginViewController.m
//  Simple_6.30
//
//  Created by 程彦博 on 2017/7/16.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (nonatomic,strong) UITextField *userNameTextField;
@property (nonatomic,strong) UITextField *passWordTextField;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UIButton *loginBotton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];

    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    _iconImageView.image = [self scaleToSize:[UIImage imageNamed:@"icon-630"] size:CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH)];
    [self.view addSubview:_iconImageView];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH,44)];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, view1.frame.origin.y+view1.frame.size.height+20, SCREEN_WIDTH,44)];
    
    _userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(70,0,SCREEN_WIDTH-70-70,44)];
    _userNameTextField.font = [UIFont systemFontOfSize:12];
    _userNameTextField.placeholder = @"Username";
    _userNameTextField.keyboardType = UIKeyboardTypeAlphabet;
    [view1 addSubview:_userNameTextField];
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(70,_userNameTextField.frame.size.height,_userNameTextField.frame.size.width,1)];
    [line1 setBackgroundColor:[UIColor blueColor]];
    [view1 addSubview:line1];
    
    
    _passWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(70,0,SCREEN_WIDTH-70-70,44)];
    _passWordTextField.placeholder = @"Password";
    _passWordTextField.keyboardType = UIKeyboardTypeNumberPad;
    _passWordTextField.font = [UIFont systemFontOfSize:12];
    [view2 addSubview:_passWordTextField];
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(70,_passWordTextField.frame.size.height,_passWordTextField.frame.size.width,1)];
    [line2 setBackgroundColor:[UIColor blueColor]];
    [view2 addSubview:line2];
    
    _loginBotton  = [[UIButton alloc] initWithFrame:CGRectMake(30, view2.frame.origin.y+view2.frame.size.height+30, SCREEN_WIDTH-60, 44)];
    _loginBotton.center = CGPointMake(SCREEN_WIDTH/2, _loginBotton.center.y);
    [_loginBotton setTitle:@"Login" forState:UIControlStateNormal];
    [_loginBotton setBackgroundColor:[UIColor blueColor]];
    _loginBotton.layer.shadowRadius = 5;                        //阴影半径
    _loginBotton.layer.shadowOpacity = 0.2;                     //阴影透明度
    _loginBotton.layer.shadowOffset = CGSizeMake(0, 1);         //阴影偏移
    [_loginBotton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _loginBotton.showsTouchWhenHighlighted = YES;
    [self.view addSubview:_loginBotton];
    //_loginBotton.alpha = 0;
    
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
//    self.navigationController.navigationBar.hidden = NO;
//    [self.parentViewController.navigationController.navigationBar setHidden:NO];
//    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBarHidden=NO;
}

-(void)loginButtonAction{
    _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_progressHUD];
    [self.view bringSubviewToFront:_progressHUD];
    _progressHUD.delegate = self;
    _progressHUD.label.text = @"登录中……";
    [_progressHUD showAnimated:YES];
    
    if (_progressHUD){
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
     [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
