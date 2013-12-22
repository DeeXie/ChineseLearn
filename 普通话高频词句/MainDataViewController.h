//
//  SingleWordViewController.h
//  普通话高频词句
//
//  Created by xieweizhi on 12/18/13.
//  Copyright (c) 2013 xieweizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IBActionSheet.h"
#import "TopBarView.h"
#import "DataYearSelectViewController.h"
#import "DataManager.h"
#define kColorCellSelectedColor [UIColor colorWithRed:246/255.0 green:224/255.0 blue:203/255.0 alpha:1.0]

@interface MainDataViewController : UIViewController<UICollectionViewDataSource,UIGestureRecognizerDelegate ,IBActionSheetDelegate,UICollectionViewDelegate,TopBarViewDelegate,DataYearSelectViewControllerDelegate>
{
    
}
@property (strong, nonatomic) IBOutlet TopBarView *topBarView;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

-(void) setDataType:(kDataType) t  ;

@end
