//
//  FAFloatLabelTextView.h
//  FADesignable
//
//  Created by Fadi Abuzant on 7/20/18.
//

#import <UIKit/UIKit.h>
#import "FATextView.h"

IB_DESIGNABLE
@interface FAFloatLabelTextView : FATextView

/**
 * Read-only access to the floating label.
 */
@property (nonatomic, strong, readonly) UILabel * floatingLabel;

/**
 * Padding to be applied to the y coordinate of the floating label upon presentation.
 */
@property (nonatomic) IBInspectable CGFloat floatingLabelYPadding;

/**
 * Padding to be applied to the x coordinate of the floating label upon presentation.
 */
@property (nonatomic) IBInspectable CGFloat floatingLabelXPadding;

/**
 * Padding to be applied to the y coordinate of the placeholder.
 */
@property (nonatomic) IBInspectable CGFloat placeholderYPadding;

@property (nonatomic) CGFloat startingTextContainerInsetTop;

/**
 * Font to be applied to the floating label. Defaults to `[UIFont boldSystemFontOfSize:12.0f]`.
 * Provided for the convenience of using as an appearance proxy.
 */
@property (nonatomic, strong) UIFont * floatingLabelFont;

/**
 * Text color to be applied to the floating label while the text view is not a first responder.
 * Defaults to `[UIColor grayColor]`.
 * Provided for the convenience of using as an appearance proxy.
 */
@property (nonatomic, strong) IBInspectable UIColor * floatingLabelTextColor;

/**
 * Text color to be applied to the floating label while the text view is a first responder.
 * Tint color is used by default if an `floatingLabelActiveTextColor` is not provided.
 */
@property (nonatomic, strong) IBInspectable UIColor * floatingLabelActiveTextColor;

/**
 * Indicates whether the floating label should lock to the top of the text view, or scroll away with text when the text
 * view is scrollable. By default, floating labels will lock to the top of the text view and their background color will
 * be set to the text view's background color
 * Note that this works best when floating labels have a non-clear background color.
 */
@property (nonatomic, assign) IBInspectable BOOL floatingLabelShouldLockToTop;

/**
 * Indicates whether the floating label's appearance should be animated regardless of first responder status.
 * By default, animation only occurs if the text field is a first responder.
 */
@property (nonatomic, assign) IBInspectable BOOL animateEvenIfNotFirstResponder;

/**
 * Duration of the animation when showing the floating label.
 * Defaults to 0.3 seconds.
 */
@property (nonatomic, assign) NSTimeInterval floatingLabelShowAnimationDuration UI_APPEARANCE_SELECTOR;

/**
 * Duration of the animation when hiding the floating label.
 * Defaults to 0.3 seconds.
 */
@property (nonatomic, assign) NSTimeInterval floatingLabelHideAnimationDuration UI_APPEARANCE_SELECTOR;



/**
 *  Sets the placeholder and the floating title
 *
 *  @param placeholder The string that to be shown in the text view when no other text is present.
 *  @param floatingTitle The string to be shown above the text view once it has been populated with text by the user.
 */
- (void)setPlaceholder:(NSString *)placeholder floatingTitle:(NSString *)floatingTitle;
- (void)setString:(NSString *)text;
@property (nonatomic) CGRect initFrame;

@end
