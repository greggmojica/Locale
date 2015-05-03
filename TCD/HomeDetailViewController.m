//
//  HomeDetailViewController.m
//  TCD
//
//  Created by Gregg Mojica on 5/2/15.
//  Copyright (c) 2015 Gregg Mojica. All rights reserved.
//

#import "HomeDetailViewController.h"
#import <EventKit/EventKit.h>

@interface HomeDetailViewController ()
@property (strong, nonatomic) IBOutlet UIVisualEffectView *visual;
@property (strong, nonatomic) IBOutlet UITextView *textField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation HomeDetailViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.titleArray = [NSMutableArray arrayWithObjects: @"Information", @"Schedule", @"Location", nil
                       
                       ];
    

    self.dataArray = [NSMutableArray arrayWithObjects:
                      
                      
                      [NSString stringWithFormat:@"%@", [self.object objectForKey:@"Description"]],
                      
                      [NSString stringWithFormat:@"Schedule: %@", [self.object objectForKey:@"Schedule"]],
                      
                      nil];
    
                      

    
    [self.dataArray addObject:[NSString stringWithFormat:@"Information: %@", [self.object objectForKey:@"Description"]]];
    
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    
    CLLocationCoordinate2D coors = CLLocationCoordinate2DMake(40.712784,-74.0059410);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.03, 0.04 );
    MKCoordinateRegion region = MKCoordinateRegionMake(coors, span);
    
    [self.map setRegion: region animated: YES];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
   //./// [self.dataArray addObject:[NSString stringWithFormat:@"Information: %@", [self.object objectForKey:@"Description"]]];
    
}

-(void)viewDidLayoutSubviews {
    
    self.textField.text = [self.object objectForKey:@"Description"];

    self.textField.transform = CGAffineTransformMakeScale(0.03, 0.03);
    [self animatons];
    

}

-(void)animatons{

    [UIView animateWithDuration:1.3 delay:0
         usingSpringWithDamping:0.3 initialSpringVelocity:0.2
                        options:0 animations:^{
                            
                            self.textField.transform = CGAffineTransformMakeScale(1, 1);
                            
                            
                        } completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [UIView animateWithDuration:2.0 animations:^{
        self.visual.alpha = 0.0;

    } completion:^(BOOL finished) {
        self.visual.alpha = 1.0;

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// MARK - Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:MyIdentifier];
    }
    
    cell.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    [UIView animateWithDuration:1.3 delay:0
         usingSpringWithDamping:0.3 initialSpringVelocity:0.2
                        options:0 animations:^{
                            
                            cell.transform = CGAffineTransformMakeScale(1, 1);
                            
                            
                        } completion:nil];
    
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:22.0];
    
    //[UIFont boldSystemFontOfSize:21.0];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[self.dataArray objectAtIndex:indexPath.row]];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    cell.detailTextLabel.numberOfLines = 15;
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.475 green:0.475 blue:0.475 alpha:1];
    
    cell.backgroundColor = [UIColor colorWithRed:0.941 green:0.941 blue:0.941 alpha:1];
    
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveToCalendar:(id)sender {
    NSLog(@"Save to CAlendar");
    
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        //NSDate *pickerDate = [self.datePicker date];

        
        if (!granted) { return; }
        EKEvent *event = [EKEvent eventWithEventStore:store];
        event.title = [NSString stringWithFormat:@"%@", [self.object objectForKey:@"Title"]];
        event.startDate = [NSDate date]; //today
        event.endDate = [NSDate date];  //set 1 hour meeting
        [event setCalendar:[store defaultCalendarForNewEvents]];
        NSError *err = nil;
        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
        //  NSString *savedEventId = event.eventIdentifier;  //this is so you can access this event later
    }];

}


@end
