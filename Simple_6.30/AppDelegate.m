//
//  AppDelegate.m
//  Simple_6.30
//
//  Created by 程彦博 on 2017/6/30.
//  Copyright © 2017年 cyb. All rights reserved.
//

#import "AppDelegate.h"
#import "TestBarViewController.h"
#import "MainViewController.h"
#import "AdjustViewController.h"
#import "HistoryViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    //创建好3个界面，放入各自的navVC中 加入tabbbar
    MainViewController *main = [[MainViewController alloc] init];
    main.title=@"Main";
    main.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Main "image:nil tag:0];
    UINavigationController *navFir = [[UINavigationController alloc] initWithRootViewController:main];

    AdjustViewController *adj = [[AdjustViewController alloc] init];
    adj.title=@"Adjust";
    adj.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Adjust "image:nil tag:0];
    UINavigationController *navSec = [[UINavigationController alloc] initWithRootViewController:adj];
    
    HistoryViewController *his = [[HistoryViewController alloc] init];
    his.title=@"History";
    his.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"History "image:nil tag:0];
    UINavigationController *navThi = [[UINavigationController alloc] initWithRootViewController:his];
    
    UITabBarController *tabbarC = [[UITabBarController alloc] init];
    
    //对plist的数据读取
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"mates" ofType:@"plist"];//获取plist文件路径
    NSMutableArray *mateData = [[NSMutableArray alloc] initWithContentsOfFile:filePath];//读取指定路径的plist
    NSLog(@"dom members : %lu",(unsigned long)[mateData count]);
    
    
    for (NSDictionary *string in mateData) {//快速枚举
        NSLog(@"mateData content is %@",[string objectForKey:@"name"]);
        [[User sharedUser]creatItem:[string objectForKey:@"name"]];
    }
    
    
    tabbarC.viewControllers = @[navFir,navSec,navThi];
    
    self.window.rootViewController = tabbarC;
    self.window.backgroundColor = [UIColor clearColor];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    NSLog(@"%@", [[User sharedUser] allItems]);
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (UserItem *item in [[User sharedUser] allItems]) {//快速枚举
        NSDictionary *itemDic = [NSDictionary dictionaryWithObjectsAndKeys:item.name,@"name",item.itemKey,@"itemKey",nil];
        [array addObject:itemDic];
    }
    NSLog(@"array is : %@",array);
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"mates" ofType:@"plist"];//获取plist文件路径
    
    [array writeToFile:filePath atomically:YES];
    
    NSMutableArray *mateData = [[NSMutableArray alloc] initWithContentsOfFile:filePath];//读取指定路径的plis
    
    for (NSDictionary *string in mateData) {//快速枚举
        NSLog(@"mateData name is %@",[string objectForKey:@"name"]);
        NSLog(@"mateData itemKey is %@",[string objectForKey:@"itemKey"]);
    }
}


@end
