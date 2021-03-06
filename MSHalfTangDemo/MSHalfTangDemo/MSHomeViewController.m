//
//  ViewController.m
//  MSHalfTangDemo
//
//  Created by msj on 2017/6/28.
//  Copyright © 2017年 msj. All rights reserved.
//


#import "MSHomeViewController.h"
#import "MSHomeView.h"
#import "MSSegmentView.h"
#import "MSHomeNavigationBar.h"
#import "SDCycleScrollView.h"
#import "MSSegmentModel.h"
#import "YYFPSLabel.h"
#import "UIView+Extension.h"

#define SCREEN_HEIGHT                      [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                       [UIScreen mainScreen].bounds.size.width

@interface MSHomeViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) MSSegmentView *segMengtView;
@property (strong, nonatomic) MSHomeNavigationBar *homeNavigationBar;
@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) UITableView *currentTableView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSMutableArray *tableViews;
@property (nonatomic, strong) NSMutableArray *segments;
@property (nonatomic, assign) CGFloat lastTableViewOffsetY;


@end

@implementation MSHomeViewController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
    [self addSubViews];
}

#pragma mark - Private
- (void)configure {
    self.lastTableViewOffsetY = -240;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableViews = [NSMutableArray array];
    self.segments = [NSMutableArray array];
    NSArray *datas = @[@"推荐",@"原创",@"热门",@"美食",@"生活",@"设计感",@"家居",@"礼物",@"阅读",@"运动健身",@"旅行户外"];
    
    CGFloat x = 0;
    for (int i = 0; i < datas.count; i++) {
        MSSegmentModel *model = [MSSegmentModel new];
        model.title = datas[i];
        model.isSelected = (i == 0);
        CGSize size = [model.title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}];
        model.padding = 10;
        model.width = size.width + model.padding * 2;
        model.height = 40;
        model.x = x;
        x = model.x + model.width;
        [self.segments addObject:model];
    }
}

- (void)addSubViews {
    [self.view addSubview:self.mainScrollView];
    [self.view addSubview:self.cycleScrollView];
    [self.view addSubview:self.segMengtView];
    [self.view addSubview:self.homeNavigationBar];
    [self scrollViewDidScroll:self.mainScrollView];
    
    YYFPSLabel *fps = [YYFPSLabel new];
    [fps sizeToFit];
    fps.x = self.view.width - fps.width - 20;
    fps.y = self.view.height - fps.height - 40;
    [self.view addSubview:fps];
    
}

- (void)changeTopOtherViewsFrameWithTableView:(UITableView *)tableView {
    
    CGFloat tableViewoffsetY = tableView.contentOffset.y;
    self.lastTableViewOffsetY = tableViewoffsetY;
    
    if (self.currentTableView == tableView) {
        
        if( self.lastTableViewOffsetY < -240){

            self.segMengtView.frame = CGRectMake(0, 200, SCREEN_WIDTH, 40);
            self.cycleScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);

        }else if ( self.lastTableViewOffsetY>=-240 &&  self.lastTableViewOffsetY<=-104) {

            self.segMengtView.frame = CGRectMake(0, (200 - (240+tableViewoffsetY)), SCREEN_WIDTH, 40);
            self.cycleScrollView.frame = CGRectMake(0, -(240+tableViewoffsetY), SCREEN_WIDTH, 200);

        } else if ( self.lastTableViewOffsetY > -104){

            self.segMengtView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 40);
            self.cycleScrollView.frame = CGRectMake(0, -136, SCREEN_WIDTH, 200);
        }
        
//        if( self.lastTableViewOffsetY <=-104){
//
//            self.segMengtView.frame = CGRectMake(0, (200 - (240+tableViewoffsetY)), SCREEN_WIDTH, 40);
//            self.cycleScrollView.frame = CGRectMake(0, -(240+tableViewoffsetY), SCREEN_WIDTH, 200);
//
//        } else if ( self.lastTableViewOffsetY > -104){
//
//            self.segMengtView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 40);
//            self.cycleScrollView.frame = CGRectMake(0, -136, SCREEN_WIDTH, 200);
//        }
    }
    
}

- (void)changeTableViewsContentOffset {
    
    for (UITableView *tableView in self.tableViews) {

        if (self.currentTableView != tableView) {

            if(self.lastTableViewOffsetY < -240){

                tableView.contentOffset = CGPointMake(0, -240);

            }else if (self.lastTableViewOffsetY>=-240 && self.lastTableViewOffsetY<=-104) {

                tableView.contentOffset = CGPointMake(0, self.lastTableViewOffsetY);

            } else if (self.lastTableViewOffsetY > -104){

                if (tableView.contentOffset.y <= -104) {
                    tableView.contentOffset = CGPointMake(0, -104);
                }
            }
            
            
            
//            if(self.lastTableViewOffsetY <= -104){
//
//                tableView.contentOffset = CGPointMake(0, self.lastTableViewOffsetY);
//
//            } else if ( self.lastTableViewOffsetY > -104){
//
//                if (tableView.contentOffset.y <= -104) {
//                    tableView.contentOffset = CGPointMake(0, -104);
//                }
//
//            }
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView != self.mainScrollView) {
        return;
    }
    
    CGFloat progressX = scrollView.contentOffset.x/scrollView.frame.size.width;
    int index =  progressX;
    self.currentTableView.scrollsToTop = NO;
    self.currentTableView  = self.tableViews[index];
    self.currentTableView.scrollsToTop = YES;
    [self.segMengtView updateWithIndex:index contentOffsetXProgress:progressX];
}

#pragma mark - lazy
- (UIScrollView *)mainScrollView {
    
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _mainScrollView.delegate = self;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.backgroundColor = [UIColor whiteColor];
        _mainScrollView.scrollsToTop = NO;
#ifdef __IPHONE_11_0
        if (@available(iOS 11.0, *)) {
            _mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
#endif
        for (int i = 0; i < self.segments.count; i++) {
            
            __weak typeof(self) weakSlef = self;
            MSHomeView *homeView = [[MSHomeView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            homeView.didScrollBlock = ^(UITableView *tableView) {
                [weakSlef changeTopOtherViewsFrameWithTableView:tableView];
            };
            
            homeView.didEndScrollBlock = ^(UITableView *tableView) {
                [weakSlef changeTableViewsContentOffset];
            };
            
            [self.mainScrollView addSubview:homeView];
            [self.tableViews addObject:homeView.tableView];
        }
        
        self.currentTableView = self.tableViews[0];
        _mainScrollView.contentSize = CGSizeMake(self.tableViews.count * SCREEN_WIDTH, 0);
        
    }
    return _mainScrollView;
}

- (SDCycleScrollView *)cycleScrollView {
    
    if (!_cycleScrollView) {
        
        NSMutableArray *imageMutableArray = [NSMutableArray array];
        for (int i = 1; i < 9; i++) {
            NSString *imageName = [NSString stringWithFormat:@"cycle_%02d.jpg",i];
            [imageMutableArray addObject:imageName];
        }
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) imageNamesGroup:imageMutableArray];
        
    }
    return _cycleScrollView;
}

- (MSSegmentView *)segMengtView {
    if (!_segMengtView) {
        __weak typeof(self) weakSlef = self;
        _segMengtView = [[MSSegmentView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 40)];
        _segMengtView.datas = self.segments;
        _segMengtView.didSelectedItem = ^(NSInteger item) {
            NSInteger currentIndex = self.mainScrollView.contentOffset.x/self.mainScrollView.frame.size.width;
            if (labs(currentIndex - item) == 1) {
                [weakSlef.mainScrollView setContentOffset:CGPointMake(item * SCREEN_WIDTH, 0) animated:YES];
            } else {
                weakSlef.mainScrollView.contentOffset = CGPointMake(item * SCREEN_WIDTH, 0);
            }
        };
    }
    return _segMengtView;
}

- (MSHomeNavigationBar *)homeNavigationBar {
    
    if (!_homeNavigationBar) {
        _homeNavigationBar = [[MSHomeNavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _homeNavigationBar.tableViews = self.tableViews;
    }
    return _homeNavigationBar;
}
@end
