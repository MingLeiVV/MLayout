//
//  UIView+MLLayout.h
//  MLLayout
//
//  Created by 吴明磊 on 15/12/15.
//  Copyright © 2015年 wuminglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#define size(width,height)     [NSValue valueWithCGSize:CGSizeMake(width, height)]
#define ofset(x,y) [NSValue valueWithCGPoint:CGPointMake(x, y)]

typedef NS_OPTIONS(NSUInteger, AlignType) {
    AlignTypeTop          = 0,
    AlignTypeLeft         = 1 << 0,
    AlignTypeRight        = 1 << 1,
    AlignTypeBottom       = 1 << 2,
    AlignTypeTopLeft      = 1 << 3,
    AlignTypeTopRight     = 1 << 4,
    AlignTypeTopCenter    = 1 << 5,
    AlignTypeBottomLeft   = 1 << 6,
    AlignTypeBottomRight  = 1 << 7,
    AlignTypeBottomCenter = 1 << 8,
    AlignTypeCenterLeft   = 1 << 9,
    AlignTypeCenterRight  = 1 << 10,
    AlignTypeCenterCenter = 1 << 11
};
@interface UIView (MLLayout)
///  填充子视图
- (NSArray *)ml_FillInsets:(UIEdgeInsets)insets;
///  参照参考视图内部对齐
- (NSArray *)ml_AlignInnerType:(AlignType)type referView:(UIView *)referView size:(id)size offset:(id)offset;
///  参照参考视图垂直对齐
- (NSArray *)ml_AlignVerticalType:(AlignType)type referView:(UIView *)referView size:(id)size offset:(id)offset;
///  参照参考视图水平对齐
- (NSArray *)ml_AlignHorizontalType:(AlignType)type referView:(UIView *)referView size:(id)size offset:(id)offset;
///  在当前视图内部水平平铺控件
- (NSArray *)ml_HorizontalTileViews:(NSArray *)views insets:(UIEdgeInsets)insets;
///  在当前视图内部垂直平铺控件
- (NSArray *)ml_VerticalTileViews:(NSArray *)views insets:(UIEdgeInsets)insets;
///  参照某个视图等高等宽
- (NSArray *)ml_RelationEqualViews:(NSArray *)views;
///  水平中线、垂直中线
- (NSArray *)ml_AlignCenterLineViews:(NSArray *)views centerX:(BOOL)centerX centerY:(BOOL)centerY;
///  从约束数组中查找指定 attribute 的约束
- (NSLayoutConstraint *)ml_ConstraintFromSet:(NSArray *)constraintsList attribute:(NSLayoutAttribute)attribute;
@end
