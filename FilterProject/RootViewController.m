//
//  ViewController.m
//  FilterProject
//
//  Created by Dongdong on 16/4/19.
//  Copyright © 2016年 DD. All rights reserved.
//

#import "RootViewController.h"
#import "FilterViewController.h"
#import "PlaceFilterViewController.h"
#import "FilterButton.h"
#import "CalculateManage.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"首页";
    
    FilterButton *btn = [[FilterButton alloc] init];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 100));
    }];
    
    FilterButton *btn1 = [[FilterButton alloc] init];
    [btn1 setTitle:@"跳转1" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(push1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom).offset(10);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 100));
    }];

    
    /*
     /var/mobile/Containers/Data/Application/B7E0F934-1288-4BA5-A0B8-5938AA73A19D
     /var/mobile/Containers/Data/Application/B7E0F934-1288-4BA5-A0B8-5938AA73A19D/Documents
     **/
    
    /* 
     /var/mobile/Containers/Data/Application/1364C898-D32E-403F-BD93-70712C236651
     /var/mobile/Containers/Data/Application/1364C898-D32E-403F-BD93-70712C236651/Documents
     **/
    NSString *path = nil;
    path = NSHomeDirectory();
    NSLog(@"path = %@",path);
    path = ((NSArray *)NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES))[0];
    NSLog(@"path = %@",path);
    
    id <CalculateProtocol> obj = [[CalculateManage alloc] init];
    [obj plus:5];
    [obj multiply:10];
}

- (void)push1:(FilterButton *)sender
{
    [self.navigationController pushViewController:[PlaceFilterViewController new] animated:YES];
}

- (void)push:(FilterButton *)sender
{
    [self.navigationController pushViewController:[FilterViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
