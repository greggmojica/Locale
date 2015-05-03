//
//
//  TCD
//
//  Created by Gregg Mojica on 5/2/15.
//  Copyright (c) 2015 Gregg Mojica. All rights reserved.
//

#import "NewRecipeViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface NewRecipeViewController () {
    int i;
    NSString *class;
}

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;


//@property (strong, nonatomic) IBOutlet UITextField *title;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UITextView *tv;


@end

@implementation NewRecipeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.recipeImageView.layer.cornerRadius = self.recipeImageView.frame.size.width / 2;
    self.recipeImageView.clipsToBounds = YES;
    
    self.eventDescription.layer.cornerRadius = 8;
    self.eventDescription.clipsToBounds = YES;


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self showPhotoLibary];
    }
}


- (void)showPhotoLibary
{
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)) {
        return;
    }
    
    UIImagePickerController *media = [[UIImagePickerController alloc] init];
    media.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    media.mediaTypes = @[(NSString*)kUTTypeImage];
    
    media.allowsEditing = NO;
    media.delegate = self;
    
    [self.navigationController presentViewController:media animated:YES completion:nil];
     
}

- (IBAction)save:(id)sender {

    
    PFObject *object = [PFObject objectWithClassName:@"Events"];
    [object setObject:self.eventTitle.text forKey:@"Title"];
   // [object setObject:self.eventLocation.text forKey:@"Location"];
    [object setObject:self.eventDescription.text forKey:@"Description"];

    NSData *imageData = UIImageJPEGRepresentation(self.recipeImageView.image, 0.8);
    NSString *filename = [NSString stringWithFormat:@"image.png"];
    PFFile *imageFile = [PFFile fileWithName:filename data:imageData];
    [object setObject:imageFile forKey:@"imageFile"];
    

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Uploading";
    [hud show:YES];

    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [hud hide:YES];
        
        if (!error) {
            // Show success message
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Complete" message:@"Added to the Database" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
            
            //[self dismissViewControllerAnimated:YES completion:nil];
            [self.navigationController popViewControllerAnimated:YES];

        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Failure" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];

        }
        
    }];
}

- (IBAction)cd:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidUnload {
    [super viewDidUnload];

    [self setRecipeImageView:nil];
}


- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    UIImage *originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    self.recipeImageView.image = originalImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
