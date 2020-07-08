//
//  ProfileViewController.h
//  instagram
//
//  Created by dkaviani on 7/8/20.
//  Copyright © 2020 dkaviani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (nonatomic, strong) PFObject *post;
@property (nonatomic, strong) PFUser *user;
@end

NS_ASSUME_NONNULL_END
