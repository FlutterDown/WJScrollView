//
//  WJItemView.m
//  test
//
//  Created by tuanche on 16/1/12.
//  Copyright © 2016年 tuancheWJ. All rights reserved.
//

#import "WJItemView.h"

@implementation WJItemView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled=YES;
        
    }
    return self;
}
-(void)clearData
{
    
}
//设置新页码
-(void)setPageIndex:(NSInteger)indexPage
{
    self.curIndex = indexPage;
    
}
//刷新指定页内容
-(void)updateData:(NSInteger)indexPage data:(id)dataObject
{
    // 子类实现
}
//获得当前对象的页码
-(NSInteger)getPageIndex
{
    return self.curIndex;
}

- (void)awakeFromNib
{
    self.userInteractionEnabled = YES;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //检查对象delegate是否实现了方法 action
    if ([self.target respondsToSelector:self.action]) {
        //调用对象delegate的方法action,参数为self
        //动态方法调用的方式
        //共有三个版本无参数，一个参数，两个参数
        [self.target performSelector:self.action withObject:self];
    }
    if (self.block) {
        self.block(self,self.curIndex);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
