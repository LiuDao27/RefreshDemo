//
//  ViewController.m
//  RefreshDemo
//
//  Created by lvshasha on 2017/8/25.
//  Copyright © 2017年 com.SmallCircle. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+Refresh.h"
#import "RefreshHeaderView.h"
#import "RefreshFooterView.h"

#import "ActivityShowView.h"     // 加载view

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) RefreshHeaderView *headerView;
@property (nonatomic, strong) RefreshFooterView *footerView;
@property (nonatomic, strong) UITableView *tableView;

//
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIImageView *showImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RefreshCellReuseId"];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView reloadData];
    [self.view addSubview:self.tableView];
    [self addRefreshView];
    
    
    
    // 测试
    [self performSelector:@selector(headerResfreshView) withObject:nil afterDelay:5];
    // 测试加载
    [self performSelector:@selector(loadMoreData) withObject:nil afterDelay:5];
}

- (void)addRefreshView
{
    // 结束怎么处理？？？？
    __weak typeof(self) weakSelf = self;
//    self.headerView = [self.tableView addHeaderViewWithRefreshHandler:^(RefreshBaseView *refreshView) {
//        
//    }];
    self.headerView = [self.tableView addHeaderView];
    self.footerView = [self.tableView addFooterView];
}

// 结束刷新
- (void)headerResfreshView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.headerView endRefresh];
    });
}

- (void)loadMoreData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
//        [self.footerView showNoMoreData];
        
        [self.footerView endRefresh];
        
        
        
        
//        if (_selectedRow == 3 && _rows >= 40) {//控制上拉加载最多个数为30
////            [_refreshFooterView showNoMoreData];
//        }else {
////            [_refreshFooterView endRefresh];
//        }
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RefreshCellReuseId" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", (long)indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        // controller
        [self addShowActivityShowView];
    } else {
        [self hideShowActivityShowView];
    }
}


// 处理旋转动画
- (void)addShowActivityShowView
{
    UIView *coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    coverView.tag = 34000;
    [self.view addSubview:coverView];
    self.coverView = coverView;
    //
    if (!self.showImageView) {
        self.showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 19)];
        self.showImageView.center = self.view.center;
        self.showImageView.image = [UIImage imageNamed:@"logo.png"];
        self.showImageView.alpha = 0;
        [self.view addSubview:self.showImageView];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.showImageView.alpha = 1;
        [self logoImageViewAnation];
        
        [self performSelector:@selector(hideShowActivityShowView) withObject:nil afterDelay:3];

    } completion:nil];
}

- (void)hideShowActivityShowView
{
    self.showImageView.alpha = 1;
    [UIView animateWithDuration:0.5 animations:^{
        self.showImageView.alpha = 0;
        [self.coverView removeFromSuperview];
//        [self.showImageView removeFromSuperview];
        self.coverView = nil;
//        self.showImageView = nil;
    } completion:nil];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
