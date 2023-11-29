//
//  TagsLabelLayout.m
//  MyWaterflowLayout
//
//  Created by wdyzmx on 2020/1/14.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import "TagsLabelLayout.h"

/// 设置默认列间距
static const CGFloat kDefaultColumnMargin = 10;
/// 设置默认行间距
static const CGFloat kDefaultRowMargin = 10;
/// 设置默认item高度
static const CGFloat kDefaultItemHeight = 30;
/// 设置默认边缘间距
static const UIEdgeInsets kDefaultEdgeInsets = {10, 10, 10, 10};

@interface TagsLabelLayout ()

/// 存放所有cell的布局属性
@property (nonatomic, strong) NSMutableArray *attrsArray;
/// 内容高度
@property (nonatomic, assign) CGFloat contentHeight;
/// 行边距
@property (nonatomic, assign) CGFloat rowMargin;
/// 列边距
@property (nonatomic, assign) CGFloat columnMargin;
/// collectionView的edgeInsets
@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;
/// item的高度
@property (nonatomic, assign) CGFloat itemHeight;
/// item的宽度
@property (nonatomic, assign) CGFloat itemMaxX;
/// item的最大高度
@property (nonatomic, assign) CGFloat itemMaxY;

@end

@implementation TagsLabelLayout

#pragma mark - 重写prepareLayout
- (void)prepareLayout {
    [super prepareLayout];
    
    // 初始化
    self.itemMaxX = 10;
    self.itemMaxY = 10;
    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];
    //
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 获取indexPath对应的属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

#pragma mark - 重写layoutAttributesForElementsInRect
/// 返回attrs数据源
/// @param rect rect
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}

#pragma mark - 重写layoutAttributesForItemAtIndexPath
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    CGFloat itemWidth = [self.delegate tagsLabelLayout:self indexPath:indexPath];
    CGFloat restWidth = collectionViewWidth - self.contentEdgeInsets.left - self.contentEdgeInsets.right - self.columnMargin - self.itemMaxX - 10;
    
    if (restWidth >= itemWidth) {  // 不换行
        if (self.itemMaxX != 10) {
           self.itemMaxX += itemWidth + self.columnMargin;
        }
    } else {  // 换行
        self.itemMaxX = 10;
        if (self.itemMaxY != 10) {
            self.itemMaxY += self.itemHeight + self.rowMargin;
        }
    }
    
    CGFloat X = self.itemMaxX == 10 ? 10 : self.itemMaxX - itemWidth;
    CGFloat Y = self.itemMaxY == 10 ? 10 : self.itemMaxY - self.itemHeight;
    attrs.frame = CGRectMake(X, Y, itemWidth, self.itemHeight);
    // 给itemMaxX,itemMaxY,contentHeight赋值
    self.itemMaxX = CGRectGetMaxX(attrs.frame);
    self.itemMaxY = CGRectGetMaxY(attrs.frame);
    self.contentHeight = self.itemMaxY + self.contentEdgeInsets.bottom;
    return attrs;
}


#pragma mark - gettter
// 行间距
- (CGFloat)rowMargin {
    if ([self.delegate respondsToSelector:@selector(rowMarginInTagsLabelLayout:)]) {
        return [self.delegate rowMarginInTagsLabelLayout:self];
    } else {
        return kDefaultRowMargin;
    }
}

// 列间距
- (CGFloat)columnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginInTagsLabelLayout:)]) {
        return [self.delegate columnMarginInTagsLabelLayout:self];
    } else {
        return kDefaultColumnMargin;
    }
}

// 四周边距
- (UIEdgeInsets)contentEdgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInTagsLabelLayout:)]) {
        return [self.delegate edgeInsetsInTagsLabelLayout:self];
    } else {
        return kDefaultEdgeInsets;
    }
}

// 标签高度
- (CGFloat)itemHeight {
    if ([self.delegate respondsToSelector:@selector(itemHeightInTagsLabelLayout:)]) {
        return [self.delegate itemHeightInTagsLabelLayout:self];
    } else {
        return kDefaultItemHeight;
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

@end
