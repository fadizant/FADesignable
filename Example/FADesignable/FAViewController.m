//
//  FAViewController.m
//  FADesignable
//
//  Created by fadizant on 04/27/2018.
//  Copyright (c) 2018 fadizant. All rights reserved.
//

#import "FAViewController.h"

@interface FAViewController ()

@end

@implementation FAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [_tableView refreshControlColor:[UIColor redColor] refreshView:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [_tableView endRefreshing];
        });
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
@end
