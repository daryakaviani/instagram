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
#import "Comment.h"
#import "CommentCell.h"

@interface DetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UITextField *commentField;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSArray *posts;
@property (nonatomic, strong) NSArray *comments;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self fetchComments];
    [self fetchLikes];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchComments) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.captionLabel.text = self.post.caption;
    self.postImage.file = self.post.image;
    NSDate *tempTime = self.post.createdAt;
    NSDate *timeAgo = [NSDate dateWithTimeInterval:0 sinceDate:tempTime]; 
    self.timestampLabel.text = timeAgo.timeAgoSinceNow;
    PFUser *user = self.post[@"author"];
    if (user != nil) {
        // User found! update username label with username
        self.usernameLabel.text = user.username;
    } else {
        // No user found, set default username
        self.usernameLabel.text = @"🤖";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    //cell.delegate = self;
    cell.preservesSuperviewLayoutMargins = false;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    Comment *comment = self.comments[indexPath.row];
    cell.comment = comment;
    [cell setComment:comment];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}


- (IBAction)commentButton:(id)sender {
    [Comment postUserComment:self.commentField.text withUsername:[PFUser currentUser].username withPost:self.post withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        self.commentField.text = @"";
        int val = [self.post.commentCount intValue];
        self.post.commentCount = [NSNumber numberWithInt:(val + 1)];
        [self.post saveInBackground];
        [self fetchComments];
        [self.tableView reloadData];
    }];
}

- (IBAction)likeButton:(id)sender {
    __block bool containsUser = false;
    PFRelation *relation = [self.post relationForKey:@"likedBy"];
    PFQuery *query = [relation query];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        for (PFUser *user in objects) {
            if ([user.username isEqual:[PFUser currentUser].username]) {
                self.likeButton.selected = NO;
                containsUser = true;
                NSLog(@"Found user");
                [Post postUserUnlike:[PFUser currentUser] withPost:self.post withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
                    [self.tableView reloadData];
                }];
            }
            break;
        }
        if (!containsUser) {
            NSLog(@"Did not find user");
            self.likeButton.selected = YES;
            [Post postUserLike:[PFUser currentUser] withPost:self.post withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
                [self.tableView reloadData];
            }];
        }
        self.likesLabel.text = [NSString stringWithFormat:@"%@", self.post.likeCount];
    }];
 }
        
        
- (void)fetchComments {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"post" equalTo:self.post];
    query.limit = 20;
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *comments, NSError *error) {
        if (comments != nil) {
            self.comments = comments;
            self.commentLabel.text = [NSString stringWithFormat:@"%@", self.post.commentCount, nil];
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}
- (void)fetchLikes {
    __block bool containsUser = false;
    PFRelation *relation = [self.post relationForKey:@"likedBy"];
    PFQuery *query = [relation query];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        for (PFUser *user in objects) {
            if ([user.username isEqual:[PFUser currentUser].username]) {
               self.likeButton.selected = YES;
               containsUser = true;
            }
            break;
        }
        if (!containsUser) {
            self.likeButton.selected = NO;
        }
        self.likesLabel.text = [NSString stringWithFormat:@"%@", self.post.likeCount];
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
}


@end
