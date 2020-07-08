//
//  FeedViewController.m
//  instagram
//
//  Created by dkaviani on 7/6/20.
//  Copyright © 2020 dkaviani. All rights reserved.
//

#import "FeedViewController.h"
#import <Parse/Parse.h>
#import "PostCell.h"
#import "DetailViewController.h"
#import "PFImageView.h"
#import "ProfileViewController.h"

@interface FeedViewController ()<UITableViewDelegate, UITableViewDataSource, PostCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *posts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (strong, nonatomic) PFUser* user;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self fetchPosts];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (IBAction)logoutButton:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)fetchPosts {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = posts;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    cell.delegate = self;
    cell.preservesSuperviewLayoutMargins = false;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    Post *post = self.posts[indexPath.row];
    cell.post = post;
    [cell setPost:post];
    PFUser *user = post[@"author"];
    if (user != nil) {
        // User found! update username label with username
        cell.postUsername.text = user.username;
    } else {
        // No user found, set default username
        cell.postUsername.text = @"🤖";
    }
    if (user[@"profilePic"] != nil) {
        cell.profileView.file = user[@"profilePic"];
        [cell.profileView loadInBackground];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (void)postCell:(PostCell *)postCell didTap:(PFUser *)user{
    self.user = user;
    [self performSegueWithIdentifier:@"profileSegue" sender:user];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    Post *post = self.posts[indexPath.row];
      if ([segue.identifier isEqualToString:@"detailSegue"]) {
          DetailViewController *detailViewController = [segue destinationViewController];
          detailViewController.post = post;
      } else if ([segue.identifier isEqualToString:@"profileSegue"]) {
          ProfileViewController *profileViewController = [segue destinationViewController];
          profileViewController.user = self.user;
      }
}


@end
