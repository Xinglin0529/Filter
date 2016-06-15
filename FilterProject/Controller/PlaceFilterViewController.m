//
//  PlaceFilterViewController.m
//  FilterProject
//
//  Created by Dongdong on 16/4/20.
//  Copyright © 2016年 DD. All rights reserved.
//

#import "PlaceFilterViewController.h"
#import "PlaceFilterView.h"
#import "PlaceFilterModel.h"

@interface PlaceFilterViewController () <PlaceFilterViewDelegate>

@property (nonatomic, strong) PlaceFilterView *filterView;
@property (nonatomic, assign) NSInteger selectSection;
@property (nonatomic, assign) NSInteger selectRow;
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation PlaceFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"展开" style:UIBarButtonItemStylePlain target:self action:@selector(show:)];
    self.selectSection = 0;
    self.selectRow = 0;
    self.filterView = [[PlaceFilterView alloc] initWithFrame:self.view.bounds];
    self.filterView.delegate = self;
    [self.view addSubview:self.filterView];
    
    self.data = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 3; i++) {
        PlaceFilterModel *model1 = [[PlaceFilterModel alloc] init];
        if (i == 0) {
            NSMutableArray *defaultArr = [[NSMutableArray alloc] init];
            for (NSInteger j = 0; j < 3; j++) {
                PlaceFilterSubmodel *sub11 = [[PlaceFilterSubmodel alloc] init];
                if (j == 0) {
                    sub11.selected = YES;
                } else {
                    sub11.selected = NO;
                }
                sub11.rowName = [NSString stringWithFormat:@"%ld000m",(long)(j+1)];
                [defaultArr addObject:sub11];
            }
            model1.filterSubmodels = defaultArr;
        } else {
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            for (NSInteger j = 0; j < 3; j++) {
                PlaceFilterSubmodel *sub11 = [[PlaceFilterSubmodel alloc] init];
                sub11.selected = NO;
                sub11.rowName = [NSString stringWithFormat:@"%ld000m",(long)(j+1)];
                [arr addObject:sub11];
            }
            model1.filterSubmodels = arr;
        }
        model1.sectionName = [NSString stringWithFormat:@"我的附近%ld",(long)(i+1)];
        [self.data addObject:model1];
    }
}

- (void)onSelectItem:(NSInteger)section row:(NSInteger)row
{
    self.selectSection = section;
    self.selectRow = row;
    for (NSInteger i = 0; i < self.data.count; i++) {
        if (i == section) {
            PlaceFilterModel *model = self.data[section];
            for (NSInteger j = 0; j < model.filterSubmodels.count; j++) {
                PlaceFilterSubmodel *sub = model.filterSubmodels[j];
                if (j == row) {
                    sub.selected = YES;
                } else {
                    sub.selected = NO;
                }
            }
        } else {
            PlaceFilterModel *model = self.data[i];
            for (NSInteger j = 0; j < model.filterSubmodels.count; j++) {
                PlaceFilterSubmodel *sub = model.filterSubmodels[j];
                sub.selected = NO;
            }
        }
    }
    
    NSLog(@"section = %d, row = %d",section,row);
}

- (void)show:(UIBarButtonItem *)item
{
    [self.filterView showFilterView:self.data section:self.selectSection row:self.selectRow];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.filterView hideFilterView];
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
