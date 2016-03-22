//
//  DataManager.m
//  毕业设计
//
//  Created by lanou on 16/3/22.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager



+(void)sharedDataManager
{
    static DataManager *dataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (dataManager == nil) {
            dataManager = [[DataManager alloc] init];
            
        }
    });
}


@end
