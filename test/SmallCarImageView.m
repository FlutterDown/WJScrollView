


//
//  CustomerView.m
//  test
//
//  Created by tuanche on 16/1/12.
//  Copyright © 2016年 tuancheWJ. All rights reserved.
//

#import "SmallCarImageView.h"
#import "UIImageView+WebCache.h"

@interface SmallCarImageView()

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
@implementation SmallCarImageView
-(void)clearData
{
    
}
//刷新指定页内容
-(void)updateData:(NSInteger)indexPage data:(id)dataObject
{
    [self.img sd_setImageWithURL:[NSURL URLWithString:dataObject]];
    self.label.text = [NSString stringWithFormat:@"%zd",indexPage];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
