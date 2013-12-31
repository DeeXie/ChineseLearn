//
//  DoubleTapShowItemViewController.m
//  普通话高频词句
//
//  Created by xieweizhi on 12/21/13.
//  Copyright (c) 2013 xieweizhi. All rights reserved.
//

#import "DoubleTapShowItemViewController.h"

@interface DoubleTapShowItemViewController ()

@end

@implementation DoubleTapShowItemViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    //set up the spell label
    NSString *itemString = self.itemString ;
    NSMutableString *buffer = [itemString mutableCopy] ;
    CFMutableStringRef string = (__bridge CFMutableStringRef)buffer;
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    
    self.spellLabel.text = buffer ;
    self.itemLabel.text = self.itemString ;
    
    
    UITapGestureRecognizer  *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:) ] ;
    singleTapGesture.numberOfTapsRequired = 1 ;
    [self.view addGestureRecognizer:singleTapGesture] ;
}

-(void ) singleTapAction :(UIGestureRecognizer *) gesture {
    
    [self dismissViewControllerAnimated:YES completion:nil ] ;
}


@end
