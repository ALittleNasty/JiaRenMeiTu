//
//  MTPhotoAlbumViewController.m
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/10.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

#import "MTPhotoAlbumViewController.h"
#import "MTJigsawViewController.h" // 拼图
#import "MTPhotoBeautyController.h" // 美图

#import "MTPhotoCollectionCell.h"

#import "MTPhotoModel.h"

#import <Masonry/Masonry.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>

@interface MTPhotoAlbumViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;

/** 图片 */
@property (nonatomic, strong) NSMutableArray *photos;

/** 选中的图片 */
@property (nonatomic, strong) NSMutableArray *choosenPhotos;

@end

@implementation MTPhotoAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self basicSetup];
    
    [self initCollectionView];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getAllUIImageObjectWithAsserts:[self getAllphotosUsingPohotKit]];
    });
}

- (void)basicSetup
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"图库";
    self.photos = [NSMutableArray array];
    if (self.entrance == PhotoAlbumEntranceJigsaw) {
        self.choosenPhotos = [NSMutableArray array];
    }
}

#pragma mark - UI Configure

/** 添加 CollectionView */
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
    
    cell.model = self.photos[indexPath.item];
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.entrance == PhotoAlbumEntranceJigsaw) { // 选择多张图片拼图
        
        MTJigsawViewController *jigsawVC = [[MTJigsawViewController alloc] init];
        [self.navigationController pushViewController:jigsawVC animated:YES];
    } else {    // 选择一张图片美图
        
        MTPhotoModel *photo = self.photos[indexPath.item];
        MTPhotoBeautyController *beautyVC = [[MTPhotoBeautyController alloc] init];
        beautyVC.originalImage = photo.image;
        [self.navigationController pushViewController:beautyVC animated:YES];
    }
}

#pragma mark - Helper

/** iOS 8.0 以上获取所有照片用Photos.h这个库 */
-(NSMutableArray*)getAllphotosUsingPohotKit
{
    NSMutableArray *array = [NSMutableArray array];
    // 所有智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (NSInteger i = 0; i < smartAlbums.count; i++) {
        // 是否按创建时间排序
        PHFetchOptions *option = [[PHFetchOptions alloc] init];
        option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
        PHCollection *collection = smartAlbums[i];
        //遍历获取相册
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
//            NSLog(@"%@", collection.localizedTitle);
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
            if (fetchResult.count > 0) {
                // 某个相册里面的所有PHAsset对象
                NSArray *assets = [self getAllPhotosAssetInAblumCollection:assetCollection ascending:YES];
                [array addObjectsFromArray:assets];
            }
        }
    }
    //返回相机胶卷内的所有照片
    return array;
}

/** 获取相册里的所有图片的PHAsset对象 */
- (NSArray *)getAllPhotosAssetInAblumCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending
{
    // 存放所有图片对象
    NSMutableArray *assets = [NSMutableArray array];
    
    // 是否按创建时间排序
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    
    // 获取所有图片对象
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
    // 遍历
    [result enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
        [assets addObject:asset];
    }];
    return assets;
}

/** 获取所有的UIImage对象 */
- (void)getAllUIImageObjectWithAsserts:(NSMutableArray <PHAsset *>*)asserts
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    
    
    
    for (PHAsset * assert in asserts) {
        
        __block MTPhotoModel *photo = [[MTPhotoModel alloc] init];
        photo.entrance = self.entrance;
        photo.isChoosen = NO;
        photo.assert = assert;
        
        [[PHImageManager defaultManager] requestImageForAsset:assert targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            photo.image = result;
            [self.photos addObject:photo];
        }];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [SVProgressHUD dismiss];
        [self.collectionView reloadData];
    });
}

@end
