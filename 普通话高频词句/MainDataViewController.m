//
//  MainDataViewController.m
//  普通话高频词句
//
//  Created by xieweizhi on 12/21/13.
//  Copyright (c) 2013 xieweizhi. All rights reserved.
//

#import "MainDataViewController.h"
#import "CollectManager.h"
#import "DoubleTapShowItemViewController.h"

@interface MainDataViewController ()
{
    DataManager *dataManager ;
    NSArray *dataArray ;
    NSNumber *dataYear ;
    kDataType dataType ;

    CollectManager *collectionManager ;
    
    IBActionSheet *actionSheet ;
    
    NSIndexPath *longPressCellIndexPath ;
    
}
@end

@implementation MainDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.topBarView.delegate = self ;
    
	// Do any additional setup after loading the view.
    [self dataSetup] ;
    
    // attach long press gesture to collectionView
    [self setupGuestures];
    
    
    collectionManager = [CollectManager sharedCollectManager] ;
}

#pragma mark - segue method
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"show year select view"]) {
        DataYearSelectViewController *destVC = (DataYearSelectViewController *) segue.destinationViewController;
        destVC.delegate = self ;
    }
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dataArray.count ;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1 ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SingleWordCellID = @"word cell";
    
    UICollectionViewCell *cell  ;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:SingleWordCellID forIndexPath:indexPath] ;

    cell.layer.cornerRadius = 12.0f ;
    
    UIFont *wordFont ;
    if (dataType == kDataTypeExpressionType) {
        wordFont = [UIFont fontWithName:@"Helvetica" size:18] ;
    } else if(dataType ==  kDataTypeSingleWordType)
        wordFont = [UIFont fontWithName:@"Helvetica" size:33] ;
    UILabel *itemLabel = (UILabel *) [cell viewWithTag:1] ;
    itemLabel.font = wordFont ;
    UILabel *spellLabel = (UILabel *) [cell viewWithTag:2] ;
    
    NSString *dataString = [dataArray objectAtIndex:indexPath.row ] ;
    itemLabel.text = dataString ;
    spellLabel.text = [dataManager convertStringToSpell:dataString ] ;
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    [UIView animateWithDuration:1.0f animations:^{
        //        self.topBarView.hidden = NO ;
        self.topBarView.alpha = 1.0 ;
    }] ;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.5f animations:^{
        //        self.topBarView.hidden = YES ;
        self.topBarView.alpha = 0.0 ;
        
    }] ;
}


#pragma mark - Gesutre Action
-(void)singleTapAction:(UITapGestureRecognizer *)gestureRecognizer{
    //get the cell
    CGPoint p = [gestureRecognizer locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath] ;
    UIColor *oringinalColor = cell.backgroundColor;
    //if the double taps can locate a cell
    if (cell) {
        cell.backgroundColor = kColorCellSelectedColor ;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:0.5f];
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.5f animations:^{
                    cell.backgroundColor = oringinalColor ;
                }] ;
            });
        }) ;
    }
}
-(void)doubleTapAction:(UITapGestureRecognizer *)gestureRecognizer{
    //get the cell
    CGPoint p = [gestureRecognizer locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath] ;
    
    //if the double taps can locate a cell
    if (cell) {
        DoubleTapShowItemViewController *showVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DoubleTapShowItemViewController"] ;
        UILabel *wordLabel =  (UILabel *)[cell viewWithTag:1];
        showVC.itemString = wordLabel.text ;
        [self presentViewController:showVC animated:YES completion:nil ] ;
    }
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint p = [gestureRecognizer locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    if (indexPath == nil){
        return ;
    } else {
        longPressCellIndexPath = indexPath ;
        //if the word is already in collection , add remove button in action sheet
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:longPressCellIndexPath] ;
        cell.backgroundColor = kColorCellSelectedColor ;
        UILabel *wordLabel = (UILabel *)[cell viewWithTag:1] ;
        BOOL addRemoveButton = [collectionManager isItemInCollection:wordLabel.text] ;
        [self setupActionSheetWithRemoveButton:addRemoveButton] ;
        [actionSheet showInView:self.navigationController.view] ;
    }
}

#pragma mark - setup
-(void) dataSetup {
    if (dataType != kDataTypeSingleWordType && dataType != kDataTypeExpressionType) {
        dataType = kDataTypeSingleWordType ;
    }
    dataManager = [DataManager sharedDataManager] ;
    dataArray = [dataManager getDataArrayWithType:dataType year:dataYear] ;
    NSLog(@"dataArray in main view: %@",dataArray) ;
    [self.collectionView reloadData];
//    [self.collectionView reloadData] ;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dataArray = [dataManager getDataArrayWithType:type year:year] ;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.collectionView reloadData] ;
//        }) ;
//    }) ;
}


-(void) setupGuestures {
    //long press gesture
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = .5; //seconds
    lpgr.delegate = self;
    [self.collectionView addGestureRecognizer:lpgr];
    
    //double tap gesture
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)] ;
    doubleTapGesture.numberOfTapsRequired = 2 ;
    doubleTapGesture.numberOfTouchesRequired = 1 ;
    [self.collectionView addGestureRecognizer:doubleTapGesture] ;
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    
    [singleTapGestureRecognizer requireGestureRecognizerToFail: doubleTapGesture];
    //tapGestureRecognizer.delegate = self;
    [self.collectionView addGestureRecognizer:singleTapGestureRecognizer];    
}

-(void) setDataType:(kDataType) t {
    dataType = t ;
    [self dataSetup] ;
}

-(void) setupActionSheetWithRemoveButton:(BOOL) flag {
    
    if (flag) {
        actionSheet =  [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"收藏" otherButtonTitlesArray:@[@"取消收藏"]  ];
    } else {
        actionSheet =  [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"收藏" otherButtonTitlesArray:@[]  ];
    }
    [actionSheet setBackgroundColor:[UIColor clearColor]] ;
    [actionSheet setTitleTextColor:[UIColor blackColor]] ;
    [actionSheet setButtonBackgroundColor:[UIColor grayColor]];
    [actionSheet setButtonTextColor:[UIColor blackColor]];
    actionSheet.buttonResponse = IBActionSheetButtonResponseHighlightsOnPress ;
    actionSheet.layer.cornerRadius = 12.0f ;
}

#pragma mark - IBActionSheetDelegate
-(void)actionSheet:(IBActionSheet *)ibActionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:longPressCellIndexPath] ;
    cell.backgroundColor = [UIColor clearColor] ;
    UILabel *wordLabel = (UILabel *)[cell viewWithTag:1] ;
    
    //save to collection
    if (buttonIndex == 0) {
        NSLog(@"add item") ;
        [collectionManager addToCollectionWithValue:wordLabel.text] ;
    }
    //have remove button?
    if ([ibActionSheet numberOfButtons] == 3) {
        if (buttonIndex == 1) {
            NSLog(@"remove item") ;
            [collectionManager removeFromCollectionWithValue:wordLabel.text] ;
        }
    }
}
#pragma mark - DataYearSelectViewControllerDelegate
-(void)didSelectDataYearWithYear:(NSNumber *)year {
    [self.topBarView.yearLabel setText:[NSString stringWithFormat:@"%@",year]] ;
    [self dismissViewControllerAnimated:YES completion:nil ] ;
    if (![dataYear isEqualToNumber:year]) {
        dataYear = year ;
        [self dataSetup] ;
    }
}
@end
