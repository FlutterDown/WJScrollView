//
//  BaseViewController.h
//  IBallBBS
//
//  Created by cstwanngjun on 14/12/29.
//  Copyright (c) 2014年 cst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
- (void)setRightBarItemWithImageStr:(NSString *)imageStr hilight:(NSString *)hilImge orTitle:(NSString *)title;
- (void)setTitleView:(NSString *)title;
- (void)setLeftBarItem:(UIView *)view isHidden:(BOOL)isHidden;

- (void)setRightBarItems:(UIView *)view;

- (void)setTitleText:(NSString *)title Color:(UIColor *)color;

// 右导航按钮点击
- (void)rightBtnClick;

- (void)back;

// 注意使用
- (void)firstPushViewController:(UIViewController *)Vc;
- (void)groupPushViewController:(UIViewController *)Vc;
- (void)CollegePushViewController:(UIViewController *)Vc;
@end
