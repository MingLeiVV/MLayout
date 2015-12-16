//
//  UIView+MLLayout.h
//  MLLayout
//
//  Created by 吴明磊 on 15/12/15.
//  Copyright © 2015年 wuminglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#define size(width,height)     [NSValue valueWithCGSize:CGSizeMake(width, height)]
#define point(x,y) [NSValue valueWithCGPoint:CGPointMake(x, y)]

typedef NS_OPTIONS(NSUInteger, AlignType) {
    AlignTypeTopLeft      = 0,
    AlignTypeTopRight     = 1 << 0,
    AlignTypeTopCenter    = 1 << 1,
    AlignTypeBottomLeft   = 1 << 2,
    AlignTypeBottomRight  = 1 << 3,
    AlignTypeBottomCenter = 1 << 4,
    AlignTypeCenterLeft   = 1 << 5,
    AlignTypeCenterRight  = 1 << 6,
    AlignTypeCenterCenter = 1 << 7
};
@interface UIView (MLLayout)
- (NSArray *)ml_AlignInnerType:(AlignType)type referView:(UIView *)referView size:(id)size offset:(id)offset;
- (NSArray *)ml_AlignVerticalType:(AlignType)type referView:(UIView *)referView size:(id)size offset:(id)offset;
- (NSArray *)ml_AlignHorizontalType:(AlignType)type referView:(UIView *)referView size:(id)size offset:(id)offset;
@end
