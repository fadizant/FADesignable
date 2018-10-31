//
//  FATextField.m
//  FADesignable
//
//  Created by Fadi Abuzant on 7/6/18.
//

#import "FATextField.h"

@implementation FATextField

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
    
    if (!bottomBorder && _isBottomBorder) {
        self.borderStyle = UITextBorderStyleNone;
        bottomBorder = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
        bottomBorder.backgroundColor = self.isEditing ? _editingBorderColor : self.selected ? _selectedBorderColor : _normalBorderColor;
        [self addSubview:bottomBorder];
    } else if (_isBottomBorder)
    {
        bottomBorder.backgroundColor = self.isEditing ? _editingBorderColor : self.selected ? _selectedBorderColor : _normalBorderColor;
    }
    else
    {
        if (self.normalBorderColor)
            self.layer.borderColor = self.isEditing ? [_editingBorderColor CGColor] : self.selected ? [_selectedBorderColor CGColor] : [_normalBorderColor CGColor];
        
        if (self.borderWidth)
            self.layer.borderWidth = self.borderWidth;
        
        if (self.cornerRadius || self.cornerIsCircle)
            [self.layer setCornerRadius:self.cornerIsCircle ? self.frame.size.height/2 :self.cornerRadius];
    }
    
    //background
    if (self.isEditing) {
        if(_editingBackgroundColor)
            self.layer.backgroundColor = [_editingBackgroundColor CGColor];
    }else if (self.selected) {
        if(_selectedBackgroundColor)
            self.layer.backgroundColor = [_selectedBackgroundColor CGColor];
    } else {
        if(_normalBackgroundColor)
            self.layer.backgroundColor = [_normalBackgroundColor CGColor];
    }
    
    // drop shadow
    if (self.shadowRadius)
        [self.layer setShadowRadius:self.shadowRadius];
    
    if (self.shadowOpacity)
        [self.layer setShadowOpacity:self.shadowOpacity];
    
    if (self.shadowColor){
        [self.layer setShadowColor:self.shadowColor.CGColor];
        [self.layer setShadowOffset:self.shadowOffset];
        [self.layer setMasksToBounds:NO];
    }else{
        [self.layer setMasksToBounds:YES];
    }
}

//placeholder
-(void)setPlaceholderTextColor
{
    if ([self respondsToSelector:@selector(setAttributedPlaceholder:)] && self.placeholder && self.placeholderColor) {
        
        _placeholderColor = _placeholderColor ? _placeholderColor : [UIColor darkGrayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.attributedPlaceholder.string attributes:@{NSForegroundColorAttributeName: _placeholderColor}];
        
    }
    
}

//padding
- (CGRect)textRectForBounds:(CGRect)bounds {
    [self setPlaceholderTextColor];
    return CGRectInset(bounds,
                       _textStartPadding ? _textStartPadding :bounds.origin.x,
                       _textTopPadding ? _textTopPadding :2);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds,
                       _textStartPadding ? _textStartPadding :bounds.origin.x,
                       _textTopPadding ? _textTopPadding :2);
}

@end
