//
//  AppDelegate.m
//  普通话高频词句
//
//  Created by xieweizhi on 12/18/13.
//  Copyright (c) 2013 xieweizhi. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"

@implementation AppDelegate
@synthesize viewDeckVC = _viewDeckVC ;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupViewControllers] ;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
   
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) setupViewControllers {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil] ;
    LeftViewController *leftVC = [ storyBoard instantiateViewControllerWithIdentifier:@"LeftViewController"] ;
    
    
    UINavigationController *centerVC = (UINavigationController *)self.window.rootViewController ;
    
    _viewDeckVC = [[IIViewDeckController alloc]initWithCenterViewController:centerVC leftViewController:leftVC ] ;
    _viewDeckVC.leftSize = 250 ;
    _viewDeckVC.centerhiddenInteractivity =  IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose ;

    
    self.window.rootViewController = _viewDeckVC ;
}

@end
