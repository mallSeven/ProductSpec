//
//  SpecFooterView.h
//  淘宝多规格选择
//
//  Created by 会骑牛的小七 on 2018/2/26.
//  Copyright © 2018年 王帅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddBlcok)(NSString *add);
typedef void(^SubBlcok)(NSString *sub);

@interface SpecFooterView : UICollectionReusableView

@property (nonatomic, copy) AddBlcok addClick;
@property (nonatomic, copy) SubBlcok subClick;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@end
