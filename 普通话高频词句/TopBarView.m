//
//  TopBarView.m
//  普通话高频词句
//
//  Created by xieweizhi on 12/21/13.
//  Copyright (c) 2013 xieweizhi. All rights reserved.
//

#import "TopBarView.h"

@implementation TopBarView
@synthesize yearSelectButton = _yearSelectButton ;


-(void)awakeFromNib {
    [super awakeFromNib] ;
    [self.yearSelectButton addTarget:self action:@selector(yearButtonAction:) forControlEvents:UIControlEventTouchUpInside] ;
    self.layer.cornerRadius = 12.0f ;

    
}


#pragma mark - button action
/* create a new item in the word or expression plist action  */


-(void) yearButtonAction:(id) sender{
    NSLog(@"year button pressed") ;
}

@end
