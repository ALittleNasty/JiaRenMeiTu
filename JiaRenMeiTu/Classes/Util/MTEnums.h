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
    
    ImageJigsawTypeTwoVertical = 0,         // 两张图片竖直拼接(两张默认)
    ImageJigsawTypeTwoHorizontal = 1,       // 两张图片水平拼接
    ImageJigsawTypeThreeVertical = 2,       // 三张图片竖直拼接(三张默认)
    ImageJigsawTypeThreeHorizontal = 3,     // 三张图片水平拼接
    ImageJigsawTypeThreeTopBig = 4,         // 三张图片上方大图拼接
    ImageJigsawTypeThreeBottomBig = 5,      // 三张图片底部大图拼接
    ImageJigsawTypeThreeLeftBig = 6,        // 三张图片左边大图拼接
    ImageJigsawTypeThreeRightBig = 7,       // 三张图片右边大图拼接
    ImageJigsawTypeFourVertical = 8,        // 四张图片竖直拼接(四张默认)
    ImageJigsawTypeFourHorizontal = 9,      // 四张图片水平拼接
    ImageJigsawTypeFourSquare = 10          // 四张图片"田"字拼接
};

#endif /* MTEnums_h */
