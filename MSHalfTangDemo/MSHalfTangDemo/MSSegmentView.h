//
//  MSSegmentView.h
//  MSHalfTangDemo
//
//  Created by msj on 2017/6/28.
//  Copyright © 2017年 msj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSSegmentView : UIView
@property (strong, nonatomic) NSArray *datas;
@property (copy, nonatomic) void (^didSelectedItem)(NSUInteger item);
- (void)updateWithIndex:(NSInteger)index;
@end
