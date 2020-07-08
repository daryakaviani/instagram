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
#import <DateTools.h>

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.captionLabel.text = self.post[@"caption"];
    self.postImage.file = self.post[@"image"];
    self.likesLabel.text = [NSString stringWithFormat:@"%@", self.post[@"likeCount"]];
    NSDate *tempTime = self.post.createdAt;
    NSDate *timeAgo = [NSDate dateWithTimeInterval:0 sinceDate:tempTime]; 
    self.timestampLabel.text = timeAgo.timeAgoSinceNow;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
}


@end
