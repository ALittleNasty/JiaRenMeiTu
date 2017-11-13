//
//  MTEnums.h
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/13.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

#ifndef MTEnums_h
#define MTEnums_h

/**
 *  进入图片选择页面的入口
 */
typedef NS_ENUM(NSUInteger, PhotoAlbumEntrance) {
    
    PhotoAlbumEntranceBeauty = 0,   // 美化图片
    PhotoAlbumEntranceJigsaw = 1    // 拼图
};

/**
 *  拼图的类型
 */
typedef NS_ENUM(NSUInteger, ImageJigsawType) {
    
    ImageJigsawTypeTwo = 0,      // 两张图片拼接
    ImageJigsawTypeThree = 1,    // 三张图片拼接
    ImageJigsawTypeFour = 2      // 四张图片拼接
};

#endif /* MTEnums_h */
