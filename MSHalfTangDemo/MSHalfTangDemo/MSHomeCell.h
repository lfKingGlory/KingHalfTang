//
//  MSHomeCell.h
//  MSHalfTangDemo
//
//  Created by msj on 2017/6/28.
//  Copyright © 2017年 msj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSHalfTangModel.h"

@interface MSHomeCell : UITableViewCell
+ (MSHomeCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) MSHalfTangModel *model;
@end
