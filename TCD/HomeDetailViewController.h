//
//  HomeDetailViewController.h
//  TCD
//
//  Created by Gregg Mojica on 5/2/15.
//  Copyright (c) 2015 Gregg Mojica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>

@interface HomeDetailViewController : UIViewController

@property (nonatomic, strong) PFObject *object;
@property (nonatomic, strong) NSString *eventTitle;
//@property (nonatomic, strong) NSString *description;
@property (strong, nonatomic) IBOutlet MKMapView *map;

@end
