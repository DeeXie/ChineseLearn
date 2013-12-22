//
//  CollectManager.h
//  普通话高频词句
//
//  Created by xieweizhi on 12/20/13.
//  Copyright (c) 2013 xieweizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCollectionKindSingleWord @"0"
#define kCollectionKindExpression @"1"


@interface CollectManager : NSObject

@property(nonatomic ,strong) NSArray *singleWordCollection ;
@property(nonatomic ,strong) NSArray *expressionCollection ;
@property(nonatomic , strong) NSDictionary *collectionDic ;

+(instancetype) sharedCollectManager ;


-(BOOL) isItemInCollection:(NSString *) valueToSearch ;
-(void) clearAllCollections ;

-(void) removeFromCollectionWithValue:(NSString *)valueToRemove ;
-(void) addToCollectionWithValue:(NSString *) value;

@end
