//
//  WJScrollView.h
//  test
//
//  Created by tuanche on 16/1/12.
//  Copyright © 2016年 tuancheWJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kMainBoundsHeight   ([UIScreen mainScreen].bounds).size.height //屏幕的高度
#define kMainBoundsWidth    ([UIScreen mainScreen].bounds).size.width //屏幕的宽度
//子页对象必须遵守的协议
@class WJScrollView;
@class WJItemView;

//滚动视图所在对象必须遵守的协议
@protocol  WJScrolViewDataSource<NSObject>
@required
//返回总页码
-(NSInteger)numberOfPagesInWJScrollView:(WJScrollView *)scrollView;
//获得指定页的位置和大小
-(CGSize)perPageSizeInWJScrollView:(WJScrollView *)scrollView;
//获得指定页实例
-(WJItemView *)wjScrollView:(WJScrollView *)scrollView pageForIndex:(NSInteger)index;
//返回要显示的数据对象
-(id)wjScrollView:(WJScrollView *)scrollView dataObjectForIndex:(NSInteger)index;

@optional
//页面跳转
-(void)wjScrollView:(WJScrollView *)scrollView pageChange:(NSInteger)pageNumber animated:(BOOL)animated;
-(id)wjScrollView:(WJScrollView *)scrollView didSelectedIndex:(NSInteger)index;
@end
@interface WJScrollView : UIScrollView
@property (nonatomic,weak) id<WJScrolViewDataSource> dataSource;

-(id)initWithFrame:(CGRect)frame count:(NSInteger)count;
//移除所有子页
-(void)removeAllPage;
//载入可见页内容
- (void)reloadData;
//切换到指定页码
-(void)scrollToPage:(NSInteger)page animated:(BOOL)animated;

- (NSInteger)currentIndex;
-(WJItemView *)currentView;
@end
