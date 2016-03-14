//
//  WJScrollView.m
//  test
//
//  Created by tuanche on 16/1/12.
//  Copyright © 2016年 tuancheWJ. All rights reserved.
//

#import "WJScrollView.h"
#import "WJItemView.h"
@interface WJScrollView()<UIScrollViewDelegate>

@property (nonatomic, assign) CGSize pageSize;
//回收集合
@property (nonatomic, strong) NSMutableSet *recycledPages;
//可见集合
@property (nonatomic, strong) NSMutableSet *visiblePages;
//总页码
@property (nonatomic, assign) NSInteger pageCount;
//当前页码
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) BOOL userScroll;


@end
@implementation WJScrollView
-(id)initWithFrame:(CGRect)frame count:(NSInteger)count
{
    self = [super initWithFrame:frame];
    if (self) {
        //UIScrollViewDelegate设置成自身
        self.delegate = self;
        _pageCount = count;
        
        //实例化两个集合
        _recycledPages = [[NSMutableSet alloc] init];
        _visiblePages  = [[NSMutableSet alloc] init];
        
        _userScroll=YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        //注册旋转消息
//        [self registerRotation:@selector(updateLayout)];
    }
    return self;
}
- (void)dealloc
{
    //删除旋转消息
    [self removeRotation];
}
//注册旋转通知
-(void)registerRotation:(SEL)method
{
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:method
                                                 name:UIDeviceOrientationDidChangeNotification object:nil];
}
-(void)removeRotation
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}
//删除所有子视图 (这里是UIImageView)
-(void)removeAllSubviews:(UIView*)view
{
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[UIImageView class]]) {
            [subview removeFromSuperview];
        }
    }
    
}
//屏幕旋转后重新布局
//-(void)updateLayout
//{
//    //如果转屏，根据实际情况是否重新计算总页码
//    [self removeAllPage];
//    
//    //获得设备方向
//    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
//    
//    //获得屏幕大小
//    CGRect screenBounds;//=[UIScreen mainScreen].bounds;
//    //NSLog(@"bounds:%@",NSStringFromCGRect(screenBounds));
//    if (UIDeviceOrientationIsLandscape(deviceOrientation)) {
//        screenBounds = CGRectMake(0, 0, 1024, 768);
//    }
//    else{
//        screenBounds = CGRectMake(0, 0, 768, 1024);
//    }
//    //重新设置位置和大小
//    self.frame = screenBounds;
//    //设置内容区的大小
//    self.contentSize = CGSizeMake(_pageCount * screenBounds.size.width, screenBounds.size.height);
//    //切换到转屏前的页码
//    [self changePage:_curPage animated:NO];
//    //加载当前可见页
//    [self tilePages];
//}
//删除所有子页信息
-(void)removeAllPage
{
    [_recycledPages removeAllObjects];
    [_visiblePages removeAllObjects];
    [self removeAllSubviews:self];
}
//从每一页对象获得它的视图,目前支持两种页对象(UIViewController的实例或UIView的实例)
-(WJItemView *)viewFromPage:(WJItemView *)pageInstance
{
//    if ([pageInstance isKindOfClass:[UIView class]]) {
//        return (UIView<WJScrollViewDelegate>*)pageInstance;
//    }
//    else if([pageInstance isKindOfClass:[UIViewController class]]){
//        UIViewController *controller=(UIViewController*)pageInstance;
//        return (UIView<WJScrollViewDelegate>*)(controller.view);
//    }
//    NSLog(@"暂没有支持类型");
//    return (UIView<WJScrollViewDelegate>*)pageInstance;
    return pageInstance;
}
//加载屏幕可见页(包含预加载页,用户体验考虑)
- (void)reloadData
{
    //获得总页码
    _pageCount = [self.dataSource numberOfPagesInWJScrollView:self];
    //从委拖对象获得每一页大小
    self.pageSize = [self.dataSource perPageSizeInWJScrollView:self];
    
    self.contentSize = CGSizeMake(_pageCount * self.pageSize.width, self.pageSize.height);
    //计算可见页码
    CGRect visibleBounds = self.bounds;
    //self.contentOffset
    //NSLog(@"cur:%@",NSStringFromCGRect(visibleBounds));
    //跟据左下角x和右上角x计算当前可见页码
    int firstNeededPageIndex = floorf(CGRectGetMinX(visibleBounds) / self.pageSize.width);
    int lastNeededPageIndex  = floorf((CGRectGetMaxX(visibleBounds) - 1) / self.pageSize.width);
    //保存当前页码
    _curPage = firstNeededPageIndex;
    //预加载当前页的前后页
    firstNeededPageIndex = MAX(firstNeededPageIndex - 1, 0);
    lastNeededPageIndex  = (int)MIN(lastNeededPageIndex + 1, _pageCount - 1);
//    NSLog(@"%d,%d",firstNeededPageIndex,lastNeededPageIndex);
    // 收藏不再可见页,以备复用
    for (WJItemView * page in _visiblePages) {
        //如果当前页不再是可见页,将它回收
        if ([page getPageIndex] < firstNeededPageIndex || [page getPageIndex] > lastNeededPageIndex) {
            //清除旧数据,回收复用
            if ([page respondsToSelector:@selector(clearData)]) {
                [page clearData];
            }
            [_recycledPages addObject:page];
            //从屏幕上将它移除
            WJItemView *view=[self viewFromPage:page];
            [view removeFromSuperview];
            
        }
    }
    //从可见集合中去掉回收集合包含的内容
    [_visiblePages minusSet:_recycledPages];
    // 添加新可见页
    for (int index = firstNeededPageIndex; index <= lastNeededPageIndex; index++) {
        //不是可见页再处理，否则不处理
        if (![self isDisplayingPageForIndex:index]) {
            //是否存在可复用的实例
            WJItemView *page = [self dequeueRecycledPage];
            //不存在就创建
            if (page == nil) {
                //从委拖对象获得某页对象
                page = [self.dataSource wjScrollView:self pageForIndex:index];
            }
            
            //设置新的页码
            [page setPageIndex:index];
            NSLog(@"%zd,%@",index,page);
            //设置新的位置
            CGRect frame = CGRectMake(self.pageSize.width * index, 0, self.pageSize.width,self.pageSize.height);
            WJItemView *view=[self viewFromPage:page];
            view.frame  = frame;
            //将当前页的视图添加到滚动视图上(自己上)
            [self addSubview:view];
            //更新内容
            [self configurePage:page forIndex:index];
            //加入可见集合
            [_visiblePages addObject:page];
            
        }
    }
}
//指定的页码是否是可见页
- (BOOL)isDisplayingPageForIndex:(NSUInteger)index
{
    BOOL foundPage = NO;
    for (WJItemView * page in _visiblePages) {
        if ([page getPageIndex] == index) {
            foundPage = YES;
            break;
        }
    }
    return foundPage;
}
//是否有可复用的页实例
- (WJItemView *)dequeueRecycledPage
{
    //获得回收集中的任意对象
    WJItemView * page = [_recycledPages anyObject];
    if (page) {
        //从回收集合移除
        [_recycledPages removeObject:page];
    }
    //返回复用对象
    return page;
}
//更新某页内容(复用的对象或者新创建的对象)
- (void)configurePage:(WJItemView *)page forIndex:(NSUInteger)index
{
    //从委拖对象获得数据
    id dataObject=[self.dataSource wjScrollView:self dataObjectForIndex:index];
    //更新这一页的数据
    [page updateData:index data:dataObject];
}
//跳转到指定页
-(void)scrollToPage:(NSInteger)pageIndex animated:(BOOL)animated{
    //页码非法
    if (pageIndex<0||pageIndex >= _pageCount) {
        return;
    }
    //获得每一页的大小
    self.pageSize=[self.dataSource perPageSizeInWJScrollView:self];
    //计算要跳转到的位置
    CGRect frame = CGRectMake(self.pageSize.width * pageIndex, 0, self.pageSize.width,self.pageSize.height);
    //设置用户滚动为NO
    _userScroll=NO;
    //滚动到指定位置
    [self scrollRectToVisible:frame animated:animated];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //设置用户滚动为YES
    _userScroll=YES;
}

//滚动视图发生滚动的协议方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self reloadData];
    //如果是用户滚动,通知委拖对象处理滚动事件
    if ([self.dataSource respondsToSelector:@selector(wjScrollView:pageChange:animated:)]) {
        _curPage = _curPage < 0 ? 0 : _curPage;
        [self.dataSource wjScrollView:self pageChange:_curPage animated:YES];
    }
    
}

- (NSInteger)currentIndex
{
    return _curPage;
}

- (WJItemView *)currentView
{
    NSLog(@"%zd",_curPage);
    for (WJItemView *view in _visiblePages) {
        if (view.curIndex == _curPage) {
            return view;
        }
    }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
