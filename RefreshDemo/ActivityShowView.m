//
//  ActivityShowView.m
//  RefreshDemo
//
//  Created by lvshasha on 2017/8/28.
//  Copyright © 2017年 com.SmallCircle. All rights reserved.
//

#import "ActivityShowView.h"

@interface ActivityShowView ()
@property (nonatomic, strong) UIImageView *showImageView;
@end

@implementation ActivityShowView
+ (instancetype)addShowActivityShowView
{
    ActivityShowView *showView = [[ActivityShowView alloc] initWithShowActivityShowView];
    [[UIApplication sharedApplication].keyWindow addSubview:showView];
    return showView;
}

- (instancetype)initWithShowActivityShowView
{
    if (self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.frame])
    {
        self.backgroundColor = [UIColor yellowColor];
        
        //
//        UIView *coverView = [[UIView alloc]initWithFrame:frame];
//        coverView.backgroundColor = [UIColor redColor];
//        coverView.tag = 34000;
//        [self addSubview:coverView];
        
        
//
//
    }
    return self;
}


- (void)logoImageViewAnation
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 99999999;
    [self.showImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
@end
