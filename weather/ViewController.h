//
//  ViewController.h
//  weather
//
//  Created by Yuta Makino on 2015/06/02.
//  Copyright (c) 2015年 Yuta Makino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong)UIImageView *backgroundImageView;
@property (nonatomic, strong)UIImageView *blurredImageView;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)CGFloat screenHeight;


@end

