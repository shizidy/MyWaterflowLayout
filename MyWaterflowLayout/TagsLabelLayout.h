//
//  TagsLabelLayout.h
//  MyWaterflowLayout
//
//  Created by wdyzmx on 2020/1/14.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TagsLabelLayoutDelegate <NSObject>

@required
/// 设置标签的宽度
/// @param layout UICollectionViewLayout实例
/// @param indexPath indexPath
- (CGFloat)tagsLabelLayout:(UICollectionViewLayout *)layout indexPath:(NSIndexPath *)indexPath;

@optional
/// 设置行边距
/// @param layout UICollectionViewLayout实例
- (CGFloat)rowMarginInTagsLabelLayout:(UICollectionViewLayout *)layout;
/// 设置列边距
/// @param layout UICollectionViewLayout实例
- (CGFloat)columnMarginInTagsLabelLayout:(UICollectionViewLayout *)layout;
/// 设置collectionView内边距
/// @param layout UICollectionViewLayout实例
- (UIEdgeInsets)edgeInsetsInTagsLabelLayout:(UICollectionViewLayout *)layout;
/// 设置itemHeight
- (CGFloat)itemHeightInTagsLabelLayout:(UICollectionViewLayout *)layout;

@end

@interface TagsLabelLayout : UICollectionViewLayout

@property (nonatomic, weak) id <TagsLabelLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
