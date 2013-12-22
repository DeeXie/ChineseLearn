//
//  CollectManager.m
//  普通话高频词句
//
//  Created by xieweizhi on 12/20/13.
//  Copyright (c) 2013 xieweizhi. All rights reserved.
//

#import "CollectManager.h"

@implementation CollectManager
@synthesize collectionDic = _collectionDic, singleWordCollection = _singleWordCollection ,expressionCollection = _expressionCollection ;


-(id)init {
    if (self = [super init]) {
        [self loadCollectionFromPlist] ;
    }
    return self ;
}
+(instancetype)sharedCollectManager {
    static CollectManager  *single  ;
    @synchronized(self) {
        if (!single) {
            single = [[CollectManager alloc] init] ;
        }
    }
    return single ;
}

#pragma mark - getters
-(NSArray *)singleWordCollection {
    _singleWordCollection = [_collectionDic objectForKey:kCollectionKindSingleWord] ;
    return  _singleWordCollection;
}
-(NSArray *)expressionCollection {
    _expressionCollection = [_collectionDic objectForKey:kCollectionKindExpression] ;
    return _expressionCollection;
}

-(NSDictionary *)collectionDic {
    if (!_collectionDic) {
        [self loadCollectionFromPlist] ;
    }
    return _collectionDic ;
}



#pragma mark - collection control
-(BOOL) isItemInCollection:(NSString *) valueToSearch  {
    NSArray *items  ;
    // what kind of collection you want to search?
    if (valueToSearch.length == @"你".length) {
        items = [_collectionDic objectForKey:kCollectionKindSingleWord] ;
        BOOL isContained = [items containsObject:valueToSearch] ;
        return  isContained;
    } else {
        items = [_collectionDic objectForKey:kCollectionKindExpression] ;
        BOOL isContained = [items containsObject:valueToSearch] ;
        return  isContained;
    }
}

-(void) removeFromCollectionWithValue:(NSString *)valueToRemove {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_collectionDic] ;
    NSMutableArray *items  ;
    if (valueToRemove.length == @"你".length) {
        //add to word collection
        items = [self.collectionDic objectForKey:kCollectionKindSingleWord] ;
        [items removeObject:valueToRemove] ;
        [dic setObject:items forKey:kCollectionKindSingleWord] ;
    } else {
        //add to expression collection
        items = [self.collectionDic objectForKey:kCollectionKindExpression] ;
        [items removeObject:valueToRemove] ;
        [dic setObject:items forKey:kCollectionKindExpression] ;
    }
    _collectionDic = dic ;
    [_collectionDic writeToFile:[self pathForCollectionPlist] atomically:YES] ;
    
}
-(void) addToCollectionWithValue:(NSString *) value {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_collectionDic] ;
    NSMutableArray *items  ;
    if (value.length == @"你".length) {
        items = [NSMutableArray arrayWithArray:[dic  objectForKey:kCollectionKindSingleWord]] ;
        if (![items containsObject:value]) {
            [items addObject:value] ;
            [dic setObject:items forKey:kCollectionKindSingleWord] ;
        }
    } else {
        items = [NSMutableArray arrayWithArray:[dic  objectForKey:kCollectionKindExpression]] ;
        if (![items containsObject:value ]) {
            [items addObject:value] ;
            [dic setObject:items forKey:kCollectionKindExpression] ;
        }
    }
    self.collectionDic = dic ;
    [dic writeToFile:[self pathForCollectionPlist] atomically:YES] ;

}

#pragma mark - plist method
-(void) loadCollectionFromPlist {
    NSString *path = [self pathForCollectionPlist] ;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        //create the collection plist if it's not exist
        _collectionDic = @{kCollectionKindExpression:[[NSMutableArray alloc]init] ,
                           kCollectionKindSingleWord:[[NSMutableArray alloc]init]} ;

        [_collectionDic writeToFile:[self pathForCollectionPlist] atomically:YES] ;
    } else {
            _collectionDic = [NSDictionary dictionaryWithContentsOfFile:path ] ;
            _singleWordCollection = [_collectionDic objectForKey:kCollectionKindSingleWord] ;
            _expressionCollection = [_collectionDic objectForKey:kCollectionKindExpression] ;
    }
}


-(NSString *) pathForCollectionPlist {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"collection.plist"];

    return path ;
}

-(void)clearAllCollections {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_collectionDic] ;
    [dic setObject:[[NSMutableArray alloc]init ]forKey:kCollectionKindSingleWord];
    [dic setObject:[[NSMutableArray alloc]init ]  forKey:kCollectionKindExpression] ;
    _collectionDic = dic ;
    [_collectionDic writeToFile:[self pathForCollectionPlist] atomically:YES] ;
}
@end
