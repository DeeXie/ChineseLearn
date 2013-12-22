//
//  TopBarView.h
//  普通话高频词句
//
//  Created by xieweizhi on 12/21/13.
//  Copyright (c) 2013 xieweizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopBarView ;

@protocol TopBarViewDelegate <NSObject>



@end

@interface TopBarView : UIView

@property(nonatomic , strong) id<TopBarViewDelegate> delegate ;

@property(strong , nonatomic) IBOutlet UIButton *yearSelectButton ;
@property(strong , nonatomic) IBOutlet UILabel  *yearLabel ;

@end
