//
//  SpecFooterView.m
//  淘宝多规格选择
//
//  Created by 会骑牛的小七 on 2018/2/26.
//  Copyright © 2018年 王帅. All rights reserved.
//

#import "SpecFooterView.h"

@implementation SpecFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)addTaped:(id)sender {
    if (self.addClick) {
        self.addClick(@"sub");
    }
}

- (IBAction)subTaped:(id)sender {
    if (self.subClick) {
        self.subClick(@"sub");
    }
}


@end
