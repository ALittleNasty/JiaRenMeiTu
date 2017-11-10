//
//  MTPhotoCollectionCell.m
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/10.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

#import "MTPhotoCollectionCell.h"

NSString *PhotoCollectionCellID = @"PhotoCollectionCellIdentifier";

@implementation MTPhotoCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"MTPhotoCollectionCell" bundle:nil];
}

@end
