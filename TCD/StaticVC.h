//
//  ViewController.h
//  UITableViewDemo
//
//  Created by Gregg Mojica on 3/4/13.
//  Copyright (c) 2013 Gregg Mojica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaticVC : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end
