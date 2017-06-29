//
//  MSSegmentCell.m
//  MSHalfTangDemo
//
//  Created by msj on 2017/6/28.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSSegmentCell.h"
#import "UIView+Extension.h"
#import "UIColor+StringColor.h"

@interface MSSegmentCell ()
@property (strong, nonatomic) UILabel *lbTips;
@end

@implementation MSSegmentCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.lbTips = [[UILabel alloc] init];
        self.lbTips.font = [UIFont systemFontOfSize:15];
        self.lbTips.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.lbTips];
    }
    return self;
}

- (void)setModel:(MSSegmentModel *)model {
    _model = model;
    self.lbTips.text = model.title;
    self.lbTips.textColor = model.isSelected ? [UIColor redColor] : [UIColor ms_colorWithHexString:@"#999999"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = [self.model.title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}];
    self.lbTips.frame = CGRectMake((self.width - size.width)/2.0, 0, size.width, self.height);
}
@end
