//
//  DataYearSelectViewController.m
//  普通话高频词句
//
//  Created by xieweizhi on 12/21/13.
//  Copyright (c) 2013 xieweizhi. All rights reserved.
//

#import "DataYearSelectViewController.h"
//#import "SingleWord.h"
@interface DataYearSelectViewController ()

@end
@implementation DataYearSelectViewController
{
    NSArray *years ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    years = kAllYears ;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return years.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"year cell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID ] ;
    
    UILabel *yearLabel = (UILabel *)[cell viewWithTag:1] ;
    yearLabel.text = [NSString stringWithFormat:@"%@",[years objectAtIndex:indexPath.row]] ;
    NSLog(@"year :%@",yearLabel.text );
    return cell ;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate didSelectDataYearWithYear:[years objectAtIndex:indexPath.row]];
}
@end
