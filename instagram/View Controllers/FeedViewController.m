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
#import "InfiniteScrollActivityView.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"

@interface FeedViewController ()<UITableViewDelegate, UITableViewDataSource, PostCellDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *posts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (strong, nonatomic) PFUser* user;

@end

@implementation FeedViewController
bool isMoreDataLoading = false;
InfiniteScrollActivityView* loadingMoreView;
int skip = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self fetchPosts];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    // Set up Infinite Scroll loading indicator
    CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
    loadingMoreView = [[InfiniteScrollActivityView alloc] initWithFrame:frame];
    loadingMoreView.hidden = true;
    [self.tableView addSubview:loadingMoreView];
    
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom += InfiniteScrollActivityView.defaultHeight;
    self.tableView.contentInset = insets;
}

- (IBAction)logoutButton:(id)sender {
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;

    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        PFUser *test = [PFUser currentUser];
        
        NSLog(@" -- User is logged out -- %@", test.username);
    }];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    myDelegate.window.rootViewController = loginViewController;
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

-(void)loadMoreData{
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20;
    query.skip = skip;
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            NSMutableArray *newPosts = (NSMutableArray *) posts;
            NSArray *newArray = [self.posts arrayByAddingObjectsFromArray:newPosts];
            self.posts = (NSMutableArray *) newArray;
            skip += posts.count;
            isMoreDataLoading = false;
            [loadingMoreView stopAnimating];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.tableView reloadData];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     if(!isMoreDataLoading){
         // Calculate the position of one screen length before the bottom of the results
         int scrollViewContentHeight = self.tableView.contentSize.height;
         int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
         
         // When the user has scrolled past the threshold, start requesting
         if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
             isMoreDataLoading = true;
             
             // Update position of loadingMoreView, and start loading indicator
             CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
             loadingMoreView.frame = frame;
             
             // Code to load more results
             bool isAtLeast20 = self.posts.count >= 20;
             if (isAtLeast20) {
                 [loadingMoreView startAnimating];
                 [self loadMoreData];
             }
         }
     }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
      if ([segue.identifier isEqualToString:@"detailSegue"]) {
          Post *post = self.posts[indexPath.row];
          DetailViewController *detailViewController = [segue destinationViewController];
          detailViewController.post = post;
      } else if ([segue.identifier isEqualToString:@"profileSegue"]) {
          ProfileViewController *profileViewController = [segue destinationViewController];
          profileViewController.user = self.user;
      }
}


@end
