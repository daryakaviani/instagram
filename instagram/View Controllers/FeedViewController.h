//
//  FeedViewController.h
//  instagram
//
//  Created by dkaviani on 7/6/20.
//  Copyright © 2020 dkaviani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedViewController : UIViewController
@property (nonatomic, strong) PFObject *post;

@end

NS_ASSUME_NONNULL_END
