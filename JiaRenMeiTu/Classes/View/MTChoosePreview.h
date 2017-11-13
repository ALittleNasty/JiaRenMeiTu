//
//  MTChoosePreview.h
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/13.
//  Copyright © 2017年 ALittleNasty. All rights reserved.

/**
 *  选择图片的预览视图
 */
#import <UIKit/UIKit.h>

@protocol MTChoosePreviewDelegate <NSObject>

@required

- (void)startJigsawButtonClickWithImages:(NSArray <UIImage *>*)images;

@end

@interface MTChoosePreview : UIView

/** 图片数组 */
@property (nonatomic, copy) NSArray *images;

/** 代理 */
@property (nonatomic, assign) id <MTChoosePreviewDelegate> delegate;

@end
