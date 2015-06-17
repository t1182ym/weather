//
//  WXManager.m
//  weather
//
//  Created by Yuta Makino on 2015/06/16.
//  Copyright (c) 2015年 Yuta Makino. All rights reserved.
//

#import "WXManager.h"
#import "WXClient.h"
#import <TSMessages/TSMessage.h>

@interface WXManager()

@property (nonatomic, strong, readwrite) WXCondition *currentCondition;
@property (nonatomic, strong, readwrite) CLLocation *currentLocation;
@property (nonatomic, strong, readwrite) NSArray *hourlyForecast;
@property (nonatomic, strong, readwrite) NSArray *dailyForecast;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL isFirstUpdate;
@property (nonatomic, strong) WXClient *client;

@end

@implementation WXManager

+ (instancetype)sharedManager{
    NSLog(@"通ってる？3");
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc]init];
    });
    return _sharedManager;
}

- (id)init {
    
    if (self = [super init]) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        
        _client = [[WXClient alloc]init];
        
        [[[[RACObserve(self, currentLocation)
            
            ignore:nil]
           
           flattenMap:^(CLLocation *newLocation){
               return [RACSignal merge:@[
                                         [self updateCurrentConditions],
                                         [self updateDailyForecast],
                                         [self updateHourlyForecast]
                                         ]];
           }] deliverOn:RACScheduler.mainThreadScheduler]
         
         subscribeError:^(NSError *error) {
             [TSMessage showNotificationWithTitle:@"Error" subtitle:@"There was a problem fetching the latest weather." type:TSMessageNotificationTypeError];
         }];
    }
    return self;
}

- (void)findCurrentLocation {
    self.isFirstUpdate = YES;
    [self.locationManager startUpdatingLocation];
    NSLog(@"通ってる？4");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"locationManager");
    if(self.isFirstUpdate){
        self.isFirstUpdate = NO;
        return;
    }
    CLLocation *location = [locations lastObject];
    
    if(location.horizontalAccuracy > 0){
     self.currentLocation = location;
        [self.locationManager stopUpdatingLocation];
    }
    NSLog(@"locationManager");
}

- (RACSignal *)updateCurrentConditions {
    NSLog(@"通ってる？4");
    return [[self.client fetchCurrentConditionsForLocation:self.currentLocation.coordinate]
            doNext:^(WXCondition *condition){
                self.currentCondition = condition;
            }];
}

- (RACSignal *)updateHourlyForecast {
    return [[self.client fetchCurrentConditionsForLocation:self.currentLocation.coordinate]
            doNext:^(NSArray *conditions){
                self.hourlyForecast = conditions;
            }];
    
}

- (RACSignal *)updateDailyForecast {
    return [[self.client fetchCurrentConditionsForLocation:self.currentLocation.coordinate]
            doNext:^(NSArray *conditions){
                self.dailyForecast = conditions;
            }];
    
}
@end
