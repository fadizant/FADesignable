//
//  FAMultiCornersView.m
//  FADesignable
//
//  Created by Fadi Abuzant on 11/17/18.
//

#import "FAMultiCornersView.h"
#import "UIView+FAView.h"

@implementation FAMultiCornersView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.isInDesignMode = true;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self updateDesignable];
}

-(void)updateDesignable{
    
    if (self.stopDraw && !self.isInDesignMode)
        return;
    
    UIRectCorner corners = UIRectCornerAllCorners;
    
    if (self.topLeftCorner) {
        if (corners == UIRectCornerAllCorners) {
            corners = UIRectCornerTopLeft;
        } else {
            corners += UIRectCornerTopLeft;
        }
    }
    
    if (self.topRightCorner) {
        if (corners == UIRectCornerAllCorners) {
            corners = UIRectCornerTopRight;
        } else {
            corners += UIRectCornerTopRight;
        }
    }
    
    if (self.bottomLeftCorner) {
        if (corners == UIRectCornerAllCorners) {
            corners = UIRectCornerBottomLeft;
        } else {
            corners += UIRectCornerBottomLeft;
        }
    }
    
    if (self.bottomRightCorner) {
        if (corners == UIRectCornerAllCorners) {
            corners = UIRectCornerBottomRight;
        } else {
            corners += UIRectCornerBottomRight;
        }
    }
    
    if (corners != UIRectCornerAllCorners) {
        if (self.borderColor) {
            [self roundCorners:corners radius:self.cornerRadius borderColor:self.borderColor borderWidth:self.borderWidth];
        } else {
            [self roundCorners:corners radius:self.cornerRadius];
        }
    }
}

@end
