//
//  WaterFlowLayout.m
//  MyWaterflowLayout
//
//  Created by wdyzmx on 2020/1/12.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import "WaterFlowLayout.h"

/// 设置默认列数
static const NSInteger kDefaultColumnCount = 3;
/// 设置默认列间距
static const CGFloat kDefaultColumnMargin = 10;
/// 设置默认行间距
static const CGFloat kDefaultRowMargin = 10;
/// 设置默认边缘间距
static const UIEdgeInsets kDefaultEdgeInsets = {10, 10, 10, 10};

@interface WaterFlowLayout ()

/// 存放所有cell的布局属性
@property (nonatomic, strong) NSMutableArray *attrsArray;
/// 存放当前列的高度（三列，三个元素）
@property (nonatomic, strong) NSMutableArray *columnsHeightArray;
/// 内容高度
@property (nonatomic, assign) CGFloat contentHeight;
/// 行边距
@property (nonatomic, assign) CGFloat rowMargin;
/// 列边距
@property (nonatomic, assign) CGFloat columnMargin;
/// 列数
@property (nonatomic, assign) CGFloat columnCount;
/// collectionView的edgeInsets
@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;

@end

@implementation WaterFlowLayout

#pragma mark - 重写prepareLayout
- (void)prepareLayout {
    [super prepareLayout];
    
    // 清除以前计算的高度
    [self.columnsHeightArray removeAllObjects];
    for (int i = 0; i < kDefaultColumnCount; i++) {
        // 添加默认高度
        [self.columnsHeightArray addObject:@(kDefaultEdgeInsets.top)];
    }
    
    // 清除之前的布局
    [self.attrsArray removeAllObjects];
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < items; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 获取布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

#pragma mark - 重写layoutAttributesForElementsInRect
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
    CGFloat itemWidth = (collectionViewWidth - self.contentEdgeInsets.left - self.contentEdgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    // item的高度
    CGFloat itemHeight = [self.delegate waterFlowLayout:self itemWidth:itemWidth indexPath:indexPath];
    // 设置初始值
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnsHeightArray[0] doubleValue];
    
    // 遍历找到高度最短的那一列
    for (int i = 0; i < self.columnCount; i++) {
        CGFloat columnHeight = [self.columnsHeightArray[i] doubleValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    // X,Y值
    CGFloat X = self.contentEdgeInsets.left + destColumn * (itemWidth + self.columnMargin);
    CGFloat Y = minColumnHeight;
    if (Y != self.contentEdgeInsets.top) {
        Y += self.rowMargin;
    }
    // 赋值frame
    attrs.frame = CGRectMake(X, Y, itemWidth, itemHeight);
    
    // 更新最短的那列高度(每次调用会重新计算)
    self.columnsHeightArray[destColumn] = @(CGRectGetMaxY(attrs.frame));
    if (self.contentHeight < [self.columnsHeightArray[destColumn] doubleValue]) {
        self.contentHeight = [self.columnsHeightArray[destColumn] doubleValue];
    }
    
    return attrs;
}

#pragma mark - 重写collectionViewContentSize
- (CGSize)collectionViewContentSize {
    return CGSizeMake(0, self.contentHeight + self.contentEdgeInsets.bottom);
}

#pragma mark - getter
- (CGFloat)rowMargin {
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterFlowLayout:)]) {
        return [self.delegate rowMarginInWaterFlowLayout:self];
    } else {
        return kDefaultRowMargin;
    }
}

- (CGFloat)columnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterFlowLayout:)]) {
        return [self.delegate columnMarginInWaterFlowLayout:self];
    } else {
        return kDefaultColumnMargin;
    }
}

- (CGFloat)columnCount {
    if ([self.delegate respondsToSelector:@selector(countOfColumnInWaterFlowLayout:)]) {
        return [self.delegate countOfColumnInWaterFlowLayout:self];
    } else {
        return kDefaultColumnCount;
    }
}

- (UIEdgeInsets)contentEdgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterFlowLayout:)]) {
        return [self.delegate edgeInsetsInWaterFlowLayout:self];
    } else {
        return kDefaultEdgeInsets;
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (NSMutableArray *)columnsHeightArray {
    if (!_columnsHeightArray) {
        _columnsHeightArray = [NSMutableArray array];
    }
    return _columnsHeightArray;
}

@end
