//
//  FAMultiCornersView.h
//  FADesignable
//
//  Created by Fadi Abuzant on 11/17/18.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface FAMultiCornersView : UIView

#pragma mark - Design Mode
@property (nonatomic) BOOL isInDesignMode;
@property (nonatomic) IBInspectable BOOL stopDraw;

#pragma mark - Border
@property (nonatomic,retain) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;

#pragma mark - Corner
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable BOOL topLeftCorner;
@property (nonatomic) IBInspectable BOOL topRightCorner;
@property (nonatomic) IBInspectable BOOL bottomLeftCorner;
@property (nonatomic) IBInspectable BOOL bottomRightCorner;

@end
