//
//  PostCell.m
//  instagram
//
//  Created by dkaviani on 7/6/20.
//  Copyright © 2020 dkaviani. All rights reserved.
//

#import "PostCell.h"
#import "Post.h"
#import <DateTools.h>

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
     UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profileView addGestureRecognizer:profileTapGestureRecognizer];
    [self.profileView setUserInteractionEnabled:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    self.postCaption.text = post[@"caption"];
    self.postImage.file = post[@"image"];
    NSDate *tempTime = self.post.createdAt;
    NSDate *timeAgo = [NSDate dateWithTimeInterval:0 sinceDate:tempTime];
    self.postTimestamp.text = timeAgo.timeAgoSinceNow;
    [self.postImage loadInBackground];
}


// ADDING DIRECT TO USER PROFILE FEATURE
- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    [self.delegate postCell:self didTap:self.post.author];
}

@end
