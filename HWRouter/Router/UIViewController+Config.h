//
//  UIViewController+Config.h
//  HWRouter
//
//  Created by howe on 2019/8/2.
//  Copyright © 2019 howe All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Config)
@property (nonatomic , assign) BOOL hw_should_destroy_self;
@property (nonatomic , assign) BOOL hw_should_trigger_destroy;
@property (nonatomic , copy) NSString *pageName;
- (UINavigationController *)addNavigationController;
@end

NS_ASSUME_NONNULL_END
