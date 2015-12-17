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
//    view1.translatesAutoresizingMaskIntoConstraints = NO;
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    NSArray *con = [view1 ml_AlignInnerType:AlignTypeCenterCenter referView:self.view size:size(100, 100) offset:nil];

    
    UIView *view = [[UIView alloc]init];
//    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
//   NSArray *con1 = [view ml_AlignHorizontalType:AlignTypeTopRight referView:view1 size:size(50, 50) offset:nil];
     [self.view ml_AlignCenterLineViews:@[view,view1] centerX:NO centerY:YES];
    [view ml_AlignHorizontalType:AlignTypeLeft referView:view1 size:size(50, 50) offset:ofset(10, 0)];
    
//   NSLayoutConstraint *cons = [view ml_ConstraintFromSet:con1 attribute:NSLayoutAttributeWidth];
    
//    [self.view ml_RelationEqualViews:@[view,view1]];
   
    
//   NSArray *con1 = [view ml_AlignHorizontalType:AlignTypeBottomRight referView:view1 size:size(20, 20) offset:point(-30, -30)];
//    [view ml_FillInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    
    
    
    UIView *view2 = [[UIView alloc]init];
//    view2.translatesAutoresizingMaskIntoConstraints = NO;
    view2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view2];
    
//    [self.view ml_HorizontalTileViews:@[view,view1,view2] insets:UIEdgeInsetsMake(10, 10, 0, 10)];
    
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
