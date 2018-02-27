//
//  SpecModel.h
//  淘宝多规格选择
//
//  Created by 会骑牛的小七 on 2018/2/26.
//  Copyright © 2018年 王帅. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SpecListModel;

@interface SpecModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray<SpecListModel *> *list;

@property (nonatomic, assign) NSInteger selRow; //默认值 999

@end

@interface SpecListModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *kucun;

@property (nonatomic, assign) BOOL isChoose; //是否被选中

@end

