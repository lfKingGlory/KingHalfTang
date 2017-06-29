//
//  MSHomeView.h
//  MSHalfTangDemo
//
//  Created by msj on 2017/6/28.
//  Copyright © 2017年 msj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSHomeView : UIView
@property (nonatomic, strong) UITableView *tableView;
@property (copy, nonatomic) void (^didScrollBlock)(UITableView *tableView);
@property (copy, nonatomic) void (^didEndScrollBlock)(UITableView *tableView);
@end
