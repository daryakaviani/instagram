//  Post.m
#import "Post.h"
#import <Parse/Parse.h>

@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    [newPost saveInBackgroundWithBlock: completion];
}

+ (void) postUserLike: ( PFUser * _Nullable)user withPost: ( Post * _Nullable ) post withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    PFRelation *relation = [post relationForKey:@"likedBy"];
    [relation addObject:user];
    int val = [post.likeCount intValue];
    post.likeCount = [NSNumber numberWithInt:(val + 1)];
    [post saveInBackground];
}

+ (void) postUserUnlike: ( PFUser * _Nullable)user withPost: ( Post * _Nullable ) post withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    PFRelation *relation = [post relationForKey:@"likedBy"];
    [relation removeObject:user];
    int val = [post.likeCount intValue];
    post.likeCount = [NSNumber numberWithInt:(val - 1)];
    [post saveInBackground];
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
