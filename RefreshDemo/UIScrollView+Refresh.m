//
//  UIScrollView+Refresh.m
//  RefreshDemo
//
//  Created by lvshasha on 2017/8/25.
//  Copyright © 2017年 com.SmallCircle. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import "RefreshHeaderView.h"
#import "RefreshFooterView.h"

@implementation UIScrollView (Refresh)
- (RefreshHeaderView *)addHeaderViewWithRefreshHandler:(RefreshHandler)refreshHandler
{
    RefreshHeaderView *header = [[RefreshHeaderView alloc] initWithFrame:CGRectMake(0, -60, [UIScreen mainScreen].bounds.size.width, 60)];
    header.refreshHandler = refreshHandler;
    [self addSubview:header];
    return header;
}

// 不存在block
- (RefreshHeaderView *)addHeaderView;
{
    RefreshHeaderView *header = [[RefreshHeaderView alloc] initWithFrame:CGRectMake(0, -60, [UIScreen mainScreen].bounds.size.width, 60)];
    [self addSubview:header];
    return header;
}
- (RefreshFooterView *)addFooterView
{
    RefreshFooterView *footer = [[RefreshFooterView alloc] initWithFrame:CGRectMake(0, -60, [UIScreen mainScreen].bounds.size.width, 60)];
    [self addSubview:footer];
    return footer;
}

@end
