//
//  ProductSpecView.h
//  淘宝多规格选择
//
//  Created by 会骑牛的小七 on 2018/2/24.
//  Copyright © 2018年 王帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecModel.h"

typedef void(^SelectedSpecName)(NSString *name);

@interface ProductSpecView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) SelectedSpecName valueBlock;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;

@property (nonatomic, strong) NSArray<SpecModel *> *specArray;

- (void)show;
- (void)dismiss;

@end
