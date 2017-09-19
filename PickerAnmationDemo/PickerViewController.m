//
//  PickerViewController.m
//  PickerAnmationDemo
//
//  Created by lvshasha on 2017/9/7.
//  Copyright © 2017年 com.GlassStore. All rights reserved.
//

#import "PickerViewController.h"

#define KSCREEN_WIDTH ([UIScreen mainScreen].applicationFrame.size.width)
#define animationTime 0.7
#define containViewFrame CGRectMake(0, [UIScreen mainScreen].bounds.size.height-300, KSCREEN_WIDTH, 300)

@interface PickerViewController ()
@property (nonatomic, strong) UIView *blackBackGroundView;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UIView *customBarView;
@property (nonatomic, strong) NSString *showTitleString;
@property (nonatomic, strong) NSDate *lastReturnTime;
@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)creatMainUI
{
    //
    [self createBlackBackGroundView];
    [self createContainView];
    [self createShowBar];
    [self createTapView];
}

- (void)createBlackBackGroundView
{
    UIView *backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0.3f alpha:0.2f];
    self.blackBackGroundView = backView;
    [self.view addSubview:self.blackBackGroundView];
}

- (void)createContainView
{
    UIView *tempView = [[UIView alloc] init];
    self.containView = tempView;
    
    [self.containView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, KSCREEN_WIDTH, 0)];
    [UIView beginAnimations:@"ContainAnimation" context:(__bridge void *)(self.containView)];
    [UIView setAnimationDuration:animationTime];
    [UIView setAnimationDelegate:self];
    [self.containView setFrame:containViewFrame];
    [UIView commitAnimations];
    //添加内容
    self.containView.backgroundColor = [UIColor blackColor];
    [self.blackBackGroundView addSubview:self.containView];
}

- (void)createShowBar
{
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 44)];
    self.customBarView = tempView;
    [self.containView addSubview:self.customBarView];
    
    //创建label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 44)];
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.textColor = [UIColor colorWithWhite:0.5 alpha:1];
    label.textColor = [UIColor blackColor];
    [label setFont:[UIFont systemFontOfSize:20]];
    self.titleLabel = label;
    [self.customBarView addSubview:self.titleLabel];
    // 隐藏处理
    self.titleLabel.hidden = YES;
    
    // 白色
    self.customBarView.backgroundColor = [UIColor grayColor];
    
    // 添加文字左侧按钮 999999
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(10,7,49,30)];
    cancelButton.backgroundColor = [UIColor clearColor];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize: 18];
    cancelButton.titleLabel.textAlignment = NSTextAlignmentRight;
    cancelButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(tapBackButton) forControlEvents:UIControlEventTouchUpInside];
    self.leftButton = cancelButton;
    [self.customBarView addSubview:self.leftButton];
    
    // 添加右边按钮
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 49 - 10,7,49,30)];
    sureButton.backgroundColor = [UIColor clearColor];
    sureButton.titleLabel.font = [UIFont systemFontOfSize: 18];
    sureButton.titleLabel.textAlignment = NSTextAlignmentRight;
    sureButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(tapSureButton) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton = sureButton;
    [self.customBarView addSubview:self.rightButton];
}

- (void)createTapView
{
    UIView *a = [[UIView alloc] initWithFrame:CGRectMake(0, 0,KSCREEN_WIDTH, [UIScreen mainScreen].bounds.size.height-300)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapReturnPickerViewOnlyOnce)];
    [a addGestureRecognizer:tap];
    [self.blackBackGroundView addSubview:a];
}

#pragma - mark =========主窗口动画========
- (void)KeyWindowAnimation
{
    //创建window上的黑色视图
    UIView *black = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    black.tag = 10096;
    black.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication].keyWindow insertSubview:black belowSubview:[UIApplication sharedApplication].keyWindow.rootViewController.view];
    //动画
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationTime];
    //图形缩小
    if (self.closeAnmation) {
        
    }else{
        [UIApplication sharedApplication].keyWindow.rootViewController.view.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
    }
    [UIView commitAnimations];
}

//
- (void)tapReturnPickerViewOnlyOnce
{
    NSDate *nowDate = [NSDate date];
    NSTimeInterval time = [nowDate timeIntervalSinceDate:self.lastReturnTime];
    if (time < animationTime) {
        return;
    }else{
        self.lastReturnTime = [NSDate date];
        [self tapReturnPickerView];
    }
}

- (void)tapReturnPickerView
{
    //keyWindow动画
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationTime];
    [UIApplication sharedApplication].keyWindow.rootViewController.view.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView commitAnimations];
    //动画
    [self.containView setFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height-340+44, KSCREEN_WIDTH, 320-44)];
    [UIView beginAnimations:@"ContainAnimation" context:(__bridge void *)(self.containView)];
    [UIView setAnimationDuration:animationTime];
    [UIView setAnimationDelegate:self];
    [self.containView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, KSCREEN_WIDTH, 0)];
    [UIView commitAnimations];
    //延迟执行
    [self performSelector:@selector(removeViewAndVC) withObject:self afterDelay:0.7];
}

- (void)removeViewAndVC
{
    UIView *black = [[UIApplication sharedApplication].keyWindow viewWithTag:10096];
    [black removeFromSuperview];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

// 点击确定
- (void)tapSureButton
{
    
}

// 点击取消
- (void)tapBackButton
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

// 一层数据
@interface OnePickerViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIPickerView *dataPickerView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@end
@implementation OnePickerViewController

//初始化方法(带有关闭动画参数)
- (id)initWithOneClassModel:(NSMutableArray *)oneSource title:(NSString *)title parentController:(UIViewController *)parentController getDataFromTapFirstCell:(sendFirstValue )firstBlock closeKeyWindowAnimation:(BOOL)close
{
    if (self = [super init]) {
        self.firstBlock = firstBlock;
//        self.closeAnmation = close;
        self.showTitleString = title;
        self.dataArray = [NSMutableArray array];
        self.dataDic = [NSMutableDictionary dictionary];
        self.dataArray = oneSource;
        for (NSInteger i = 0; i < self.dataArray.count; i++) {
            NSMutableArray *dealWithArray = self.dataArray[i];
            [self.dataDic setObject:dealWithArray[0] forKey:@(i).stringValue];
        }
        [self KeyWindowAnimation];
        [[UIApplication sharedApplication].keyWindow addSubview:self.view];
        [self creatMainUI];
        [self createPickerView];
        self.titleLabel.text = title;
        [parentController addChildViewController:self];
    }
    return self;
}

- (void)createPickerView
{
    self.dataPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, KSCREEN_WIDTH, 256)];
    self.dataPickerView.delegate = self;
    self.dataPickerView.dataSource = self;
    self.dataPickerView.backgroundColor = [UIColor whiteColor];
    [self.containView addSubview:self.dataPickerView];
    
    for (NSInteger i = 0; i < self.dataArray.count; i++) {
        [self.dataPickerView selectRow:0 inComponent:i animated:YES];
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.dataArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSMutableArray *dataArrayCount = self.dataArray[component];
    return dataArrayCount.count;
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return (KSCREEN_WIDTH-20)/self.dataArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED {
    return 40;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSMutableArray *dataArrayCount = self.dataArray[component];
    return dataArrayCount[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSMutableArray *dataArrayCount = self.dataArray[component];
    NSString *dateString = dataArrayCount[row];
    [self.dataDic setObject:dateString forKey:@(component).stringValue];
}

- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

//
- (void)tapBackButton
{
    [self tapReturnPickerView];
}

// 点击确定
- (void)tapSureButton
{
    self.firstBlock(self.dataDic);
    [self tapReturnPickerView];
}
@end




















