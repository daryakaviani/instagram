//
//  DetailViewController.h
//  instagram
//
//  Created by dkaviani on 7/7/20.
//  Copyright © 2020 dkaviani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "Comment.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (nonatomic, strong) Post *post;
@property (nonatomic, strong) Comment *comment;

@end

NS_ASSUME_NONNULL_END
