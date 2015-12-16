//
//  UIView+MLLayout.m
//  MLLayout
//
//  Created by 吴明磊 on 15/12/15.
//  Copyright © 2015年 wuminglei. All rights reserved.
//

#import "UIView+MLLayout.h"

@interface LayoutAttributes : NSObject
@property(nonatomic, assign)NSLayoutAttribute horizontal;
@property(nonatomic, assign)NSLayoutAttribute referHorizontal;
@property(nonatomic, assign)NSLayoutAttribute vertical;
@property(nonatomic, assign)NSLayoutAttribute referVertical;

- (instancetype)initWithHorizontal:(NSLayoutAttribute)horizontal referHorizontal:(NSLayoutAttribute)referHorizontal vertical:(NSLayoutAttribute)vertical referVertical:(NSLayoutAttribute)referVertical;
@end

@implementation LayoutAttributes
- (instancetype)init {
    self = [super init];
    if (self) {
        
        _horizontal = NSLayoutAttributeLeft;
        _referHorizontal = NSLayoutAttributeLeft;
        _vertical = NSLayoutAttributeTop;
        _referVertical = NSLayoutAttributeTop;
    }
    
    return self;
}
- (instancetype)initWithHorizontal:(NSLayoutAttribute)horizontal referHorizontal:(NSLayoutAttribute)referHorizontal vertical:(NSLayoutAttribute)vertical referVertical:(NSLayoutAttribute)referVertical {
    self = [super init];
    if (self) {
        _horizontal = horizontal;
        _referHorizontal = referHorizontal;
        _vertical = vertical;
        _referVertical = referVertical;
    }
    return self;
}

- (instancetype)horizontalsFrom:(NSLayoutAttribute)from to:(NSLayoutAttribute)to {
    
    _horizontal = from;
    _referHorizontal = to;
    return self;
}
- (instancetype)verticalsFrom:(NSLayoutAttribute)from to:(NSLayoutAttribute)to {
    
    _vertical = from;
    _referVertical = to;
    return self;
}


@end

@interface UIView (MLLayout)
@property(nonatomic, assign)NSLayoutAttribute Top;
@property(nonatomic, assign)NSLayoutAttribute Right;
@property(nonatomic, assign)NSLayoutAttribute Left;
@property(nonatomic, assign)NSLayoutAttribute Bottom;
@property(nonatomic, assign)NSLayoutAttribute CenterX;
@property(nonatomic, assign)NSLayoutAttribute CenterY;
@end
@implementation UIView (MLLayout)

///  参照参考视图内部对齐
///
///  - parameter type:      对齐方式
///  - Parameter referView: 参考视图
///  - Parameter size:      视图大小，如果是 nil 则不设置大小
///  - Parameter offset:    偏移量，默认是 CGPoint(x: 0, y: 0)
///
///  - returns: 约束数组
- (NSArray *)ml_AlignInnerType:(AlignType)type referView:(UIView *)referView size:(id)size offset:(id)offset {
    
    if (referView == nil) {
        return nil;
    }
    return [self ml_AlignLayoutReferView:referView attributes:[self layoutAttributesType:type isInner:YES isVertical:YES] size:size offset:offset];
}

///  参照参考视图垂直对齐
///
///  - parameter type:      对齐方式
///  - parameter referView: 参考视图
///  - parameter size:      视图大小，如果是 nil 则不设置大小
///  - parameter offset:    偏移量，默认是 CGPoint(x: 0, y: 0)
///
///  - returns: 约束数组
- (NSArray *)ml_AlignVerticalType:(AlignType)type referView:(UIView *)referView size:(id)size offset:(id)offset {
    
    return [self ml_AlignLayoutReferView:referView attributes:[self layoutAttributesType:type isInner:NO isVertical:YES] size:size offset:offset];
}
///  参照参考视图水平对齐
///
///  - parameter type:      对齐方式
///  - parameter referView: 参考视图
///  - parameter size:      视图大小，如果是 nil 则不设置大小
///  - parameter offset:    偏移量，默认是 CGPoint(x: 0, y: 0)
///
///  - returns: 约束数组
- (NSArray *)ml_AlignHorizontalType:(AlignType)type referView:(UIView *)referView size:(id)size offset:(id)offset {
    
    return [self ml_AlignLayoutReferView:referView attributes:[self layoutAttributesType:type isInner:NO isVertical:NO] size:size offset:offset];
}

///  在当前视图内部水平平铺控件
///
///  - parameter views:  子视图数组
///  - parameter insets: 间距
///
///  - returns: 约束数组
- (NSArray *)ml_HorizontalTileViews:(NSArray *)views insets:(UIEdgeInsets)insets {
    
    NSAssert(!views || views.count == 0, @"views should not be empty");
    
    var cons = [NSLayoutConstraint]()
    
    let firstView = views[0]
    firstView.ml_AlignInner(type: ml_AlignType.TopLeft, referView: self, size: nil, offset: CGPoint(x: insets.left, y: insets.top))
    cons.append(NSLayoutConstraint(item: firstView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -insets.bottom))
    
    // 添加后续视图的约束
    var preView = firstView
    for i in 1..<views.count {
        let subView = views[i]
        cons += subView.ml_sizeConstraints(firstView)
        subView.ml_AlignHorizontal(type: ml_AlignType.TopRight, referView: preView, size: nil, offset: CGPoint(x: insets.right, y: 0))
        preView = subView
    }
    
    let lastView = views.last!
    cons.append(NSLayoutConstraint(item: lastView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -insets.right))
    
    addConstraints(cons)
    return cons
}



// MARK: - 私有函数
///  参照参考视图对齐布局
///
///  - parameter referView:  参考视图
///  - parameter attributes: 参照属性
///  - parameter size:       视图大小，如果是 nil 则不设置大小
///  - parameter offset:     偏移量，默认是 CGPoint(x: 0, y: 0)
///
///  - returns: 约束数组
- (NSArray *)ml_AlignLayoutReferView:(UIView *)referView attributes:(LayoutAttributes *)attributes size:(id)size offset:(id)offset {

    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSMutableArray *consArray = [[NSMutableArray alloc]init];
    CGPoint ofset = offset != nil ? [offset CGPointValue] : CGPointZero;
    [consArray addObjectsFromArray:[self ml_positionConstraintsReferView:referView attributes:attributes offset:ofset]];
    if (size) {
        [consArray addObjectsFromArray:[self ml_sizeConstraintsSize:[size CGSizeValue]]];
    }
    
    [self.superview addConstraints:consArray.copy];
    
    return consArray.copy;
    
}

///  尺寸约束数组
///
///  - parameter size: 视图大小
///
///  - returns: 约束数组
- (NSArray *)ml_sizeConstraintsSize:(CGSize)size {
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:size.width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:size.height];
    
    return @[width,height];
}


///  位置约束数组
///
///  - parameter referView:  参考视图
///  - parameter attributes: 参照属性
///  - parameter offset:     偏移量
///
///  - returns: 约束数组
- (NSArray *)ml_positionConstraintsReferView:(UIView *)referView attributes:(LayoutAttributes *)attributes offset:(CGPoint)offset {
    
    NSLayoutConstraint *horizontal = [NSLayoutConstraint constraintWithItem:self attribute:attributes.horizontal relatedBy:NSLayoutRelationEqual toItem:referView attribute:attributes.referHorizontal multiplier:1.0 constant:offset.x];
    NSLayoutConstraint *vertical = [NSLayoutConstraint constraintWithItem:self attribute:attributes.vertical relatedBy:NSLayoutRelationEqual toItem:referView attribute:attributes.referVertical multiplier:1.0 constant:offset.y];
    
    return @[horizontal,vertical];
}

///  布局属性
- (LayoutAttributes *)layoutAttributesType:(AlignType)type isInner:(BOOL)isInner isVertical:(BOOL)isVertical {
   
    LayoutAttributes *attributes = [[LayoutAttributes alloc]init];
    switch (type) {
        case AlignTypeTopLeft:
            [[attributes horizontalsFrom:self.Left to:self.Left] verticalsFrom:self.Top to:self.Top];
            if (isInner) {
                return attributes;
            } else if (isVertical) {
                return [attributes verticalsFrom:self.Bottom to:self.Top];
            } else {
                return [attributes horizontalsFrom:self.Right to:self.Left];
            }
        case AlignTypeTopRight:
            [[attributes horizontalsFrom:self.Right to:self.Right]verticalsFrom:self.Top to:self.Top];
            if (isInner) {
                return attributes;
            } else if (isVertical) {
                return [attributes verticalsFrom:self.Bottom to:self.Top];
            } else {
                return [attributes horizontalsFrom:self.Left to:self.Right];
            }
        case AlignTypeTopCenter:
            [[attributes horizontalsFrom:self.CenterX to:self.CenterX]verticalsFrom:self.Top to:self.Top];
            return isInner ? attributes : [attributes verticalsFrom:self.Bottom to:self.Top];
        case AlignTypeBottomLeft:
            [[attributes horizontalsFrom:self.Left to:self.Left]verticalsFrom:self.Bottom to:self.Bottom];
            if (isInner) {
                return attributes;
            } else if (isVertical) {
                return [attributes verticalsFrom:self.Top to:self.Bottom];
            } else {
                return [attributes horizontalsFrom:self.Right to:self.Left];
            }
        case AlignTypeBottomRight:
            [[attributes horizontalsFrom:self.Right to:self.Right]verticalsFrom:self.Bottom to:self.Bottom];
            if (isInner) {
                return attributes;
            } else if (isVertical) {
                return [attributes verticalsFrom:self.Top to:self.Bottom];
            } else {
                return [attributes horizontalsFrom:self.Left to:self.Right];
            }
        case AlignTypeBottomCenter:
            [[attributes horizontalsFrom:self.CenterX to:self.CenterX]verticalsFrom:self.Bottom to:self.Bottom];
            
            return isInner ? attributes : [attributes verticalsFrom:self.Top to:self.Bottom];
        case AlignTypeCenterLeft:
            [[attributes horizontalsFrom:self.Left to:self.Left]verticalsFrom:self.CenterY to:self.CenterY];
            
            return isInner ? attributes : [attributes horizontalsFrom:self.Right to:self.Left];
        case AlignTypeCenterRight:
            [[attributes horizontalsFrom:self.Right to:self.Right]verticalsFrom:self.CenterY to:self.CenterY];
            
            return isInner ? attributes : [attributes horizontalsFrom:self.Left to:self.Right];
        case AlignTypeCenterCenter:
            
            return [[attributes horizontalsFrom:self.CenterX to:self.CenterX] verticalsFrom:self.CenterY to:self.CenterY];
    }

}

- (NSLayoutAttribute)Top {
    return NSLayoutAttributeTop;
}
- (NSLayoutAttribute)Left {
 return NSLayoutAttributeLeft;
}
- (NSLayoutAttribute)Right {
    return NSLayoutAttributeRight;
}
- (NSLayoutAttribute)Bottom {
    return NSLayoutAttributeBottom;
}
- (NSLayoutAttribute)CenterX {
    return NSLayoutAttributeCenterX;
}
- (NSLayoutAttribute)CenterY {
    return NSLayoutAttributeCenterY;
}
@end


