//
//  RefreshFooterView.m
//  RefreshDemo
//
//  Created by lvshasha on 2017/8/28.
//  Copyright © 2017年 com.SmallCircle. All rights reserved.
//

#import "RefreshFooterView.h"

@implementation RefreshFooterView
- (void)setupStateTitle
{
    self.loadingStateString = @"努力加载中...";
    self.noMoreLoadingStateString = @"没有更多数据";
}

- (void)addRefreshContentView
{
    [super addRefreshContentView];
    
    //
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.frame.size.width, 20)];
    self.statusLabel.textColor = [UIColor grayColor];
    self.statusLabel.font = [UIFont systemFontOfSize:12];
    self.statusLabel.backgroundColor = [UIColor clearColor];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.statusLabel];
    
    //
    self.refreshImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 68 - 10 - 19, 10, 19, 19)];
    self.refreshImageView.image = [UIImage imageNamed:@"logo.png"];
    self.refreshImageView.hidden = YES;
    [self addSubview:self.refreshImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.statusLabel.frame = CGRectMake(0, 10, self.frame.size.width, 20);
    self.refreshImageView.frame = CGRectMake(self.frame.size.width/2 - 68 - 10 - 19, 10, 19, 19);
}

- (void)scrollViewContentSizeDidChange {
    CGRect frame = self.frame;
    frame.origin.y = MAX(self.scrollView.frame.size.height, self.scrollView.contentSize.height);
    self.frame = frame;
}

- (void)scrollViewContentOffsetDidChange
{
    if (self.refreshState == RefreshStateNoMoreDate) {
        return;
    }
    
    //scrollview实际显示内容高度
    CGFloat realHeight = self.scrollView.frame.size.height - self.scrollViewOriginalEdgeInsets.top - self.scrollViewOriginalEdgeInsets.bottom;
    /// 计算超出scrollView的高度
    CGFloat beyondScrollViewHeight = self.scrollView.contentSize.height - realHeight;
    if (beyondScrollViewHeight <= 0) {
        //scrollView的实际内容高度没有超出本身高度不处理
        return;
    }
    
    //刚刚出现底部控件时出现的offsetY
    CGFloat offSetY = beyondScrollViewHeight - self.scrollViewOriginalEdgeInsets.top;
    // 当前scrollView的contentOffsetY超出offsetY的高度
    CGFloat beyondOffsetHeight = self.scrollView.contentOffset.y - offSetY;
    if (beyondOffsetHeight <= 0) {
        return;
    }
    
    if (self.scrollView.isDragging) {
        if (beyondOffsetHeight > 60) {
            self.refreshState = RefreshStatePulling;
        }else {
            self.refreshState = RefreshStateNormal;
        }
    } else {
        if (self.refreshState == RefreshStatePulling) {
            self.refreshState = RefreshStateLoading;
        }else {
            self.refreshState = RefreshStateNormal;
        }
    }
}

- (void)setRefreshState:(RefreshState)refreshState
{
    if (_refreshState != refreshState) {
        _refreshState = refreshState;
        switch (refreshState) {
            case RefreshStateNormal:
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.scrollView.contentInset = self.scrollViewOriginalEdgeInsets;
                }];
            }
                break;
             case RefreshStatePulling:
            {
                
            }
                break;
            case RefreshStateLoading: {
                self.statusLabel.text = self.loadingStateString;
                self.refreshImageView.hidden = NO;
                [self logoImageViewAnation];
                [UIView animateWithDuration:0.2 animations:^{
                    UIEdgeInsets inset = self.scrollView.contentInset;
                    inset.bottom += 60;
                    self.scrollView.contentInset = inset;
                    inset.bottom = self.frame.origin.y - self.scrollView.contentSize.height + 60;
                    self.scrollView.contentInset = inset;
                }];
            }
                break;
            case RefreshStateNoMoreDate: {
                self.statusLabel.text = self.noMoreLoadingStateString;
                self.refreshImageView.hidden = YES;
            }
                break;
            default:
                break;
        }
    }
}

- (void)logoImageViewAnation
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 99999999;
    [self.refreshImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


- (void)showNoMoreData {
    [self endRefresh];
    self.refreshState = RefreshStateNoMoreDate;
}





@end
