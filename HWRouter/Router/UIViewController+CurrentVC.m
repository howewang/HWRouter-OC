//
//  UIViewController+CurrentVC.m
//  HWRouter
//
//  Created by howe on 2019/8/1.
//  Copyright © 2019 howe All rights reserved.
//

#import "UIViewController+CurrentVC.h"

@implementation UIViewController (CurrentVC)



+ (UIViewController *)findBestViewController:(UIViewController *)vc{
    if (vc.presentedViewController) {
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *)vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController *)vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController *)vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}

+ (UIViewController *)currentViewController{
    UIViewController *viewController = [UIApplication sharedApplication].windows.firstObject.rootViewController;
    return [UIViewController findBestViewController:viewController];
}
@end
