//
//  MTPhotoModel.h
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/13.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "MTEnums.h"

@interface MTPhotoModel : NSObject

/** assert */
@property (nonatomic, strong) PHAsset  *assert;

/** image */
@property (nonatomic, strong) UIImage  *image;

/** 选中标记 */
@property (nonatomic, assign) BOOL isChoosen;

/** 入口 */
@property (nonatomic, assign) PhotoAlbumEntrance entrance;

@end
