//
//  FilterViewController.m
//  FilterProject
//
//  Created by Dongdong on 16/4/19.
//  Copyright © 2016年 DD. All rights reserved.
//

#import "FilterViewController.h"

#import "ConditionFilterView.h"

@interface FilterViewController ()

@property (nonatomic, strong) ConditionFilterView *filter;

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"展开" style:UIBarButtonItemStylePlain target:self action:@selector(show:)];
    
     self.filter = [[ConditionFilterView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.filter];
}

- (void)show:(id)sender
{
    [self.filter showFilter:@[@{@"header":@"场地类型",@"btn":@[@"btn1",@"btn1",@"btn1",@"btn1",@"btn1",@"btn1",@"btn1",@"btn1",@"btn1"]},@{@"header":@"容纳人数",@"btn":@[@"btn2",@"btn2",@"btn2",@"btn2",@"btn2",@"btn2",@"btn2",@"btn2",@"btn1"]},@{@"header":@"会议类型",@"btn":@[@"btn3",@"btn3",@"btn1",@"btn3",@"btn1",@"btn3",@"btn1",@"btn3",@"btn1"]},@{@"header":@"品牌",@"btn":@[@"btn4",@"btn4",@"btn1",@"btn4",@"btn1",@"btn4",@"btn4",@"btn4",@"btn1"]}]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.filter hideFilter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
