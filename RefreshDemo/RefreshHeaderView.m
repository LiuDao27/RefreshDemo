//
//  RefreshHeaderView.m
//  RefreshDemo
//
//  Created by lvshasha on 2017/8/25.
//  Copyright © 2017年 com.SmallCircle. All rights reserved.
//

#import "RefreshHeaderView.h"

@implementation RefreshHeaderView
- (void)setupStateTitle
{
    self.loadingStateString = @"正在刷新中...";
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
    self.statusLabel.frame = CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 20);
    self.refreshImageView.frame = CGRectMake(self.frame.size.width/2 - 68 - 10 - 19, self.frame.size.height - 30, 19, 19);
}

- (void)scrollViewContentOffsetDidChange
{
    if (self.scrollView.contentOffset.y > -self.scrollViewOriginalEdgeInsets.top) {
        // 向上滚动
        return;
    }
    
    if (self.scrollView.isDragging) {
        if (self.scrollView.contentOffset.y + self.scrollViewOriginalEdgeInsets.top < -60) {
            self.refreshState = RefreshStatePulling;
        } else {
            self.refreshState = RefreshStateNormal;
        }
    } else {
        if (self.refreshState == RefreshStatePulling) {
            self.refreshState = RefreshStateLoading;
        } else {
            self.refreshState = RefreshStateNormal;
        }
    }
}

- (void)setRefreshState:(RefreshState)refreshState
{
    if (_refreshState != refreshState) {
        _refreshState = refreshState;
        switch (refreshState) {
            case RefreshStateLoading:
            {
                self.statusLabel.text = self.loadingStateString;
                // 旋转
                self.refreshImageView.hidden = NO;
                [self logoImageViewAnation];
                [UIView animateWithDuration:0.2 animations:^{
                    UIEdgeInsets edgeInset = self.scrollViewOriginalEdgeInsets;
                    edgeInset.top += 60;
                    self.scrollView.contentInset = edgeInset;
                }];
            }
                break;
            case RefreshStateNormal: {
                self.refreshImageView.hidden = YES;
                [UIView animateWithDuration:0.2 animations:^{
                    self.scrollView.contentInset = self.scrollViewOriginalEdgeInsets;
                }];
            }
                break;
            case RefreshStatePulling: {
                
            }
                break;
            case RefreshStateNoMoreDate: {
                
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


@end
