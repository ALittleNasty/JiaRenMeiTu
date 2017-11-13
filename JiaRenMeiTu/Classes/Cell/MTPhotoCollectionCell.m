//
//  MTPhotoCollectionCell.m
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/10.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

#import "MTPhotoCollectionCell.h"
#import "MTPhotoModel.h"

NSString *PhotoCollectionCellID = @"PhotoCollectionCellIdentifier";

@implementation MTPhotoCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(MTPhotoModel *)model
{
    _model = model;
    
    self.photoImageView.image = _model.image;
    
    if (_model.entrance == PhotoAlbumEntranceJigsaw) {
        
        self.chooseIconImageView.hidden = !_model.isChoosen;
    } else {
        
        self.chooseIconImageView.hidden = YES;
    }
    
}

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"MTPhotoCollectionCell" bundle:nil];
}

@end
