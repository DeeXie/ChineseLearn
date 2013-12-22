//
//  DataYearSelectViewController.h
//  普通话高频词句
//
//  Created by xieweizhi on 12/21/13.
//  Copyright (c) 2013 xieweizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataYearSelectViewController;

@protocol DataYearSelectViewControllerDelegate <NSObject>

-(void ) didSelectDataYearWithYear:(NSNumber *)year ;

@end

@interface DataYearSelectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic ,strong) IBOutlet UITableView *tableView ;
@property(nonatomic , strong) id<DataYearSelectViewControllerDelegate> delegate ;

@end
