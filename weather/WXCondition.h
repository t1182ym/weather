//
//  WXCondition.h
//  weather
//
//  Created by Yuta Makino on 2015/06/16.
//  Copyright (c) 2015年 Yuta Makino. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>

@interface WXCondition : MTLModel <MTLJSONSerializing>

@property(nonatomic, strong) NSData *date;
@property(nonatomic, strong) NSNumber *humidity;
@property(nonatomic, strong) NSNumber *temperature;
@property(nonatomic, strong) NSNumber *tempHigh;
@property(nonatomic, strong) NSNumber *tempLow;
@property(nonatomic, strong) NSString *locationName;
@property(nonatomic, strong) NSData *sunrise;
@property(nonatomic, strong) NSData *sunset;
@property(nonatomic, strong) NSString *conditionDescription;
@property(nonatomic, strong) NSString *condition;
@property(nonatomic, strong) NSNumber *windBearing;
@property(nonatomic, strong) NSNumber *windSpeed;
@property(nonatomic, strong) NSString *icon;

-(NSString *)imageName;




@end
