//
//  DetailViewController.m
//  instagram
//
//  Created by dkaviani on 7/7/20.
//  Copyright © 2020 dkaviani. All rights reserved.
//

#import "DetailViewController.h"
#import <Parse/Parse.h>
#import "PFImageView.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.captionLabel.text = self.post[@"caption"];
    self.postImage.file = self.post[@"image"];
    [self.postImage loadInBackground];
    NSDate *createdAtOriginalString = self.post[@"createdAt"];
    // Format createdAt date string
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    // Convert String to Date
    NSDate *date = [formatter dateFromString:createdAtOriginalString];
    // Configure output format
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    // Convert Date to String
    self.timestampLabel.text = [formatter stringFromDate:date];
    //self.timeCreated = [createdAtOriginalString substringWithRange:NSMakeRange(10, 9)];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
}


@end
