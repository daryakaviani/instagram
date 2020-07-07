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

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *postCaption;
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (strong, nonatomic) NSDate *postTimestamp;
@property (strong, nonatomic) Post *post;

- (void)setPost:(Post *)post;

@end

NS_ASSUME_NONNULL_END
