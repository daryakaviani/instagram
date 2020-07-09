//
//  CommentCell.m
//  instagram
//
//  Created by dkaviani on 7/8/20.
//  Copyright © 2020 dkaviani. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setComment:(Comment *)comment {
    _comment = comment;
    self.commentUsername.text = comment[@"username"];
    self.commentText.text = comment[@"text"];
}

@end
