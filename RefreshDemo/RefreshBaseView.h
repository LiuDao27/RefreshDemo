//
//  RefreshBaseView.h
//  RefreshDemo
//
//  Created by lvshasha on 2017/8/25.
//  Copyright © 2017年 com.SmallCircle. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RefreshState) {
    RefreshStateNormal,                 // 正常
    RefreshStatePulling,                // 下拉
    RefreshStateLoading,                // 加载
    RefreshStateNoMoreDate,             // 上啦加载显示没有更多数据
};

@class RefreshBaseView;
typedef void(^RefreshHandler) (RefreshBaseView *refreshView);
@interface RefreshBaseView : UIView
{
    RefreshState _refreshState;//!<当前刷新状态
}
@property (nonatomic, copy) RefreshHandler refreshHandler;
@property (nonatomic, assign) RefreshState refreshState;        // 当前刷新状态

// 文字处理
@property (nonatomic, strong) NSString *loadingStateString;     // 正在刷新中
@property (nonatomic, strong) NSString *noMoreLoadingStateString; // 没有更多数据

//
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) UIEdgeInsets scrollViewOriginalEdgeInsets;
// UI
@property (nonatomic, strong) UILabel *statusLabel;             // 状态label
@property (nonatomic, strong) UIImageView *refreshImageView;    // 图片View

// 加载文字
- (void)setupStateTitle;
// 基础刷新view处理问题
- (void)addRefreshContentView;
// 结束刷新
- (void)endRefresh;
// 没有更多数据
- (void)showNoMoreData;
// 当scrollView的contentOffset发生改变的时候调用
- (void)scrollViewContentOffsetDidChange;
// 当scrollView的contentSize发生改变的时候调用
- (void)scrollViewContentSizeDidChange;
@end
