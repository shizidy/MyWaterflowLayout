//
//  WaterFlowLayout.h
//  MyWaterflowLayout
//
//  Created by wdyzmx on 2020/1/12.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WaterFlowLayoutDelegate <NSObject>

@required
/// 设置item高度
/// @param layout UICollectionViewLayout实例
/// @param itemWidth item宽度
/// @param indexPath indexPath
- (CGFloat)waterFlowLayout:(UICollectionViewLayout *)layout itemWidth:(CGFloat)itemWidth indexPath:(NSIndexPath *)indexPath;
@optional
/// 设置行边距
/// @param layout UICollectionViewLayout实例
- (CGFloat)rowMarginInWaterFlowLayout:(UICollectionViewLayout *)layout;
/// 设置列边距
/// @param layout UICollectionViewLayout实例
- (CGFloat)columnMarginInWaterFlowLayout:(UICollectionViewLayout *)layout;
/// 设置列数
/// @param layout UICollectionViewLayout实例
- (CGFloat)countOfColumnInWaterFlowLayout:(UICollectionViewLayout *)layout;
/// 设置collectionView内边距
/// @param layout UICollectionViewLayout实例
- (UIEdgeInsets)edgeInsetsInWaterFlowLayout:(UICollectionViewLayout *)layout;

@end

@interface WaterFlowLayout : UICollectionViewLayout

@property (nonatomic, weak) id <WaterFlowLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
