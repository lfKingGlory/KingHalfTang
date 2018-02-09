//
//  MSSegmentModel.m
//  MSHalfTangDemo
//
//  Created by msj on 2017/6/28.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSSegmentModel.h"

@implementation MSSegmentModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _x = 0;
        _width = 0;
        _height = 0;
        _isSelected = NO;
        _title = nil;
        _padding = 10;
    }
    return self;
}
@end
