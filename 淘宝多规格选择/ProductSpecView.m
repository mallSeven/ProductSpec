//
//  ProductSpecView.m
//  淘宝多规格选择
//
//  Created by 会骑牛的小七 on 2018/2/24.
//  Copyright © 2018年 王帅. All rights reserved.
//

#import "ProductSpecView.h"
#import "SpecHeadView.h"
#import "SpecFooterView.h"
#import "SpecLabelCollectionViewCell.h"
#import "UICollectionViewLeftAlignedLayout.h"

@interface ProductSpecView () {
    BOOL isTouch; //标记是否点击确定，如未选择规格 则进行提示
}

@property (weak, nonatomic) IBOutlet UIImageView *product_img;
@property (weak, nonatomic) IBOutlet UILabel *product_title;
@property (weak, nonatomic) IBOutlet UILabel *product_price;

@property (nonatomic, assign) NSInteger productNumber;

@end

@implementation ProductSpecView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.productNumber = 1;
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UICollectionViewLeftAlignedLayout *flowLayout = [[UICollectionViewLeftAlignedLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 15;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SpecLabelCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SpecLabelCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SpecHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SpecHeadView"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SpecFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SpecFooterView"];
    
}

#pragma mark - UICollectionViewDataSource - UICollectionViewDelegate - UICollectionViewDelegateFlowLayout
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.specArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.specArray[section].list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SpecLabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SpecLabelCollectionViewCell" forIndexPath:indexPath];
    SpecListModel *listModel = self.specArray[indexPath.section].list[indexPath.row];
    cell.nameLable.text = listModel.name;
    if (listModel.isChoose) {
        cell.backgroundImg.image = [UIImage imageNamed:@"btn_selected_s"];
        cell.nameLable.textColor = [UIColor whiteColor];
    }else {
        cell.backgroundImg.image = [UIImage imageNamed:@"btn_selected_n"];
        cell.nameLable.textColor = [UIColor darkGrayColor];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SpecListModel *listModel = self.specArray[indexPath.section].list[indexPath.row];
    listModel.isChoose = !listModel.isChoose;
    [self.specArray[indexPath.section].list enumerateObjectsUsingBlock:^(SpecListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != indexPath.row) {
            obj.isChoose = NO;
        }
    }];
    if (listModel.isChoose) {
        self.specArray[indexPath.section].selRow = indexPath.row;
    }else {
        self.specArray[indexPath.section].selRow = 999;
    }
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = self.specArray[indexPath.section].list[indexPath.row].name;
    CGFloat width = (string.length + 2) * 14;
    return CGSizeMake(width, 25);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        SpecHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SpecHeadView" forIndexPath:indexPath];
        headView.nameLable.text = self.specArray[indexPath.section].name;
        NSString *promptString = @"";
        if (isTouch && self.specArray[indexPath.section].selRow == 999) {
            promptString = [NSString stringWithFormat:@"(请选择%@)", self.specArray[indexPath.section].name];
        }
        headView.promptLable.text = promptString;
        return headView;
    }else {
        SpecFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SpecFooterView" forIndexPath:indexPath];
        footerView.numberTextField.text = [NSString stringWithFormat:@"%ld", self.productNumber];
        __weak typeof(self) weakSelf = self;
        footerView.addClick = ^(NSString *add) {
            weakSelf.productNumber ++;
            [weakSelf.collectionView reloadData];
        };
        footerView.subClick = ^(NSString *sub) {
            if (weakSelf.productNumber == 1) {
                return;
            }
            weakSelf.productNumber --;
            [weakSelf.collectionView reloadData];
        };
        return footerView;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.frame.size.width, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == self.specArray.count - 1) {
        return CGSizeMake(self.frame.size.width, 60);
    }else {
        return CGSizeMake(self.frame.size.width, 0);
    }
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.constraint.constant = self.frame.size.width * 1.2;
    [UIView animateWithDuration:0.3 animations:^{
        self.constraint.constant = 0;
        [self layoutIfNeeded];
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.1;
        self.constraint.constant = self.frame.size.width * 1.2;
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.alpha = 1;
        [self removeFromSuperview];
    }];
}

- (IBAction)cancleTaped:(id)sender {
    [self dismiss];
}

- (IBAction)sureTaped:(id)sender {
    isTouch = YES;
    for (SpecModel *model in self.specArray) {
        if (model.selRow == 999) {
            [self.collectionView reloadData];
            return;
        }
    }
    NSLog(@"已选择");
}

@end
