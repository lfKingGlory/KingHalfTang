//
//  MSSegmentModel.h
//  MSHalfTangDemo
//
//  Created by msj on 2017/6/28.
//  Copyright © 2017年 msj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MSSegmentModel : NSObject
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL isSelected;

@property (assign, nonatomic) CGFloat padding;
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@end
