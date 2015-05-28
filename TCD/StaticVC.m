//
//  ViewController.m
//  UITableViewDemo
//
//  Created by Gregg Mojica on 3/4/13.
//  Copyright (c) 2013 Gregg Mojica. All rights reserved.
//

#import "StaticVC.h"
#import "RecipeBookViewController.h"

@interface StaticVC ()

@property (nonatomic,strong) NSArray *data;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) NSString *type;

@end

@implementation StaticVC
static NSString *cellIdentifier;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
  //  UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    //[tempImageView setFrame:self.myTableView.frame];
    
    //self.myTableView.backgroundView = tempImageView;
    

    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    self.data = @[@"EA",@"ELM",@"WILL", @"HAM", @"WS", @"SB", @"FA", @"PREM", @"GUER", @"LOU", @"OTHER", @"OTHER2"];
    
    cellIdentifier = @"rowCell";
    
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
    cell.textLabel.font= [UIFont boldSystemFontOfSize:18.0];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        self.type = @"EA";
        [self performSegueWithIdentifier:@"showCollection" sender:self];
    }
   
    if (indexPath.row == 1) {
        self.type = @"ELM";

        [self performSegueWithIdentifier:@"showCollection" sender:self];
    }
    
    if (indexPath.row == 2) {
        self.type = @"WILL";

        [self performSegueWithIdentifier:@"showCollection" sender:self];
    }
    
    if (indexPath.row == 3) {
        self.type = @"HAM";

        [self performSegueWithIdentifier:@"showCollection" sender:self];
    }
    
    if (indexPath.row == 4) {
        self.type = @"WS";

        [self performSegueWithIdentifier:@"showCollection" sender:self];
    }
    
    
    if (indexPath.row == 5) {
        self.type = @"SB";
        
        [self performSegueWithIdentifier:@"showCollection" sender:self];
    }
    
    
    if (indexPath.row == 6) {
        self.type = @"FA";
        
        [self performSegueWithIdentifier:@"showCollection" sender:self];
    }
    
    if (indexPath.row == 7) {
        self.type = @"PREM";
        
        [self performSegueWithIdentifier:@"showCollection" sender:self];
    }
    
    if (indexPath.row == 8) {
        self.type = @"GUER";
        
        [self performSegueWithIdentifier:@"showCollection" sender:self];
    }

    if (indexPath.row == 9) {
        self.type = @"LOU";
        
        [self performSegueWithIdentifier:@"showCollection" sender:self];
    }
    
    if (indexPath.row == 10) {
        self.type = @"OTHER";
        
        [self performSegueWithIdentifier:@"showCollection" sender:self];
    }
 
    if (indexPath.row == 11) {
        self.type = @"OTHER2";
        
        [self performSegueWithIdentifier:@"showCollection" sender:self];
    }
    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showCollection"]) {
        
        RecipeBookViewController *destViewController = segue.destinationViewController;
        destViewController.type = self.type;
        
    }
}



@end
