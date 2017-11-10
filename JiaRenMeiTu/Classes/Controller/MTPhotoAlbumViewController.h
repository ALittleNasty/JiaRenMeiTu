//
//  MTPhotoAlbumViewController.h
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/10.
//  Copyright © 2017年 ALittleNasty. All rights reserved.

/**
 *  相册图片选择
 */
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PhotoAlbumEntrance) {
    
    PhotoAlbumEntranceBeauty = 0,   // 美化图片
    PhotoAlbumEntranceJigsaw = 1    // 拼图
};

@interface MTPhotoAlbumViewController : UIViewController

/** 入口 */
@property (nonatomic, assign) PhotoAlbumEntrance entrance;

@end
