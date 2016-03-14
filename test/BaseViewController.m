//
//  BaseViewController.m
//  IBallBBS
//
//  Created by cstwanngjun on 14/12/29.
//  Copyright (c) 2014年 cst. All rights reserved.
//
#define IOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES:NO)

#import "BaseViewController.h"
#import "AppDelegate.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IOS7) {
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;

    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    }
//    self.view.backgroundColor = BackColor;
    //    设置返回
    [self setBackItem];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBackItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(5, 0, 40, 50);
//    [btn setTitle:@" 返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [btn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self setLeftBarItem:btn isHidden:NO];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setLeftBarItem:(UIView *)view isHidden:(BOOL)isHidden
{
    if (isHidden == NO) {
        UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spacer.width = -16;
        if (!IOS7) {
            spacer.width = -6;
        }
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:view];
        self.navigationItem.leftBarButtonItems = @[spacer,leftItem];
    }else
    {
        UIView *myVi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 64)];
        myVi.backgroundColor = [UIColor clearColor];
        UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spacer.width = -16;
        if (!IOS7) {
            spacer.width = -6;
        }
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:myVi];
        self.navigationItem.leftBarButtonItems = @[spacer,leftItem];
    }
}

- (void)setRightBarItems:(UIView *)view
{
    //    解决系统默认占位
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    ios7设置-16，ios6设置-6
    spacer.width = -16;
    if (!IOS7) {
        spacer.width = -6;
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItems = @[spacer,rightItem];
}

- (void)setTitleView:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = title;
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    //    根据label的text自动设置label的frame的size
    [label sizeToFit];

    self.navigationItem.titleView = label;
}

- (void)setTitleText:(NSString *)title Color:(UIColor *)color
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = title;
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];

    //    根据label的text自动设置label的frame的size
    [label sizeToFit];
    
    self.navigationItem.titleView = label;
}


- (void)setRightBarItemWithImageStr:(NSString *)imageStr hilight:(NSString *)hilImge orTitle:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (imageStr != nil) {
        [btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    }
    if (hilImge != nil) {
       [btn setImage:[UIImage imageNamed:hilImge] forState:UIControlStateHighlighted];
    }
    if (title != nil) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchDown
     ];
    btn.frame = CGRectMake(0, 0, 50, 42);
    [self setRightBarItems:btn];
}

- (void)rightBtnClick
{
    
}


@end
