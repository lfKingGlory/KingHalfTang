//
//  MSSegmentView.m
//  MSHalfTangDemo
//
//  Created by msj on 2017/6/28.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSSegmentView.h"
#import "UIView+Extension.h"
#import "MSSegmentCell.h"
#import "UIColor+StringColor.h"

@interface MSSegmentView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIView *line;
@end

@implementation MSSegmentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.scrollsToTop = NO;
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[MSSegmentCell class] forCellWithReuseIdentifier:@"MSSegmentCell"];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = [UIColor redColor];
    self.line.height = 2;
    self.line.y = self.height - 2;
    [self.collectionView addSubview:self.line];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
    bottomLine.backgroundColor = [UIColor ms_colorWithHexString:@"#f8f8f8"];
    [self addSubview:bottomLine];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSSegmentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSSegmentCell" forIndexPath:indexPath];
    cell.model = self.datas[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectedItem) {
        self.didSelectedItem(indexPath.item);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSSegmentModel *model = self.datas[indexPath.item];
    return CGSizeMake(model.width, model.height);
}

- (void)updateWithIndex:(NSInteger)index contentOffsetXProgress:(CGFloat)contentOffsetXProgress {
    
    NSInteger nextIndex = 0;
    nextIndex = MIN(index + 1, self.datas.count - 1);
    MSSegmentModel *currentModel = self.datas[index];
    MSSegmentModel *nextModel = self.datas[nextIndex];
    CGFloat progress = contentOffsetXProgress - floor(contentOffsetXProgress);
    
    if (contentOffsetXProgress >= 0) {
        self.line.x = (currentModel.x + currentModel.padding) + (nextModel.x - currentModel.x) * progress;
        self.line.width = (currentModel.width - currentModel.padding * 2) + (nextModel.width - currentModel.width) * progress;
        
        nextModel.isSelected = (progress >= 0.5);
        currentModel.isSelected = !(progress >= 0.5);
    }
    
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self.collectionView reloadData];
}

@end
