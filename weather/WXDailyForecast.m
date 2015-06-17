//
//  WXDailyForecast.m
//  weather
//
//  Created by Yuta Makino on 2015/06/16.
//  Copyright (c) 2015年 Yuta Makino. All rights reserved.
//

#import "WXDailyForecast.h"

@implementation WXDailyForecast

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"通ってる？6");
    // 1
    NSMutableDictionary *paths = [[super JSONKeyPathsByPropertyKey] mutableCopy];
    // 2
    paths[@"tempHigh"] = @"temp.max";
    paths[@"tempLow"] = @"temp.min";
    // 3
    return paths;
    
}

@end
