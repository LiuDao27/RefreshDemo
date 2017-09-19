//
//  ViewController.m
//  PickerAnmationDemo
//
//  Created by lvshasha on 2017/9/7.
//  Copyright © 2017年 com.GlassStore. All rights reserved.
//

#import "ViewController.h"
#import "PickerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(100, 50, 100, 100);
    titleButton.backgroundColor = [UIColor blueColor];
    [titleButton addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:titleButton];
    
    
}

- (void)button
{
    NSMutableArray *commentArray = [NSMutableArray array];
    NSMutableArray *dataArray = [NSMutableArray arrayWithObjects:@"200", @"201", nil];
    NSMutableArray *dataOneArray = [NSMutableArray arrayWithObjects:@"200", @"201", nil];
    NSMutableArray *dataSecArray = [NSMutableArray arrayWithObjects:@"200", @"201", nil];

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    [commentArray addObject:dataArray];
    [commentArray addObject:dataOneArray];
    [commentArray addObject:dataSecArray];
    OnePickerViewController *onePicker = [[OnePickerViewController alloc] init];
    onePicker = [[OnePickerViewController alloc] initWithOneClassModel:commentArray
                                                                 title:@"测试"
                                                      parentController:self
                                               getDataFromTapFirstCell:^(NSDictionary *dataDic) {
                                                   NSLog(@"dataDic %@", dataDic);
                                               } closeKeyWindowAnimation:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
