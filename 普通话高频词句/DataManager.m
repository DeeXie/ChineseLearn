//
//  DataManager.m
//  普通话高频词句
//
//  Created by xieweizhi on 12/21/13.
//  Copyright (c) 2013 xieweizhi. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager
{
    
}

+(instancetype)sharedDataManager {
    static DataManager *single  ;
    @synchronized(self)  {
        if (!single) {
            single = [[DataManager alloc] init] ;
        }
    }
    return single ;
}

-(NSArray *) getDataArrayWithType:(kDataType) type year:(NSNumber *) year {
    if (!year) {
        year = @2013 ;
    }
    NSString *plistPath = [self getDataPlistPathWithType:type year:year] ;
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:plistPath] ;
    if (dataArray) {
        return dataArray ;
    } else {
        [self loadDataFromPlistWitDataType:type] ;
        return [NSArray arrayWithContentsOfFile:plistPath] ;
    }
}

-(NSArray *) loadDataArrayFromStringFile:(kDataType) type  year:(NSNumber *)year{
    //parse the string to word and expression array
    NSDictionary *dataDic  ;
    if(type == kDataTypeSingleWordType) {
        dataDic = kAllWordData ;
    } else
        dataDic = kAllExpressionData ;
    NSString *dataString = dataDic[year] ;

    //remove all the white spaces
    NSMutableArray *dataWithWhite = [NSMutableArray arrayWithArray:[dataString componentsSeparatedByString:@" "]];
    [dataWithWhite removeObject:@""] ;
    NSArray *dataArray = [NSArray arrayWithArray:dataWithWhite] ;
    
    return dataArray ;
}

-(void) loadDataFromPlistWitDataType:(kDataType) type {
    
    NSFileManager *fileManager = [NSFileManager defaultManager] ;
    NSArray *years = kAllYears ;
    
    for (NSNumber *year in years) {
        NSString *plistPath  ;
        plistPath = [self getDataPlistPathWithType:type year:year] ;
        if (![fileManager fileExistsAtPath:plistPath]) {
            //如何plist 不存在，create
            NSArray *dataArray = [self loadDataArrayFromStringFile:type year:year] ;
            [dataArray writeToFile:plistPath atomically:YES] ;
        }
    }
}

-(NSString *) getDataPlistPathWithType:(kDataType) type year:(NSNumber *) year {
    NSString *plistPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName ;
    if (type == kDataTypeSingleWordType) {
        fileName = @"singleword" ;
    } else
        fileName = @"expression" ;
    return [plistPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@.plist",fileName,year]] ;
}

-(NSString *)convertStringToSpell:(NSString *)string {
    //get the spell of the word
    NSMutableString *spell = [string mutableCopy] ;
    CFMutableStringRef buffer = (__bridge CFMutableStringRef)spell;
    CFStringTransform(buffer, NULL, kCFStringTransformMandarinLatin, NO);
    
    return spell ;
}

@end
