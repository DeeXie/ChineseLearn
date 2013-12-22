//
//  DataManager.h
//  普通话高频词句
//
//  Created by xieweizhi on 12/21/13.
//  Copyright (c) 2013 xieweizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppData.h"

typedef enum dataTypes {
    kDataTypeSingleWordType = 1 << 1,
    kDataTypeExpressionType = 1 << 2
} kDataType;

@interface DataManager : NSObject


+(instancetype) sharedDataManager ;

-(NSArray *) getDataArrayWithType:(kDataType) type year:(NSNumber *) year ;
-(NSString *) convertStringToSpell:(NSString *) string  ;
@end
