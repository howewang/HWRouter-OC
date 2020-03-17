//
//  Target_Router.m
//  HWRouter
//
//  Created by howe on 2019/8/5.
//  Copyright © 2019 howe All rights reserved.
//

#import "Target_Router.h"
#import "HWRouterPageRegist.h"
#import "HWRNotFoundViewController.h"
#import "NSObject+SetProperty.h"
#import "HWRouter_KeyDefault.h"
#import "UIViewController+CurrentVC.h"
#import "UIViewController+Config.h"
#import "Target_Action_Error.h"

@interface Target_Router () <UINavigationControllerDelegate>

@end

@implementation Target_Router
static Target_Router *m_router;

+ (Target_Router *)sharedRegist {
    return [[Target_Router alloc] init];
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (m_router == nil) {
            m_router = [super allocWithZone:zone];
        }
    });
    return m_router;
}

-(id)copyWithZone:(NSZone *)zone
{
    return m_router;
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return m_router;
}


- (UIViewController *)Action_ViewController:(NSDictionary *)params {
    Class class = [[HWRouterPageRegist sharedRegist] pageClass:[params valueForKey:kHWRouter_pageName]];
    if (class == nil) {
        //目标页的类没有找到。返回默认的notfound页
        return [[HWRNotFoundViewController alloc] init];
    }
    UIViewController *vc = [[class alloc] init];
    vc.pageName = [params valueForKey:kHWRouter_pageName];
    NSDictionary *vcParams = [params valueForKey:kHWRouter_params];
    if (vcParams.count > 0) {
        [vc setPropertyWithParams: [params valueForKey:kHWRouter_params]];
    }
    return vc;
}

- (void)Action_PushViewController:(NSDictionary *)params{
    if ([params valueForKey:kHWRouter_pageName] == nil) {
        return;
    }
    UIViewController *targetVC = [self Action_ViewController:@{kHWRouter_pageName:[params valueForKey:kHWRouter_pageName],
                                                             kHWRouter_params:[params valueForKey:kHWRouter_params] ? : @{}}];
    UIViewController *currentVC = [UIViewController currentViewController];
    BOOL isDestoryCurrentVC = [[params valueForKey:kHWRouter_destory] boolValue];
    BOOL isAnimation = [[params valueForKey:kHWRouter_animation] boolValue];
    void (^completion)(void) = nil;
    if ([params valueForKey:kHWRouter_completion]) {
        completion = [params valueForKey:kHWRouter_completion];
    }
    currentVC.hw_should_destroy_self = isDestoryCurrentVC;
    if (currentVC.navigationController != nil) {
        if (currentVC.navigationController.delegate == nil) {
            currentVC.navigationController.delegate = m_router;
        }
        currentVC.hidesBottomBarWhenPushed = YES;
        [currentVC.navigationController pushViewController:targetVC animated:isAnimation];
    } else {
        NSLog(@"\nHWMT_Target_Action_Error -----------------\nError Message:%@\nTarget:  %@\nAction:  %@\n------------------",
              @"Push ViewController not have NavigationController",
              @"HWRouter",
              @"PushViewController");
    }
    if (completion != nil) {
        completion();
    }
}

- (void)Action_PresentViewController:(NSDictionary *)params{
    UIViewController *targetVC = [self Action_ViewController:@{kHWRouter_pageName:[params valueForKey:kHWRouter_pageName],
                                                             kHWRouter_params:[params valueForKey:kHWRouter_params]}];
    UIViewController *currentVC = [UIViewController currentViewController];
    BOOL isAnimation = [[params valueForKey:kHWRouter_animation] boolValue];
    void (^completion)(void) = nil;
    if ([params valueForKey:kHWRouter_completion]) {
        completion = [params valueForKey:kHWRouter_completion];
    }
    if (targetVC.navigationController == nil) {
        UINavigationController *nav = [targetVC addNavigationController];
        nav.delegate = self;
        [currentVC presentViewController:nav animated:isAnimation completion:completion];
        return;
    }
    [currentVC presentViewController:targetVC.navigationController animated:isAnimation completion:completion];
}

- (void)Action_PopViewController:(NSDictionary *)params{
    UIViewController *currentVC = [UIViewController currentViewController];
    BOOL isAnimation = [[params valueForKey:kHWRouter_animation] boolValue];
    BOOL isPopRoot = [[params valueForKey:kHWRouter_popPage] boolValue];
    void (^completion)(void) = nil;
    if ([params valueForKey:kHWRouter_completion]) {
        completion = [params valueForKey:kHWRouter_completion];
    }
    if (currentVC.presentingViewController != nil) {
        [currentVC.presentingViewController setPropertyWithParams:[params valueForKey:kHWRouter_params]];
        [currentVC dismissViewControllerAnimated:isAnimation completion:completion];
        return;
    }
    
    //pop
    if (currentVC.navigationController == nil) {
        if (completion != nil) {
            completion();
        }
        return;
    }
    if (currentVC.navigationController.viewControllers.count < 2) {
        if (completion != nil) {
            completion();
        }
        return;
    }
    
    if (isPopRoot == NO) {
        UIViewController *targetVC;
        NSString *pageName = [params valueForKey:kHWRouter_pageName];
        if (pageName == nil) {
            targetVC = [currentVC.navigationController.viewControllers objectAtIndex:currentVC.navigationController.viewControllers.count - 2];
            [targetVC setPropertyWithParams:[params valueForKey:kHWRouter_params]];
            [currentVC.navigationController popViewControllerAnimated:isAnimation];
        }else {
            //            Class targetClass = [[HWMVCPageRegist sharedRegist] pageClass:pageName];
            //            if (targetClass == nil) {
            //                return;
            //            }
            NSMutableArray *vcArray = [NSMutableArray arrayWithArray:currentVC.navigationController.viewControllers];
            for (UIViewController *vc in currentVC.navigationController.viewControllers) {
                if ([vc.pageName isEqualToString:pageName]) {
                    //找到了目标控制器
                    [vc setPropertyWithParams:[params valueForKey:kHWRouter_params]];
                    //把当前控制器和目标控制器之间的控制器删除
                    NSInteger index = [currentVC.navigationController.viewControllers indexOfObject:vc];
                    while (vcArray.count - 1 > index + 1) {
                        [vcArray removeObjectAtIndex:vcArray.count - 2];
                    }
                    currentVC.navigationController.viewControllers = vcArray;
                    [currentVC.navigationController popViewControllerAnimated:isAnimation];
                    if (completion != nil) {
                        completion();
                    }
                    return;
                }
            }
            
            //当前栈中没有目标控制器
            //创建一个控制器，插入栈
            UIViewController *targetVC = [self Action_ViewController:@{kHWRouter_pageName:[params valueForKey:kHWRouter_pageName],
                                                                     kHWRouter_params:[params valueForKey:kHWRouter_params]}];
            [vcArray insertObject:targetVC atIndex:vcArray.count - 1];
            currentVC.navigationController.viewControllers = vcArray;
            [currentVC.navigationController popViewControllerAnimated:isAnimation];
        }
        
    }else {
        [currentVC.navigationController popToRootViewControllerAnimated:isAnimation];
    }
    if (completion != nil) {
        completion();
    }
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //处理跳转是否销毁前控制器
    //category给每个控制器赋值
    NSInteger targetIndex = [navigationController.viewControllers indexOfObject:viewController];
    if (targetIndex == NSNotFound) {
        return;
    }
    NSMutableArray *vcArray = [NSMutableArray arrayWithArray:navigationController.viewControllers];
    for (UIViewController *vc in navigationController.viewControllers) {
        BOOL destory = vc.hw_should_destroy_self;
        if (destory == YES) {
            NSInteger index = [navigationController.viewControllers indexOfObject:vc];
            if (index < targetIndex) {
                [vcArray removeObject:vc];
            }
        }
    }
    if (vcArray.count < 1) {
        return;
    }
    navigationController.viewControllers = vcArray;
}

@end
