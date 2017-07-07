//
//  MainViewController.m
//  Simple_6.30
//
//  Created by 程彦博 on 2017/6/30.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic,strong) NSMutableArray *mateData;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"mates" ofType:@"plist"];//获取plist文件路径
    _mateData = [[NSMutableArray alloc] initWithContentsOfFile:filePath];//读取指定路径的plist
    NSLog(@"dom members : %lu",(unsigned long)[_mateData count]);
    
    for (NSString *string in _mateData) {//快速枚举
        NSLog(@"mateData content is %@",string);
        [[User sharedUser]creatItem:string];
    }
    //_name.text = [mateData objectAtIndex:arc4random() % 4]; 随机数
    //curr = [[_mateData objectAtIndex:0] integerValue];
    curr = [[[User sharedUser] allItems] count];
    //NSLog(@"curr is now %ld",(long)curr);
    
}

-(IBAction)doNext:(id)sender
{
    //NSLog(@"press next");
    if(curr < [[[User sharedUser] allItems] count] - 1)
        curr ++;
    else
        curr = 0;
    _name.text = [[[[User sharedUser] allItems] objectAtIndex:curr] name];
    //NSLog(@"after press curr is now %ld",(long)curr);
}

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
