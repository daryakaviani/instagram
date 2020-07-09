//  Post.h
#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString * _Nullable postID;
@property (nonatomic, strong) NSString * _Nullable userID;
@property (nonatomic, strong) PFUser  * _Nullable author;

@property (nonatomic, strong) NSString  * _Nullable caption;
@property (nonatomic, strong) PFFileObject  * _Nullable image;
@property (nonatomic, strong) NSNumber  * _Nullable likeCount;
@property (nonatomic, strong) NSNumber  * _Nullable commentCount;

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;
+ (void) postUserLike: ( PFUser * _Nullable)user withPost: ( Post * _Nullable ) post withCompletion: (PFBooleanResultBlock  _Nullable)completion;
+ (void) postUserUnlike: ( PFUser * _Nullable)user withPost: ( Post * _Nullable ) post withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end
