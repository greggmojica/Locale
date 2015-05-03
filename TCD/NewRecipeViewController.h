//
//
//  TCD
//
//  Created by Gregg Mojica on 5/2/15.
//  Copyright (c) 2015 Gregg Mojica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface NewRecipeViewController : UITableViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSArray *colorArray;
@property (strong, nonatomic) IBOutlet UITextField *eventTitle;
@property (strong, nonatomic) IBOutlet UITextField *eventLocation;
@property (strong, nonatomic) IBOutlet UITextView *eventDescription;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;


@end
