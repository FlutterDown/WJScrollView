


//
//  MyCustomerView.m
//  test
//
//  Created by tuanche on 16/1/12.
//  Copyright © 2016年 tuancheWJ. All rights reserved.
//

#import "BigCarImageView.h"
#import "WJScrollView.h"
#import "UIImageView+WebCache.h"
@interface BigCarImageView()

@property (weak, nonatomic) IBOutlet UIImageView *im;

@end
@implementation BigCarImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (BOOL)hasImage
{
    if (self.im.image) {
        return YES;
    };
    return NO;
}

-(void)clearData
{
    
}
//刷新指定页内容
-(void)updateData:(NSInteger)indexPage data:(id)dataObject
{
    [self.im sd_setImageWithURL:[NSURL URLWithString:dataObject]];
}



/*
 *  保存图片及回调
 */
-(void)save:(void(^)())ItemImageSaveCompleteBlock failBlock:(void(^)())failBlock{
    
    if(self.im.image == nil){
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(failBlock != nil) failBlock();
        });
        return;
    }
    
//    [self.im.image savedPhotosAlbum:ItemImageSaveCompleteBlock failBlock:failBlock];
}

@end
