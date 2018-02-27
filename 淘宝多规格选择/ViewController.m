//
//  ViewController.m
//  淘宝多规格选择
//
//  Created by 会骑牛的小七 on 2018/2/24.
//  Copyright © 2018年 王帅. All rights reserved.
//

#import "ViewController.h"
#import "ProductSpecView.h"
#import "SpecModel.h"

@interface ViewController ()

@property (nonatomic, strong) ProductSpecView *specView;
@property (nonatomic, strong) NSArray<SpecModel *> *specArray;
@property (weak, nonatomic) IBOutlet UILabel *desLable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"规格选择";
    self.desLable.text = @"";
    
    //测试数据
    [self testData];
    
}

- (IBAction)buyTaped:(id)sender {
    self.specView.specArray = self.specArray;
    [self.specView.collectionView reloadData];
    [self.specView show];
}

- (ProductSpecView *)specView {
    if (!_specView) {
        _specView = [[[NSBundle mainBundle]loadNibNamed:@"ProductSpecView" owner:nil options:nil] lastObject];
        _specView.frame = self.view.frame;
        __weak typeof(self) weakSelf = self;
        _specView.valueBlock = ^(NSString *name) {
            [weakSelf.desLable setText:name];
        };
    }
    return _specView;
}

- (void)testData {
    SpecModel *model = [[SpecModel alloc]init];
    model.selRow = 999;
    model.name = @"颜色";
    
    SpecListModel *listmodel = [[SpecListModel alloc]init];
    listmodel.name = @"白色";
    
    SpecListModel *listmodel1 = [[SpecListModel alloc]init];
    listmodel1.name = @"紫色";
    
    SpecListModel *listmodel2 = [[SpecListModel alloc]init];
    listmodel2.name = @"黄色";
    
    model.list = @[listmodel, listmodel1, listmodel2];
    
    SpecModel *model1 = [[SpecModel alloc]init];
    model1.selRow = 999;
    model1.name = @"尺寸";
    
    SpecListModel *listmodel3 = [[SpecListModel alloc]init];
    listmodel3.name = @"L 145/72A";
    
    SpecListModel *listmodel4 = [[SpecListModel alloc]init];
    listmodel4.name = @"XS 150/76A";
    
    SpecListModel *listmodel5 = [[SpecListModel alloc]init];
    listmodel5.name = @"XL 155/80A";
    
    model1.list = @[listmodel3, listmodel4, listmodel5];
    
    self.specArray = @[model, model1];
}

@end
