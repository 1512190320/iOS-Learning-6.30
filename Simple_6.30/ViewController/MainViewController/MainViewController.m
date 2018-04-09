//
//  MainViewController.m
//  Simple_6.30
//
//  Created by 程彦博 on 2017/6/30.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"

@interface MainViewController ()

@property(nonatomic,strong) UITextView *textview;
@property(nonatomic,strong) UIButton *dogButton;
@property(nonatomic,strong) UIButton *nextButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image"]]];
    
    //实现模糊效果
    UIBlurEffect *blurEffrct =[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //毛玻璃视图
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffrct];
    visualEffectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    visualEffectView.alpha = 0.6f;
    [self.view addSubview:visualEffectView];
    
//    curr = [[[User sharedUser] allItems] count];
    [self setLogin];
    
    _KYNet = [NetWork shareNetWork];
    _KYNet.delegate = self;
    
    _dogButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, SCREEN_HEIGHT/2-188, 80, 44)];
    _dogButton.center = CGPointMake(SCREEN_WIDTH/2, _dogButton.center.y);
    [_dogButton setTitle:@"dog fact" forState:UIControlStateNormal];
    [_dogButton setBackgroundColor:[UIColor blueColor]];
    _dogButton.layer.shadowRadius = 5;                        //阴影半径
    _dogButton.layer.shadowOpacity = 0.2;                     //阴影透明度
    _dogButton.layer.shadowOffset = CGSizeMake(0, 1);         //阴影偏移
    [_dogButton addTarget:self action:@selector(dogButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _dogButton.showsTouchWhenHighlighted = YES;
    [self.view addSubview:_dogButton];
    
    _textview = [[UITextView alloc] initWithFrame:CGRectMake(40, 250, SCREEN_WIDTH-80, SCREEN_HEIGHT/3)];
    _textview.textColor = [UIColor blackColor];
    _textview.backgroundColor = [UIColor clearColor];
    _textview.font = [UIFont systemFontOfSize:20.f];
    _textview.textAlignment = NSTextAlignmentCenter;
    _textview.editable = NO;
    //圆角矩形框
    _textview.layer.backgroundColor = [[UIColor colorWithRed:230.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0]CGColor];
    _textview.layer.borderColor = [[UIColor colorWithRed:230.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0]CGColor];
    _textview.layer.borderWidth = 3.0;
    _textview.layer.cornerRadius = 8.0f;
    [_textview.layer setMasksToBounds:YES];
    
    [self.view addSubview:_textview];
    
    _nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _nextButton.frame =CGRectMake(SCREEN_WIDTH/2-40, SCREEN_HEIGHT/2+168, 80, 44);
    _nextButton.center = CGPointMake(SCREEN_WIDTH/2, _nextButton.center.y);
    [_nextButton setTitle:@"next" forState:UIControlStateNormal];
    _nextButton.showsTouchWhenHighlighted = YES;
    _nextButton.alpha = 0.f;
    [self.view addSubview:_nextButton];
    
    
    
}

-(void)dogButtonAction{
    _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_progressHUD];
    [self.view bringSubviewToFront:_progressHUD];
    _progressHUD.delegate = self;
    _progressHUD.label.text = @"数据请求中……";
    [_progressHUD showAnimated:YES];
    [_KYNet getDogFact];
}
-(void)getDogFactSuccessFeedback:(id)feedbackInfo{
    //当服务器返回成功数据后，下列代码被激活
    if(_progressHUD){
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
    [_nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _nextButton.alpha = 1.f;
    NSLog(@"%@",[feedbackInfo class]);
    NSDictionary *dic=feedbackInfo;

    facts = [dic objectForKey:@"facts"];
    curr = 0;
    _textview.text = facts[curr];
    
}

-(void)getDogFactFailFeedback:(id)failInfo{
    NSLog(@"%@",failInfo);
    if(_progressHUD){
        // Set the text mode to show only text.
        _progressHUD.removeFromSuperViewOnHide = YES;
        _progressHUD.mode = MBProgressHUDModeText;
        _progressHUD.label.text = @"Error";
        [_progressHUD hideAnimated:YES afterDelay:1.f];
    }
    
}

-(void)nextButtonAction{
    if(curr < facts.count - 1)
        curr ++;
    else
        curr = 0;
    _textview.text = facts[curr];
}



- (void)setLogin{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:NO];
}

//-(IBAction)doNext:(id)sender
//{
//    //NSLog(@"press next");
//    if(curr < [[[User sharedUser] allItems] count] - 1)
//        curr ++;
//    else
//        curr = 0;
//    _name.text = [[[[User sharedUser] allItems] objectAtIndex:curr] name];
//    //NSLog(@"after press curr is now %ld",(long)curr);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
