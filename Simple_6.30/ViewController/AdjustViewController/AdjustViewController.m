//
//  AdjustViewController.m
//  Simple_6.30
//
//  Created by 程彦博 on 2017/6/30.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import "AdjustViewController.h"

@interface AdjustViewController ()

@property (nonatomic,weak) IBOutlet UIButton *sub;
@property (nonatomic,weak) IBOutlet UITextField *nameTF;
@property (nonatomic,weak) IBOutlet UILabel *currName;


@end

@implementation AdjustViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _currName.hidden = YES;
    
    _nameTF.placeholder = @"input anything";            //占位文本
    _nameTF.returnKeyType = UIReturnKeyDone;            //换行键样式
    _nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;      //设置清空按钮
    _nameTF.delegate = self;                            //设置委托对象
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doSubmit:(id)sender
{
    [_nameTF resignFirstResponder];
    NSLog(@"press submit");
    _currName.text = _nameTF.text;
    [_currName sizeToFit];                              //根据要显示的文字调整大小
    _currName.textAlignment = NSTextAlignmentCenter;    //设置文本居中
    _currName.hidden = NO;
}

#pragma mark - UITextFieldDelegate
//键盘消除
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self changeViewUp:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self changeViewUp:NO];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark - 重构代码抽取部分
- (void)changeViewUp:(BOOL)isUp
{
    // 开始动画(定义了动画的名字)
    [UIView beginAnimations:@"viewUp" context:nil];
    // 设置时长
    [UIView setAnimationDuration:0.2f];
    // 通过isUp来确定视图的移动方向
    int changedValue;
    if (isUp) {
        changedValue = -100;
    }else {
        changedValue = 100;
    }
    // 设置动画内容
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + changedValue, self.view.frame.size.width, self.view.frame.size.height);
    // 提交动画
    [UIView commitAnimations];
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
