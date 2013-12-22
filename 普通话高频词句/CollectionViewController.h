//
//  CollectionViewController.h
//  普通话高频词句
//
//  Created by xieweizhi on 12/22/13.
//  Copyright (c) 2013 xieweizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate ,UIAlertViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic , strong) IBOutlet UITableView  *tableView ;

@property(nonatomic , strong) IBOutlet UIButton *editButton ;
- (IBAction)clearAllCollectionAction:(id)sender;
- (IBAction)toggleEditAction:(id)sender;

@end
