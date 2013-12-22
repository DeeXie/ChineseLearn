//
//  DoubleTapShowItemViewController.h
//  普通话高频词句
//
//  Created by xieweizhi on 12/21/13.
//  Copyright (c) 2013 xieweizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoubleTapShowItemViewController : UIViewController
@property(nonatomic , strong) IBOutlet UILabel *itemLabel ;
@property(nonatomic , strong) IBOutlet UILabel *spellLabel ;
@property(nonatomic , strong) NSString *itemString ;
@end
