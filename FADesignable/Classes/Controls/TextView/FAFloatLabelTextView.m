//
//  FAFloatLabelTextView.m
//  FADesignable
//
//  Created by Fadi Abuzant on 7/20/18.
//

#import "FAFloatLabelTextView.h"
#import "NSString+FATextDirection.h"
#import "UITextView+Placeholder.h"

static CGFloat const kFloatingLabelShowAnimationDuration = 0.3f;
static CGFloat const kFloatingLabelHideAnimationDuration = 0.3f;

@implementation FAFloatLabelTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
        
        // force setter to be called on a placeholder defined in a NIB/Storyboard
        if (self.placeholder) {
            self.placeholder = self.placeholder;
        }
    }
    return self;
}

- (void)commonInit
{
    self.startingTextContainerInsetTop = self.textContainerInset.top;
    self.floatingLabelShouldLockToTop = YES;
    self.textContainer.lineFragmentPadding = 18;
    self.contentInset = UIEdgeInsetsMake(-4,-8,0,0);
    
//    _placeholderTextColor = [FAFloatLabelTextView defaultiOSPlaceholderColor];
    
    _floatingLabel = [UILabel new];
    _floatingLabel.alpha = 0.0f;
    _floatingLabel.backgroundColor = self.backgroundColor;
    [self addSubview:_floatingLabel];
    
    // some basic default fonts/colors
    _floatingLabelFont = [self defaultFloatingLabelFont];
    _floatingLabel.font = _floatingLabelFont;
    _floatingLabelTextColor = [FAFloatLabelTextView defaultiOSPlaceholderColor];
    _floatingLabel.textColor = _floatingLabelTextColor;
    _animateEvenIfNotFirstResponder = NO;
    _floatingLabelShowAnimationDuration = kFloatingLabelShowAnimationDuration;
    _floatingLabelHideAnimationDuration = kFloatingLabelHideAnimationDuration;
    
    //fix RTL space
    if ([UIView userInterfaceLayoutDirectionForSemanticContentAttribute:self.semanticContentAttribute] == UIUserInterfaceLayoutDirectionRightToLeft) {
        _floatingLabelXPadding = _floatingLabelXPadding -15;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutSubviews)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutSubviews)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutSubviews)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:self];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidBeginEditingNotification
                                                  object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidEndEditingNotification
                                                  object:self];
    
}

#pragma mark -

- (UIFont *)defaultFloatingLabelFont
{
    UIFont *textViewFont = nil;
    
    //    if (!textViewFont && self.placeholderLabel.attributedText && self.placeholderLabel.attributedText.length > 0) {
    //        textViewFont = [self.placeholderLabel.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:NULL];
    //    }
    //    if (!textViewFont) {
    //        textViewFont = self.placeholderLabel.font;
    //    }
    //
    //    return [UIFont fontWithName:textViewFont.fontName size:roundf(textViewFont.pointSize * 0.7f)];
    
    return [UIFont fontWithName:textViewFont.fontName size:8.0f];
}

//- (void)setPlaceholder:(NSString *)placeholder
//{
////    self.placeholder = placeholder;
//    _floatingLabel.text = placeholder;
//
//    if (0 != self.floatingLabelShouldLockToTop) {
//        _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
//                                          _floatingLabel.frame.origin.y,
//                                          self.frame.size.width - self.textContainer.lineFragmentPadding,
//                                          _floatingLabel.frame.size.height);
//    }
//
//    [self setNeedsLayout];
//}

- (void)setPlaceholder:(NSString *)placeholder floatingTitle:(NSString *)floatingTitle
{
    self.placeholder = placeholder;
    _floatingLabel.text = floatingTitle;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self adjustTextContainerInsetTop];
    
    CGSize floatingLabelSize = [_floatingLabel sizeThatFits:_floatingLabel.superview.bounds.size];
    
    _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                      _floatingLabel.frame.origin.y,
                                      self.frame.size.width - self.textContainer.lineFragmentPadding,
                                      floatingLabelSize.height);
    
    [self setLabelOriginForTextAlignment];
    
    BOOL firstResponder = self.isFirstResponder;
    _floatingLabel.textColor = (firstResponder && self.text && self.text.length > 0 ?
                                self.labelActiveColor : self.floatingLabelTextColor);
    
    if (!self.text || 0 == [self.text length]) {
        [self hideFloatingLabel:firstResponder];
    }
    else {
        [self showFloatingLabel:firstResponder];
    }
    
    _floatingLabel.text = self.placeholder;
    
    if (0 != self.floatingLabelShouldLockToTop) {
        _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                          _floatingLabel.frame.origin.y,
                                          self.frame.size.width - self.textContainer.lineFragmentPadding,
                                          _floatingLabel.frame.size.height);
    }
    
    if (!_floatingLabelActiveTextColor && _floatingLabelTextColor) {
        _floatingLabelActiveTextColor = _floatingLabelTextColor;
    }
}

- (void)setString:(NSString *)text
{
    self.text = text;
    [self layoutSubviews];
}

- (UIColor *)labelActiveColor
{
    if (_floatingLabelActiveTextColor) {
        return _floatingLabelActiveTextColor;
    }
    else if ([self respondsToSelector:@selector(tintColor)]) {
        return [self performSelector:@selector(tintColor)];
    }
    return [UIColor whiteColor];//[UIColor blueColor];
}

- (void)showFloatingLabel:(BOOL)animated
{
    void (^showBlock)(void) = ^{
        self->_floatingLabel.alpha = 1.0f;
        CGFloat top = 5.0;//_floatingLabelYPadding;
        if (0 != self.floatingLabelShouldLockToTop) {
            top += self.contentOffset.y;
        }
        self->_floatingLabel.frame = CGRectMake(self->_floatingLabel.frame.origin.x,
                                          top - (self.floatingLabelShouldLockToTop ? 5 : 0),
                                                self->_floatingLabel.frame.size.width,
                                                self.floatingLabelShouldLockToTop ? 15 : self->_floatingLabel.frame.size.height);
        
        
        self.startingTextContainerInsetTop = self.startingTextContainerInsetTop ? self.startingTextContainerInsetTop : top;
        [self adjustTextContainerInsetTop];
    };
    
    if ((animated || 0 != _animateEvenIfNotFirstResponder)
        && (0 == self.floatingLabelShouldLockToTop || _floatingLabel.alpha != 1.0f)) {
        [UIView animateWithDuration:_floatingLabelShowAnimationDuration
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut
                         animations:showBlock
                         completion:nil];
    }
    else {
        showBlock();
    }
}

- (void)hideFloatingLabel:(BOOL)animated
{
    void (^hideBlock)(void) = ^{
        self->_floatingLabel.alpha = 0.0f;
        self->_floatingLabel.frame = CGRectMake(self->_floatingLabel.frame.origin.x,
                                          self->_floatingLabel.font.lineHeight + self->_placeholderYPadding,
                                          self->_floatingLabel.frame.size.width,
                                          self->_floatingLabel.frame.size.height);
        
    };
    
    if (animated || 0 != _animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:_floatingLabelHideAnimationDuration
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseIn
                         animations:hideBlock
                         completion:nil];
    }
    else {
        hideBlock();
    }
}

- (void)adjustTextContainerInsetTop
{
    self.textContainerInset = UIEdgeInsetsMake(self.startingTextContainerInsetTop
                                               + _floatingLabel.font.lineHeight + _placeholderYPadding,
                                               self.textContainerInset.left,
                                               self.textContainerInset.bottom,
                                               self.textContainerInset.right);
}



- (void)setLabelOriginForTextAlignment
{
    CGFloat floatingLabelOriginX = [self textRect].origin.x;
    
    if (self.textAlignment == NSTextAlignmentCenter) {
        floatingLabelOriginX = (self.frame.size.width/2) - (_floatingLabel.frame.size.width/2);
    }
    else if (self.textAlignment == NSTextAlignmentRight) {
        floatingLabelOriginX = self.frame.size.width - _floatingLabel.frame.size.width;
    }
    else if (self.textAlignment == NSTextAlignmentNatural) {
        FATextDirectionEnum baseDirection = [_floatingLabel.text getBaseDirection];
        if (baseDirection == FATextDirectionEnumRightToLeft) {
            floatingLabelOriginX = self.frame.size.width - _floatingLabel.frame.size.width;
        }
    }
    
    _floatingLabel.frame = CGRectMake(floatingLabelOriginX + _floatingLabelXPadding, _floatingLabel.frame.origin.y,
                                      _floatingLabel.frame.size.width, _floatingLabel.frame.size.height);
    
}

- (CGRect)textRect
{
    CGRect rect = UIEdgeInsetsInsetRect(self.bounds, self.contentInset);
    
    if (self.textContainer) {
        rect.origin.x += self.textContainer.lineFragmentPadding;
        rect.origin.y += self.textContainerInset.top;
    }
    
    return CGRectIntegral(rect);
}

- (void)setFloatingLabelFont:(UIFont *)floatingLabelFont
{
    _floatingLabelFont = floatingLabelFont;
    _floatingLabel.font = _floatingLabelFont ? _floatingLabelFont : [self defaultFloatingLabelFont];
    self.placeholder = self.placeholder; // Force the label to lay itself out with the new font.
}


#pragma mark - Apple UITextView defaults

+ (UIColor *)defaultiOSPlaceholderColor
{
    return [[UIColor lightGrayColor] colorWithAlphaComponent:0.65f];
}

#pragma mark - UITextView

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self layoutSubviews];
}

//- (void)setText:(NSString *)text
//{
//    [super setText:text];
//    [self layoutSubviews];
//}


- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    
    if (0 != self.floatingLabelShouldLockToTop) {
        _floatingLabel.backgroundColor = self.backgroundColor;
    }
}

@end
