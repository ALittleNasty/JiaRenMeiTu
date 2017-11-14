//
//  MTJigsawBottomView.h
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/13.
//  Copyright © 2017年 ALittleNasty. All rights reserved.

/**
 *  拼图界面底部工具视图
 */
#import <UIKit/UIKit.h>

@protocol JigsawBottomViewDelegate <NSObject>

@required
/**
 * 拼图的样式改变的回调
 *
 * @param type : 拼图样式<默认均为纵向拼接>
 */
- (void)jigsawTypeChanged:(ImageJigsawType)type;

@optional
/**
 * 拼图的边框的改变的回调
 *
 * @param hasBorder : 是否有边框<默认没有>
 */
- (void)changeJigsawBorderStyle:(BOOL)hasBorder;

@end

@interface MTJigsawBottomView : UIView

/** 代理 */
@property (nonatomic, assign) id <JigsawBottomViewDelegate> delegate;

/**
 * 构造函数
 *
 * @param frame : 位置大小
 * @param count : 要拼接的图片的个数
 */
- (instancetype)initWithFrame:(CGRect)frame withCount:(NSInteger)count;

@end
