//
//  FATextView.h
//  FADesignable
//
//  Created by Fadi Abuzant on 7/6/18.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE

@interface FATextView : UITextView
{
    UIView *bottomBorder;
    BOOL isEditing;
}

#pragma mark - Design Mode
@property (nonatomic) BOOL isInDesignMode;
@property (nonatomic) IBInspectable BOOL stopDraw;

#pragma mark - Border
@property (nonatomic,retain) IBInspectable UIColor *normalBorderColor;
@property (nonatomic,retain) IBInspectable UIColor *normalBackgroundColor;
@property (nonatomic,retain) IBInspectable UIColor *selectedBorderColor;
@property (nonatomic,retain) IBInspectable UIColor *selectedBackgroundColor;
@property (nonatomic,retain) IBInspectable UIColor *editingBorderColor;
@property (nonatomic,retain) IBInspectable UIColor *editingBackgroundColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable BOOL isBottomBorder;

#pragma mark - Corner
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable BOOL cornerIsCircle;

#pragma mark - Shadow
@property (nonatomic) IBInspectable UIColor *shadowColor;
@property (nonatomic) IBInspectable CGFloat shadowRadius;
@property (nonatomic) IBInspectable CGFloat shadowOpacity;
@property (nonatomic) IBInspectable CGSize  shadowOffset;

#pragma mark - Padding
@property (nonatomic) IBInspectable CGFloat textStartPadding;
@property (nonatomic) IBInspectable CGFloat textTopPadding;
@property (nonatomic) IBInspectable CGFloat textLimitCharacters;

@property (nonatomic) IBInspectable BOOL selected;

@end
