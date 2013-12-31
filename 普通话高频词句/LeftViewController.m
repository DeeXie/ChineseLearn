//
//  LeftViewController.m
//  普通话高频词句
//
//  Created by xieweizhi on 12/19/13.
//  Copyright (c) 2013 xieweizhi. All rights reserved.
//

#import "LeftViewController.h"
#import "AppDelegate.h"
#import "DataManager.h"
#import "MainDataViewController.h"
#import "CollectionViewController.h"
@interface LeftViewController ()

@end

@implementation LeftViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5 ;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"Left Cell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID] ;
    
    UILabel *titleLabel = (UILabel *) [cell viewWithTag:1] ;
    if (indexPath.row == 0 ) {
        titleLabel.text = @"单词" ;
    } else if (indexPath.row == 1 )
        titleLabel.text = @"词语" ;
    else if (indexPath.row == 2)
        titleLabel.text = @"收藏" ;
    else if(indexPath.row == 3) {
        titleLabel.text = @"" ;
        cell.userInteractionEnabled = NO ;
    }
    else if (indexPath.row == 4) {
        titleLabel.text = @"反馈" ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    }
    
    cell.layer.cornerRadius = 22.0f;
    return cell ;
    
    
}

#pragma mark - UITableViewDelegate 
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil] ;
    AppDelegate *app = [UIApplication sharedApplication].delegate ;
    
    NSString *vcStoryID  ;
    kDataType type ;
    
    NSInteger row = indexPath.row ;
    if (row < 2) {
        vcStoryID = @"MainDataNavigationVCID" ;
        if (row == 0 ) {
            type = kDataTypeSingleWordType ;
        } else
            type = kDataTypeExpressionType ;
        UINavigationController *naviVC = [storyBoard instantiateViewControllerWithIdentifier:vcStoryID] ;
        MainDataViewController *rootVC = naviVC.viewControllers[0] ;
        [rootVC setDataType:type] ;
        app.viewDeckVC.centerController = naviVC  ;

    }
    else if (row == 2) {
        vcStoryID = @"CollectionViewController" ;
        CollectionViewController *collectionVC = [storyBoard instantiateViewControllerWithIdentifier:vcStoryID] ;
        app.viewDeckVC.centerController = collectionVC ;
    } else if (row == 4 ) {
        [self feedBackAction] ;
    }
    [app.viewDeckVC closeLeftView ] ;
}

-(void) showViewControllerWithStoryBoardIdentifier :(NSString *) identifier {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil] ;
    AppDelegate *app = [UIApplication sharedApplication].delegate ;
    app.viewDeckVC.centerController = [storyBoard instantiateViewControllerWithIdentifier:identifier    ] ;
    [app.viewDeckVC closeLeftView ];
}
- (IBAction)closeLeftView:(id)sender {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate ;
    [appDelegate.viewDeckVC closeLeftViewAnimated:YES];
}

-(void) feedBackAction {
    //can not send email  ,return
    if (![MFMailComposeViewController canSendMail]) {
        return ;
    }
    // Email Subject
    NSString *emailTitle = @"iOS app feedback";
    // Email Content
    NSString *messageBody = @"您的建议是我们进步的动力";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"deexie1990@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    /*
     result:
     MFMailComposeResultCancelled,
     MFMailComposeResultSaved,
     MFMailComposeResultSent,
     MFMailComposeResultFailed
     */
    
    if (result == MFMailComposeResultFailed) {
        UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:nil  message:@"发送失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil ] ;
        [alert show  ] ;
    }
    [controller dismissViewControllerAnimated:YES completion:nil ] ;
    
}

@end
