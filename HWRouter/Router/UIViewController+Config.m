//
//  UIViewController+Config.m
//  HWRouter
//
//  Created by howe on 2019/8/2.
//  Copyright © 2019 howe All rights reserved.
//

#import "UIViewController+Config.h"
#import <objc/runtime.h>

static const void *kHw_should_destroy_self      = &kHw_should_destroy_self;
static const void *kHw_should_trigger_destroy      = &kHw_should_trigger_destroy;
static const void *kHw_PageName   =&kHw_PageName;


@implementation UIViewController (Config)
- (void)setHw_should_destroy_self:(BOOL)hw_should_destrory_self {
    objc_setAssociatedObject(self, kHw_should_destroy_self, @(hw_should_destrory_self), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hw_should_destroy_self {
    return [objc_getAssociatedObject(self, kHw_should_destroy_self) boolValue];
}

- (void)setHw_should_trigger_destroy:(BOOL)hw_should_trigger_destroy {
    objc_setAssociatedObject(self, kHw_should_trigger_destroy, @(hw_should_trigger_destroy), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hw_should_trigger_destroy {
    return [objc_getAssociatedObject(self, kHw_should_trigger_destroy) boolValue];
}

- (void)setPageName:(NSString *)pageName {
    objc_setAssociatedObject(self, kHw_PageName, pageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)pageName {
    return objc_getAssociatedObject(self, kHw_PageName);
}

- (UINavigationController *)addNavigationController {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    return nav;
}
@end
