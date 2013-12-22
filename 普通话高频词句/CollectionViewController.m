//
//  CollectionViewController.m
//  普通话高频词句
//
//  Created by xieweizhi on 12/22/13.
//  Copyright (c) 2013 xieweizhi. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectManager.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController
{
    CollectManager *collectionManager ;
//    NSDictionary *allCollections ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    collectionManager = [CollectManager sharedCollectManager] ;
}


#pragma mark - data source delegate
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath] ;
    UILabel *label = (UILabel *) [cell viewWithTag:1] ;
    NSString *deletedItem = label.text ;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [collectionManager removeFromCollectionWithValue:deletedItem] ;
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        self.tableView.editing = NO ;
        [self.editButton setTitle:@"修改" forState:UIControlStateNormal] ;
        
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return  YES ;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"单词" ;
            break;
        case 1:
            return @"词语";
    }
    return @"" ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [NSString stringWithFormat:@"%d",section] ;
    NSDictionary *allCollections = [collectionManager collectionDic] ;
    NSInteger count = [(NSArray *)allCollections[key] count] ;
    return count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellId = @"collection cell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId] ;

    //add swipe to delete recoginzer
    
    UILabel *wordLabel = (UILabel *)[cell viewWithTag:1] ;
    wordLabel.text = [self getItemStringWithIndexPath:indexPath] ;

    return cell ;
}

-(NSString *) getItemStringWithIndexPath:(NSIndexPath *) indexPath {
    NSString *key = [NSString stringWithFormat:@"%d",indexPath.section ] ;
    NSDictionary *allCollections = [collectionManager collectionDic] ;

    return [(NSArray *) allCollections[key] objectAtIndex:indexPath.row  ] ;
}
#pragma  mark - alert View delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [collectionManager clearAllCollections ] ;
        [self.tableView reloadData] ;
    }
}

#pragma  mark - Button Action
- (IBAction)clearAllCollectionAction:(id)sender {
    if ([self.tableView numberOfRowsInSection:0] ==0 && [self.tableView numberOfRowsInSection:1] ==0) {
        return ;
    }
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"确定清空所有收藏？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] ;
    [alertView show] ;
}

- (IBAction)toggleEditAction:(id)sender {
    if (self.tableView.editing) {
//        self.editButton.titleLabel.text = @"完成" ;
        [self.editButton setTitle:@"修改" forState:UIControlStateNormal] ;
        self.tableView.editing = NO ;
        return ;
    }
    [self.editButton setTitle:@"完成" forState:UIControlStateNormal] ;
    self.tableView.editing = YES ;
}
@end
