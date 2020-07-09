//
//  ComposeViewController.m
//  instagram
//
//  Created by dkaviani on 7/6/20.
//  Copyright © 2020 dkaviani. All rights reserved.
//

#import "ComposeViewController.h"
#import <UIKit/UIKit.h>
#import "Post.h"
#import "MBProgressHUD.h"
#import "PhotoViewController.h"

@interface ComposeViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *captionField;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openImagePicker)];
    [self.pickerView addGestureRecognizer:profileTapGestureRecognizer];
    [self.pickerView setUserInteractionEnabled:YES];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(setImage:) name:@"selectedImage" object:nil];
}

- (IBAction)shareButton:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
    hud.animationType = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"Posting Your Photo to Instragam";
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [Post postUserImage:self.pickerView.image withCaption:self.captionField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            [self dismissViewControllerAnimated:true completion:nil];
        }];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)openImagePicker {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self performSegueWithIdentifier:@"photoSegue" sender:nil];
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void) setImage:(NSNotification *) notification {
    NSDictionary *dict = notification.userInfo;
    self.selectedView = [dict valueForKey:@"image"];
    UIImage *originalImage = self.selectedView.image;
    UIImage *editedImage = [self resizeImage:originalImage withSize:CGSizeMake(1, 1)];
    [self.pickerView setImage:editedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage;
    if (self.selectedView != nil) {
        originalImage = self.selectedView.image;
    } else {
        originalImage = info[UIImagePickerControllerOriginalImage];
    }
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = [self resizeImage:originalImage withSize:CGSizeMake(50, 50)];
    
    [self.pickerView setImage:editedImage];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
