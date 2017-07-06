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
//键盘消除
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
