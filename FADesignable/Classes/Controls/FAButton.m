//
//  FAButton.m
//  FADesignable
//
//  Created by Fadi Abuzant on 7/6/18.
//

#import "FAButton.h"

@implementation FAButton

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
    
    if (self.selected) {
        self.layer.borderColor = [_selectedBorderColor CGColor];
        if(_selectedBackgroundColor)
            self.layer.backgroundColor = [_selectedBackgroundColor CGColor];
    } else if (self.highlighted) {
        self.layer.borderColor = [_highlightedBorderColor CGColor];
        if(_highlightedBackgroundColor)
            self.layer.backgroundColor = [_highlightedBackgroundColor CGColor];
    }else {
        self.layer.borderColor = [_normalBorderColor CGColor];
        if(_normalBackgroundColor)
            self.layer.backgroundColor = [_normalBackgroundColor CGColor];
    }
    
    
    if (self.borderWidth)
        self.layer.borderWidth = self.borderWidth;
    
    if (self.cornerRadius || self.cornerIsCircle)
        [self.layer setCornerRadius:self.cornerIsCircle ? self.frame.size.height/2 :self.cornerRadius];
    
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


@end
