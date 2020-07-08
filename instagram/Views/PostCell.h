//
//  PostCell.h
//  instagram
//
//  Created by dkaviani on 7/6/20.
//  Copyright © 2020 dkaviani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/Parse.h>
#import "PFImageView.h"
NS_ASSUME_NONNULL_BEGIN

@protocol PostCellDelegate;

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *postCaption;
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *postTimestamp;
@property (weak, nonatomic) IBOutlet UILabel *postUsername;
@property (weak, nonatomic) IBOutlet PFImageView *profileView;
@property (strong, nonatomic) Post *post;
@property (nonatomic, weak) id<PostCellDelegate> delegate;


- (void)setPost:(Post *)post;

@end

@protocol PostCellDelegate
- (void)postCell:(PostCell *) postCell didTap: (PFUser *)user;
@end

NS_ASSUME_NONNULL_END
