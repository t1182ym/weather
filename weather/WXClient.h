//
//  WXClient.h
//  weather
//
//  Created by Yuta Makino on 2015/06/16.
//  Copyright (c) 2015年 Yuta Makino. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
#import <ReactiveCocoa/ReactiveCocoa.h>
@import Foundation;


@interface WXClient : NSObject

- (RACSignal *)fetchJSONFromURL:(NSURL *)url; //クラス名 変数名:メソッド名 引数
- (RACSignal *)fetchCurrentConditionsForLocation:(CLLocationCoordinate2D)coordinate;//Reactive Cocoaは自動的に値が変わるときに有効 つまり、Reactive
- (RACSignal *)fetchHourlyForecastForLocation:(CLLocationCoordinate2D)coordicate;
- (RACSignal *)fetchDailyForecastForLocation:(CLLocationCoordinate2D)coordicate;
@end
