//
//  MTHomeCollectionCell.h
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/10.
//  Copyright © 2017年 ALittleNasty. All rights reserved.

/**
 *  首页的功能模块cell
 */
#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *HomeCollectionCellID;


@interface MTHomeCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *descLabel;


+ (UINib *)nib;

@end
