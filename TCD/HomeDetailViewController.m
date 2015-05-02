//
//  HomeDetailViewController.m
//  TCD
//
//  Created by Gregg Mojica on 5/2/15.
//  Copyright (c) 2015 Gregg Mojica. All rights reserved.
//

#import "HomeDetailViewController.h"

@interface HomeDetailViewController ()
@property (strong, nonatomic) IBOutlet UIVisualEffectView *visual;
@property (strong, nonatomic) IBOutlet UITextView *textField;

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CLLocationCoordinate2D coors = CLLocationCoordinate2DMake(40.712784,-74.0059410);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.2, 0.2 );
    MKCoordinateRegion region = MKCoordinateRegionMake(coors, span);
    
    [self.map setRegion: region animated: YES];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews {
    
    self.textField.text = [self.object objectForKey:@"Description"];

    self.textField.transform = CGAffineTransformMakeScale(0.3, 0.3);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
