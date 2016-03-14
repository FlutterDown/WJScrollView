//
//  MyCustomerView.h
//  test
//
//  Created by tuanche on 16/1/12.
//  Copyright © 2016年 tuancheWJ. All rights reserved.
//

#import "WJItemView.h"
@interface BigCarImageView : WJItemView
- (BOOL)hasImage;

/*
 *  保存图片及回调
 */
-(void)save:(void(^)())ItemImageSaveCompleteBlock failBlock:(void(^)())failBlock;
@end


