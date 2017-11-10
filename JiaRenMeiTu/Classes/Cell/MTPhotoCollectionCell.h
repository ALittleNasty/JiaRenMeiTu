//
//  MTPhotoCollectionCell.h
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/10.
//  Copyright © 2017年 ALittleNasty. All rights reserved.

/**
 *  图片选择cell
 */
#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *PhotoCollectionCellID;

@interface MTPhotoCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *chooseIconImageView;

+ (UINib *)nib;

@end
