//
//  UIScrollView+FAScrollView.m
//  FADesignable
//
//  Created by Fadi Abuzant on 7/17/18.
//

#import "UIScrollView+FAScrollView.h"

@implementation UIScrollView (FAScrollView)


#pragma mark - Property
-(UIColor*)refreshColor {
    return objc_getAssociatedObject(self, @selector(refreshColor));
}
-(void)setRefreshColor:(UIColor*)refreshColor {
    objc_setAssociatedObject(self, @selector(refreshColor), refreshColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIColor*)refreshBackgroundColor {
    return objc_getAssociatedObject(self, @selector(refreshBackgroundColor));
}
-(void)setRefreshBackgroundColor:(UIColor*)refreshBackgroundColor {
    objc_setAssociatedObject(self, @selector(refreshBackgroundColor), refreshBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString*)refreshTitle {
    return objc_getAssociatedObject(self, @selector(refreshTitle));
}
-(void)setRefreshTitle:(NSString*)refreshTitle {
    objc_setAssociatedObject(self, @selector(refreshTitle), refreshTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - refreshControl
NSString const *refreshControlKey = @"FAItemLoader.refreshControlKey";

-(UIRefreshControl*)refreshControlView {
    return objc_getAssociatedObject(self, &refreshControlKey);
}

-(void)setRefreshControlView:(UIRefreshControl*)value {
    objc_setAssociatedObject(self, &refreshControlKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - refreshView
NSString const *refreshViewKey = @"FAItemLoader.refreshViewKey";

-(refreshView)refresh {
    return objc_getAssociatedObject(self, &refreshViewKey);
}

-(void)setRefresh:(refreshView)value {
    objc_setAssociatedObject(self, &refreshViewKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Add refreshControl to scrollView
-(void)refreshView:(refreshView)refresh{
    if (!self.refreshControlView)
    self.refreshControlView = [[UIRefreshControl alloc]init];
    
    [self refreshControl:self.refreshControlView
     refreshControlColor:self.refreshColor ? self.refreshColor : [UIColor blackColor]
refreshControlBackgroundColor:self.refreshBackgroundColor
     refreshControlTitle:self.refreshTitle
             refreshView:refresh];
}

-(void)refreshControlColor:(UIColor*)color refreshView:(refreshView)refresh{
    if (!self.refreshControlView)
    self.refreshControlView = [[UIRefreshControl alloc]init];
    
    [self refreshControl:self.refreshControlView
     refreshControlColor:color
refreshControlBackgroundColor:self.refreshBackgroundColor
     refreshControlTitle:self.refreshTitle
             refreshView:refresh];
}

-(void)refreshControlColor:(UIColor*)color refreshControlTitle:(NSString*)title refreshView:(refreshView)refresh{
    if (!self.refreshControlView)
    self.refreshControlView = [[UIRefreshControl alloc]init];
    
    [self refreshControl:self.refreshControlView
     refreshControlColor:color
refreshControlBackgroundColor:self.refreshBackgroundColor
     refreshControlTitle:title
             refreshView:refresh];
}

-(void)refreshControl:(UIRefreshControl*)refreshControl
  refreshControlColor:(UIColor*)color
refreshControlBackgroundColor:(UIColor*)backgroundColor
  refreshControlTitle:(NSString*)title
          refreshView:(refreshView)refresh{
    [refreshControl setTintColor:color];
    
    if (backgroundColor)
    [refreshControl setBackgroundColor:backgroundColor];
    
    if (title) {
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:color
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Loading please wait...", @"") attributes:attrsDictionary];
        self.refreshControlView.attributedTitle = attributedTitle;
    }
    
    [self addSubview:refreshControl];
    [self setAlwaysBounceVertical:YES];
    
    [self setRefresh:refresh];
    [refreshControl addTarget:self action:@selector(startRefreshTable:) forControlEvents:UIControlEventValueChanged];
}


- (void)startRefreshTable:(id)sender  {
    if ([self refresh]) {
        [self refresh]();
    }
}

-(void)beginRefreshing{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self setContentOffset:CGPointMake(0, self.contentOffset.y - self.refreshControlView.frame.size.height) animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.refreshControlView layoutIfNeeded];
            [self.refreshControlView beginRefreshing];
            [self.refreshControlView sendActionsForControlEvents:UIControlEventValueChanged];
        });
    });
    
}

-(void)endRefreshing{
    if (self.refreshControlView)
    [self.refreshControlView endRefreshing];
}

@end
