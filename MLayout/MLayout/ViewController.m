//
//  ViewController.m
//  demo3
//
//  Created by 磊 on 15/12/8.
//  Copyright © 2015年 磊. All rights reserved.
//

#import "ViewController.h"
#import "UIView+MLLayout.h"
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface ViewController ()
@property(nonatomic,strong)UIButton *typeBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *summaryLabel;
@property(nonatomic,strong)UIView *imageContentView;
@property(nonatomic,strong)UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCons;
@property(nonatomic,strong)UILabel *commentLabel;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIView *view1 = [[UIView alloc]init];
////    view1.translatesAutoresizingMaskIntoConstraints = NO;
//    view1.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view1];
//    NSArray *con = [view1 ml_AlignInnerType:AlignTypeCenterCenter referView:self.view size:size(100, 100) offset:nil];
//
//    UIView *view = [[UIView alloc]init];
////    view.translatesAutoresizingMaskIntoConstraints = NO;
//    view.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:view];
////   NSArray *con1 = [view ml_AlignHorizontalType:AlignTypeTopRight referView:view1 size:size(50, 50) offset:nil];
//
//    [view ml_AlignHorizontalType:AlignTypeRight referView:view1 size:size(50, 50) offset:nil];
//    [self.view ml_AlignCenterLineViews:@[view,view1] centerX:NO centerY:YES];
//
////   NSLayoutConstraint *cons = [view ml_ConstraintFromSet:con1 attribute:NSLayoutAttributeWidth];
//    
////    [self.view ml_RelationEqualViews:@[view,view1]];
//   
//    
////   NSArray *con1 = [view ml_AlignHorizontalType:AlignTypeBottomRight referView:view1 size:size(20, 20) offset:point(-30, -30)];
////    [view ml_FillInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
//    
//    
//    
//    UIView *view2 = [[UIView alloc]init];
////    view2.translatesAutoresizingMaskIntoConstraints = NO;
//    view2.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:view2];
//    
////    [self.view ml_HorizontalTileViews:@[view,view1,view2] insets:UIEdgeInsetsMake(10, 10, 0, 10)];
//    
//    
   
    
// -------------------华丽的分割线---------------------------
    
    [self.view addSubview:self.typeBtn];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.summaryLabel];
    [self.view addSubview:self.imageContentView];
    [self.view addSubview:self.sourceLabel];
    [self.view addSubview:self.commentLabel];
//    [self.typeBtn ml_AlignInnerType:AlignTypeTopLeft referView:self.view size:size(20, 20) offset:ofset(10, 10)];
//    [self.titleLabel ml_AlignHorizontalType:AlignTypeTopRight referView:self.typeBtn size:nil offset:ofset(5, 0)];
//    [self.summaryLabel ml_AlignVerticalType:AlignTypeBottomLeft referView:self.typeBtn size:nil offset:ofset(0, 5)];
//    [self.imageContentView ml_AlignVerticalType:AlignTypeBottomLeft referView:self.summaryLabel size:size(self.view.bounds.size.width - 20, 100) offset:ofset(0, 5)];
//    [self.sourceLabel ml_AlignVerticalType:AlignTypeBottomLeft referView:self.imageContentView size:nil offset:ofset(0, 5)];
//    [self.commentLabel ml_AlignVerticalType:AlignTypeBottomRight referView:self.imageContentView size:nil offset:ofset(0, 5)];
//    [self.view ml_AlignCenterLineViews:@[self.sourceLabel,self.commentLabel] centerX:NO centerY:YES];


//    UIView *redView = [UIView new];
//    redView.backgroundColor = [UIColor redColor];
//    redView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:redView];
//    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:50];
//    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
//
//    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
//     NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
//    
//    [self.view addConstraints:@[top,left,width,height]];
    
    
    
//    [self.typeBtn ml_AlignInnerType:AlignTypeTopLeft referView:self.view size:nil offset:ofset(5, 30)];
//    [self.titleLabel ml_AlignInnerType:AlignTypeTopRight referView:self.view size:nil offset:ofset(5, 0)];
//    [self.titleLabel ml_AlignHorizontalType:AlignTypeLeft referView:self.typeBtn size:nil offset:ofset(5, 0)];
//    [self.titleLabel ml_AlignHorizontalType:AlignTypeLeft referView:self.view size:nil offset:ofset(10, 0)];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)typeBtn {
    if (!_typeBtn) {
        _typeBtn = [[UIButton alloc]init];
        [_typeBtn setTitle:@"顶" forState:UIControlStateNormal];
        _typeBtn.backgroundColor =[UIColor greenColor ];
    }
    return _typeBtn;
}
- (UILabel *)titleLabel {

    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"万万没想到还有大电影撒娇空间克隆点撒九克拉到家啦";
    }
    return _titleLabel;

}
- (UILabel *)summaryLabel {
    
    if (!_summaryLabel) {
        _summaryLabel = [[UILabel alloc]init];
        _summaryLabel.text = @"12.18哈哈哈哈";
    }
    return _summaryLabel;

}
- (UILabel *)sourceLabel {

    if (!_sourceLabel) {
        _sourceLabel = [[UILabel alloc]init];
        _sourceLabel.text = @"优酷";
    }
    return _sourceLabel;
}
- (UILabel *)commentLabel {

    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc]init];
        _commentLabel.text = @"999";
    }
    return _commentLabel;
}
- (UIView *)imageContentView {
    if (!_imageContentView) {
        _imageContentView = [[UIView alloc]init];
        _imageContentView.backgroundColor =[ UIColor redColor];
    }
    return _imageContentView;
}
@end
