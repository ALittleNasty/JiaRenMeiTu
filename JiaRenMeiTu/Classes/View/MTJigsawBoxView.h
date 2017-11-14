//
//  MTJigsawBoxView.h
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/14.
//  Copyright © 2017年 ALittleNasty. All rights reserved.

/**
 *  封装拼图的工具视图
 */
#import <UIKit/UIKit.h>

@interface MTJigsawBoxView : UIView

/**
 *  构造方法
 *
 *  @param frame : 位置大小
 *  @param images: 图片数组
 *  @param type :  拼接方式
 */
- (instancetype)initWithFrame:(CGRect)frame WithImages:(NSArray *)images jigsawType:(ImageJigsawType)type;

@end
