//
//  MainViewController.m
//  Simple_6.30
//
//  Created by 程彦博 on 2017/6/30.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    curr = [[[User sharedUser] allItems] count];
    
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
