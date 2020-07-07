//
//  PostCell.m
//  instagram
//
//  Created by dkaviani on 7/6/20.
//  Copyright © 2020 dkaviani. All rights reserved.
//

#import "PostCell.h"
#import "Post.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    self.postCaption.text = post[@"caption"];
    self.postImage.file = post[@"image"];
    self.postTimestamp = post[@"createdAt"];
    [self.postImage loadInBackground];
}

@end
