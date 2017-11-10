//
//  MTPhotoAlbumViewController.m
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/10.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

#import "MTPhotoAlbumViewController.h"

#import "MTPhotoCollectionCell.h"

#import <Masonry/Masonry.h>
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>

@interface MTPhotoAlbumViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;

/** 图片 */
@property (nonatomic, copy) NSArray *photos;

@end

@implementation MTPhotoAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initCollectionView];
    
    [self fetchSystemPhotoLibraryImage];
}

#pragma mark - UI Configure

- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 4.0;
    layout.minimumInteritemSpacing = 4.0;
    CGFloat itemWH = ([UIScreen mainScreen].bounds.size.width - 8.0)/3;
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerNib:[MTPhotoCollectionCell nib] forCellWithReuseIdentifier:PhotoCollectionCellID];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MTPhotoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCollectionCellID forIndexPath:indexPath];
    
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s", __func__);
}

#pragma mark - Helper

- (void)fetchSystemPhotoLibraryImage
{
    PHFetchOptions *options = [PHFetchOptions new];
//    PHFetchResult *topLevelUserCollections = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:options];
    PHAssetCollectionSubtype subType = PHAssetCollectionSubtypeAlbumRegular;
    PHFetchResult *smartAlbumsResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                                                                subtype:subType
                                                                                options:options];
    
//    NSMutableArray *photoGroups = [NSMutableArray array];
//    [topLevelUserCollections enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj isKindOfClass:[PHAssetCollection class]]) {
//            PHAssetCollection *asset = (PHAssetCollection *)obj;
//            PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:asset options:[PHFetchOptions new]];
//            if (result.count > 0) {
//
//            }
//        }
//    }];
    
    [smartAlbumsResult enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[PHAssetCollection class]]) {
            PHAssetCollection *asset = (PHAssetCollection *)obj;
            PHFetchOptions *options = [[PHFetchOptions alloc] init];
            options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
            
            PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:asset options:options];
            if(result.count > 0 && asset.assetCollectionSubtype != PHAssetCollectionSubtypeSmartAlbumVideos) {
                
            }
        }
    }];
}

@end
