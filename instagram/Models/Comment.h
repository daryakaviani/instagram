//
//  Comment.h
//  instagram
//
//  Created by dkaviani on 7/8/20.
//  Copyright © 2020 dkaviani. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Comment : PFObject

@property (nonatomic, strong) NSString  * _Nullable text;
@property (nonatomic, strong) PFFileObject  * _Nullable profile;
@property (nonatomic, strong) NSString  * _Nullable username;

@end

NS_ASSUME_NONNULL_END
