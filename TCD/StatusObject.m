//
//  StatusObject.m
//  TCD
//
//  Created by Gregg Mojica on 5/2/15.
//  Copyright (c) 2015 Gregg Mojica. All rights reserved.
//

#import "StatusObject.h"

@implementation StatusObject

-(void)updateStatus {
    [self setNeedsStatusBarAppearanceUpdate];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIColor *color = [UIColor colorWithRed:0.231 green:0.671 blue:0.82 alpha:1];
    
    [self.navigationController.navigationBar setBarTintColor:color];
    
    // self.navigationController.navigationBar.tintColor = color;
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    
}

@end

