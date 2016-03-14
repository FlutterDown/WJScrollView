//
//  WJItemView.h
//  test
//
//  Created by tuanche on 16/1/12.
//  Copyright © 2016年 tuancheWJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJScrollView.h"
@class WJItemView;
typedef void (^itemSelectedBlock)(WJItemView *item, NSInteger index);
@interface WJItemView : UIView
//响应点击的对象
@property (nonatomic,assign) id target;
//响应点击的对象的某个方法
@property (nonatomic,assign) SEL action;
@property (nonatomic, assign) NSInteger curIndex;
@property (nonatomic, copy) itemSelectedBlock block;

//清除旧数据
-(void)clearData;
//刷新指定页内容
-(void)updateData:(NSInteger)indexPage data:(id)dataObject;
//设置新页码
-(void)setPageIndex:(NSInteger)indexPage;
//获得当前对象的页码
-(NSInteger)getPageIndex;
@end
