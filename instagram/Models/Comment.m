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
@dynamic profile;

+ (nonnull NSString *)parseClassName {
    return @"Comment";
}

+ (void) postUserComment: ( UIImage * _Nullable )profile withText: ( NSString * _Nullable )text withUsername: ( NSString * _Nullable ) username withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Comment *newComment = [Comment new];
    newComment.profile = [self getPFFileFromImage:profile];
    newComment.username = [PFUser currentUser].username;
    newComment.text = text;
    [newComment saveInBackgroundWithBlock: completion];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    // check if image is not nil
    if (!image) {
        NSLog(@"Image is nil");
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        NSLog(@"Image data is nil");
        return nil;
    }
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
