//
//  Comment.h
//  instagram
//
//  Created by dkaviani on 7/8/20.
//  Copyright © 2020 dkaviani. All rights reserved.
//

#import <Parse/Parse.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface Comment : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString  * _Nullable text;
@property (nonatomic, strong) NSString  * _Nullable username;
@property (nonatomic, strong) Post  * _Nullable post;


+ (void) postUserComment: ( NSString * _Nullable )text withUsername: ( NSString * _Nullable ) username withPost: ( Post * _Nullable ) post  withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
