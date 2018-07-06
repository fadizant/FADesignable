//
//  UIView+FAView.h
//  FADesignable
//
//  Created by Fadi Abuzant on 7/6/18.
//

#import <UIKit/UIKit.h>

@interface UIView (FAView)

#pragma mark - Gone
@property (nonatomic) float heightWithConstraint;
@property (nonatomic) float widthWithConstraint;
-(void)setGone:(BOOL)Gone;

@end
