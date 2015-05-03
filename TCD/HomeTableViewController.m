//
//  HomeTableViewController.m
//  TCD
//
//  Created by Gregg Mojica on 5/2/15.
//  Copyright (c) 2015 Gregg Mojica. All rights reserved.
//

#import "HomeTableViewController.h"
#import "HomeDetailViewController.h"

@interface HomeTableViewController ()

@end

@implementation HomeTableViewController


- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        
        self.parseClassName = @"Events";
        self.textKey = @"Title";
        
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        
        //self.objectsPerPage = 10;
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([PFUser currentUser]) {
        
    } else {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    
    [self setNeedsStatusBarAppearanceUpdate];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIColor *color = [UIColor colorWithRed:0.231 green:0.671 blue:0.82 alpha:1];
    
   [self.navigationController.navigationBar setBarTintColor:color];

    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

   // self.navigationController.navigationBar.tintColor = color;
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      
      
      [UIFont fontWithName:@"Avenir Next" size:21],
      NSFontAttributeName,
      
      
      [UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshTable:)
                                                 name:@"refreshTable"
                                               object:nil];
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)refreshTable:(NSNotification *) notification {
    [self loadObjects];
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshTable" object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    /*if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
     }*/
    
    PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude:40.7232420
                                                      longitude:-74.0064270];
    
    float f =  [[NSUserDefaults standardUserDefaults]floatForKey:@"sliderValue"];

    [query whereKey:@"Location" nearGeoPoint:userGeoPoint withinMiles:f];
    [query orderByDescending:@"createdAt"];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.transform = CGAffineTransformMakeScale(0.3, 0.3);

    
    [UIView animateWithDuration:1.3 delay:0
         usingSpringWithDamping:0.3 initialSpringVelocity:0.2
                        options:0 animations:^{
                            
                            cell.transform = CGAffineTransformMakeScale(1, 1);
                            
                            
                        } completion:nil];
    
    
    NSLog(@"The pfokect is %@", object);
    
    PFFile *thumbnail = [object objectForKey:@"imageFile"];
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
    nameLabel.text = [object objectForKey:@"Title"];

    UILabel *timeLabel = (UILabel*) [cell viewWithTag:99];
    timeLabel.text = [object objectForKey:@"Time"];
    
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Upcoming Events";
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    PFObject *object = [self.objects objectAtIndex:indexPath.row];
    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self refreshTable:nil];
    }];
}

- (void) objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    
    NSLog(@"error: %@", [error localizedDescription]);
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showSegue"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        NSLog(@"Current object is %@", object);
        
        HomeDetailViewController *destViewController = segue.destinationViewController;
        destViewController.title = [[self.objects objectAtIndex:indexPath.row]objectForKey:@"eventTitle"];
        //destViewController.description = [[self.objects objectAtIndex:indexPath.row]objectForKey:@"Description"];
        destViewController.object = object;
        
    }
}




@end
