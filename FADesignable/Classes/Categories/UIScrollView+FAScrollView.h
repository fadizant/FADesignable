//
//  UIScrollView+FAScrollView.h
//  FADesignable
//
//  Created by Fadi Abuzant on 7/17/18.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIScrollView (FAScrollView)

#pragma mark - Property
@property (nonatomic) UIColor *refreshColor;
@property (nonatomic) UIColor *refreshBackgroundColor;
@property (nonatomic) NSString *refreshTitle;

#pragma mark - refreshControl
-(UIRefreshControl*)refreshControlView;

-(void)setRefreshControlView:(UIRefreshControl*)value;

-(void)beginRefreshing;

-(void)endRefreshing;

#pragma mark - Add refreshControl to scrollView

typedef void (^ refreshView)(void);

-(void)refreshView:(refreshView)refresh;

-(void)refreshControlColor:(UIColor*)color refreshView:(refreshView)refresh;

-(void)refreshControlColor:(UIColor*)color refreshControlTitle:(NSString*)title refreshView:(refreshView)refresh;

-(void)refreshControl:(UIRefreshControl*)refreshControl
  refreshControlColor:(UIColor*)color
refreshControlBackgroundColor:(UIColor*)backgroundColor
  refreshControlTitle:(NSString*)title
          refreshView:(refreshView)refresh;

@end
