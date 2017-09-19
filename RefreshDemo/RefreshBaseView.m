//
//  RefreshBaseView.m
//  RefreshDemo
//
//  Created by lvshasha on 2017/8/25.
//  Copyright © 2017年 com.SmallCircle. All rights reserved.
//

#import "RefreshBaseView.h"

@implementation RefreshBaseView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self addRefreshContentView];
        [self setupStateTitle];
        self.refreshState = RefreshStateNormal;
    }
    return self;
}

//
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    [self removeScrollViewObservers];
    if ([newSuperview isKindOfClass:[UIScrollView class]]) {
        self.scrollView = (UIScrollView *)newSuperview;
        self.scrollViewOriginalEdgeInsets = self.scrollView.contentInset;
        [self addScrollViewObservers];
    }
}

//
- (void)addScrollViewObservers
{
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [self.scrollView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:nil];
}

//
- (void)removeScrollViewObservers
{
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        [self.superview removeObserver:self forKeyPath:@"contentOffset" context:nil];
        [self.superview removeObserver:self forKeyPath:@"contentSize" context:nil];
        [self.superview removeObserver:self forKeyPath:@"contentInset" context:nil];
    }
}

// 加载文字
- (void)setupStateTitle
{
    
}

// 基础刷新view处理问题
- (void)addRefreshContentView
{
    
}
// 没有更多数据
- (void)showNoMoreData
{
    
}
// 结束刷新
- (void)endRefresh
{
    self.refreshState = RefreshStateNormal;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        // 正在刷新
        if (_refreshState == RefreshStateLoading) {
            return;
        }
        [self scrollViewContentOffsetDidChange];
    } else if ([keyPath isEqualToString:@"contentSize"]) {
        [self scrollViewContentSizeDidChange];
    } else if ([keyPath isEqualToString:@"contentInset"]) {
        if (_refreshState == RefreshStateLoading) {
            return;
        }
        _scrollViewOriginalEdgeInsets = self.scrollView.contentInset;
    }
}
// 当scrollView的contentOffset发生改变的时候调用
- (void)scrollViewContentOffsetDidChange
{
    
}
// 当scrollView的contentSize发生改变的时候调用
- (void)scrollViewContentSizeDidChange
{
    
}
@end
