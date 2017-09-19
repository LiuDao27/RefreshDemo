//
//  UIScrollView+Refresh.h
//  RefreshDemo
//
//  Created by lvshasha on 2017/8/25.
//  Copyright © 2017年 com.SmallCircle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshBaseView.h"

@class RefreshHeaderView;
@class RefreshFooterView;

@interface UIScrollView (Refresh)

// block
- (RefreshHeaderView *)addHeaderViewWithRefreshHandler:(RefreshHandler)refreshHandler;
// 不存在block
- (RefreshHeaderView *)addHeaderView;
- (RefreshFooterView *)addFooterView;
@end
