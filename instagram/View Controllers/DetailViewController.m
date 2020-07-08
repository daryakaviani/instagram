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
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

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
    PFUser *user = self.post[@"author"];
    if (self.post.liked) {
            self.post.liked = NO;
    //        self.post.likeCount = @(self.post.likeCount + 1);
        } else {
            self.post.liked = YES;
    //        self.post.likeCount += 1;
        }
    if (user != nil) {
        // User found! update username label with username
        self.usernameLabel.text = user.username;
    } else {
        // No user found, set default username
        self.usernameLabel.text = @"🤖";
    }
}

- (IBAction)likeButton:(id)sender {
    if (self.post.liked) {
        self.post.liked = NO;
        self.likeButton.selected = YES;
//        self.post.likeCount.integerValue -= 1;
    } else {
        self.post.liked = YES;
        self.likeButton.selected = NO;
//        self.post.likeCount.integerValue += 1;
    }
    [self refreshLikeData];
}

- (void)refreshLikeData {
//    self.likesLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
//    if (self.tweet.favorited) {
//        self.favorButton.selected = YES;
//        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
//            if(error){
//                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
//            }
//            else{
//                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
//            }
//        }];
//    } else {
//        self.favorButton.selected = NO;
//        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
//            if(error){
//                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
//            }
//            else{
//                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
//            }
//        }];
//    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
}


@end
