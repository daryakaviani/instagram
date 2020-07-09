//
//  Comment.m
//  instagram
//
//  Created by dkaviani on 7/8/20.
//  Copyright © 2020 dkaviani. All rights reserved.
//

#import "Comment.h"

@implementation Comment

@dynamic username;
@dynamic text;
@dynamic post;

+ (nonnull NSString *)parseClassName {
    return @"Comment";
}

+ (void) postUserComment: ( NSString * _Nullable )text withUsername: ( NSString * _Nullable ) username withPost: ( Post * _Nullable ) post  withCompletion: (PFBooleanResultBlock  _Nullable)completion{
    
    Comment *newComment = [Comment new];
    newComment.username = [PFUser currentUser].username;
    newComment.text = text;
    newComment.post = post;
    [newComment saveInBackgroundWithBlock: completion];
}

@end
