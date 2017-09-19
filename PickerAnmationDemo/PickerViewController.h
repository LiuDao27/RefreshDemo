//
//  PickerViewController.h
//  PickerAnmationDemo
//
//  Created by lvshasha on 2017/9/7.
//  Copyright © 2017年 com.GlassStore. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sendFirstValue)(NSDictionary *dataDic);
@interface PickerViewController : UIViewController
@property (nonatomic, strong) UILabel *titleLabel; // 导航栏题目
@property (nonatomic, strong) UIButton *leftButton; // 左边按钮
@property (nonatomic, strong) UIButton *rightButton; // 右边按钮
@property (nonatomic, assign) BOOL closeAnmation;   // 关闭动画

//
- (void)creatMainUI;
- (void)KeyWindowAnimation;
- (void)tapReturnPickerView;//回收picker
@end

@interface OnePickerViewController : PickerViewController

@property (nonatomic, copy) sendFirstValue firstBlock;
//初始化方法(带有关闭动画参数)
- (id)initWithOneClassModel:(NSMutableArray *)oneSource title:(NSString *)title parentController:(UIViewController *)parentController getDataFromTapFirstCell:(sendFirstValue )firstBlock closeKeyWindowAnimation:(BOOL)close;
@end
