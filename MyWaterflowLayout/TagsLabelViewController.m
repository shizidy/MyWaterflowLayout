//
//  TagsLabelViewController.m
//  MyWaterflowLayout
//
//  Created by wdyzmx on 2020/1/12.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import "TagsLabelViewController.h"
#import "TagsLabelLayout.h"

@interface TagsLabelViewController () <TagsLabelLayoutDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation TagsLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)setUI {
    // 实例化layout
    TagsLabelLayout *layout = [[TagsLabelLayout alloc] init];
    layout.delegate = self;
    // 是否要末尾对齐
    layout.needAlignTheTail = YES;
    
    // 创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    // 注册UICollectionViewCell,UICollectionReusableView
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    NSInteger tag = 10;
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:tag];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag = tag;
        label.font = [UIFont systemFontOfSize:10];
        [cell.contentView addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"第%@个",@(indexPath.row)];
    [label sizeToFit];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第%@item",@(indexPath.row));
}
#pragma mark - TagsLabelLayoutDelegate
- (CGFloat)itemHeightInTagsLabelLayout:(UICollectionViewLayout *)layout {
    return 30;
}

- (CGFloat)tagsLabelLayout:(UICollectionViewLayout *)layout indexPath:(NSIndexPath *)indexPath {
    return 40 + arc4random_uniform(50);
}

- (UIEdgeInsets)edgeInsetsInTagsLabelLayout:(UICollectionViewLayout *)layout {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - UICollectionViewDelegateFlowLayout
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    view.backgroundColor = [UIColor redColor];
    return view;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
