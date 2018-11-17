//
//  UIView+FAView.m
//  FADesignable
//
//  Created by Fadi Abuzant on 7/6/18.
//

#import "UIView+FAView.h"
#import <objc/runtime.h>

@implementation UIView (FAView)

#pragma mark - Gone

-(float)heightWithConstraint {
    return [objc_getAssociatedObject(self, @selector(heightWithConstraint)) floatValue];
}
-(void)setHeightWithConstraint:(float)heightWithConstraint {
    objc_setAssociatedObject(self, @selector(heightWithConstraint), [NSNumber numberWithFloat:heightWithConstraint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(float)widthWithConstraint {
    return [objc_getAssociatedObject(self, @selector(widthWithConstraint)) floatValue];
}
-(void)setWidthWithConstraint:(float)widthWithConstraint {
    objc_setAssociatedObject(self, @selector(widthWithConstraint), [NSNumber numberWithFloat:widthWithConstraint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setGone:(BOOL)Gone
{
    for (NSLayoutConstraint *item in [self constraints]) {
        if (item.firstAttribute == NSLayoutAttributeHeight &&
            item.relation == NSLayoutRelationEqual &&
            item.secondAttribute == NSLayoutAttributeNotAnAttribute &&
            [item.firstItem isEqual:self] &&
            item.shouldBeArchived) {
            //init height
            if (!self.heightWithConstraint)
                self.heightWithConstraint = item.constant;
            //set visible
            item.constant = Gone ? 0 : self.heightWithConstraint;
        }
        if (item.firstAttribute == NSLayoutAttributeWidth &&
            item.relation == NSLayoutRelationEqual &&
            item.secondAttribute == NSLayoutAttributeNotAnAttribute &&
            [item.firstItem isEqual:self] &&
            item.shouldBeArchived) {
            //init height
            if (!self.widthWithConstraint)
                self.widthWithConstraint = item.constant;
            //set visible
            item.constant = Gone ? 0 : self.widthWithConstraint;
        }
    }
    
    [self setHidden:Gone];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
    [self.superview layoutIfNeeded];
}

#pragma mark - corners

- (void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    [self _roundCorners:corners radius:radius];
}

- (void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    CAShapeLayer *mask = [self _roundCorners:corners radius:radius];
    [self addBorderWithMask:mask borderColor:borderColor borderWidth:borderWidth];
}

- (void)fullyRoundWithDiameter:(CGFloat)diameter borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = diameter / 2;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
}

- (CAShapeLayer *)_roundCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = path.CGPath;
    self.layer.mask = mask;
    return mask;
}

- (void)addBorderWithMask:(CAShapeLayer *)mask borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.path = mask.path;
    borderLayer.fillColor = UIColor.clearColor.CGColor;
    borderLayer.strokeColor = borderColor.CGColor;
    borderLayer.lineWidth = borderWidth;
    borderLayer.frame = self.bounds;
    [self.layer addSublayer:borderLayer];
}

@end
