//
//  ViewController.m
//  demo3
//
//  Created by 磊 on 15/12/8.
//  Copyright © 2015年 磊. All rights reserved.
//

#import "ViewController.h"
#import "UIView+MLLayout.h"
@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    NSArray *con = [view1 ml_AlignInnerType:0 referView:self.view size:size(100, 100) offset:nil];

    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
   NSArray *con1 = [view ml_AlignHorizontalType:AlignTypeBottomRight referView:view1 size:size(20, 20) offset:point(-30, -30)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
