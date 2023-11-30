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
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attrsArray;
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
/// item的宽度MaxX
@property (nonatomic, assign) CGFloat itemMaxX;
/// item的最大高度MaxY
@property (nonatomic, assign) CGFloat itemMaxY;

@end

@implementation TagsLabelLayout

#pragma mark - 重写prepareLayout
- (void)prepareLayout {
    [super prepareLayout];
    
    // 初始化
    self.itemMaxX = self.contentEdgeInsets.left;
    self.itemMaxY = self.contentEdgeInsets.top;
    
    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];
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
    // 获取collectionView的宽度
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    // item的宽度
    CGFloat itemWidth = [self.delegate tagsLabelLayout:self indexPath:indexPath];
    // 当前行剩余宽度
    CGFloat restWidth = collectionViewWidth - self.itemMaxX - self.columnMargin - self.contentEdgeInsets.right;
    
    if (restWidth >= itemWidth) {  // 不换行
        if (self.itemMaxX != self.contentEdgeInsets.left) {
           self.itemMaxX += itemWidth + self.columnMargin;
        }
    } else {  // 换行
        // 重置itemMaxX
        self.itemMaxX = self.contentEdgeInsets.left;
        if (self.itemMaxY != self.contentEdgeInsets.top) {
            self.itemMaxY += self.itemHeight + self.rowMargin;
        }
        
        // 判断是否要末尾对齐
        if (self.needAlignTheTail) {
            // 重置上一个item的frame进行末尾对齐
            UICollectionViewLayoutAttributes *lastAttrs = self.attrsArray.lastObject;
            CGRect rect = lastAttrs.frame;
            rect.size.width += restWidth + self.columnMargin;
            lastAttrs.frame = rect;
            [self.attrsArray replaceObjectAtIndex:lastAttrs.indexPath.item withObject:lastAttrs];
        }
    }
    
    CGFloat X = self.itemMaxX == self.contentEdgeInsets.left ? self.contentEdgeInsets.left : self.itemMaxX - itemWidth;
    CGFloat Y = self.itemMaxY == self.contentEdgeInsets.top ? self.contentEdgeInsets.top : self.itemMaxY - self.itemHeight;
    attrs.frame = CGRectMake(X, Y, itemWidth, self.itemHeight);
    
    // 判断是否要对最后一个item末尾对齐
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    if (self.needAlignTheTail && indexPath.item == count - 1) {
        CGRect rect = attrs.frame;
        rect.size.width += collectionViewWidth - self.itemMaxX - self.contentEdgeInsets.right;
        attrs.frame = rect;
    }
    
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
