//
//  CTMediator+HWRouter.m
//  HWRouter
//
//  Created by Howe on 2020/3/17.
//  Copyright © 2020 howe. All rights reserved.
//

#import "CTMediator+HWRouter.h"
#import "HWRouter_KeyDefault.h"

@implementation CTMediator (HWRouter)

//获取目标控制器
- (UIViewController *)HWRouter_ViewController:(NSString *)pageName {
    return [self HWRouter_ViewController:pageName
                             params:@{}];
}
- (UIViewController *)HWRouter_ViewController:(NSString *)pageName
                                  params:(NSDictionary *)params{
    return [self performTarget:kHWRouter_Target
                        action:kHWRouter_Action_ViewController
                        params:@{kHWRouter_pageName: pageName,
                                 kHWRouter_params: params ? : @{}
                                 }
             shouldCacheTarget:NO];
}

//push 到目标控制器
- (void)HWRouter_PushViewController:(NSString *)pageName
                    completion:(void(^)(void))completion{
    [self HWRouter_PushViewController:pageName
                          params:@{}
                         destory:NO
                       animation:YES
                      completion:completion];
}

- (void)HWRouter_PushViewController:(NSString *)pageName
                        params:(NSDictionary *)params
                    completion:(void(^)(void))completion{
    [self HWRouter_PushViewController:pageName
                          params:params
                         destory:NO
                       animation:YES
                      completion:completion];
}

- (void)HWRouter_PushViewController:(NSString *)pageName
                        params:(NSDictionary *)params
                       destory:(BOOL)destory
                    completion:(void(^)(void))completion{
    [self HWRouter_PushViewController:pageName
                          params:params
                         destory:destory
                       animation:YES
                      completion:completion];
}

- (void)HWRouter_PushViewController:(NSString *)pageName
                        params:(NSDictionary *)params
                       destory:(BOOL)destory
                     animation:(BOOL)animation
                    completion:(void(^)(void))completion{
    [self performTarget:kHWRouter_Target
                        action:kHWRouter_Action_PushViewController
                        params:@{kHWRouter_pageName: pageName,
                                 kHWRouter_params: params ? : @{},
                                 kHWRouter_destory: @(destory),
                                 kHWRouter_animation: @(animation),
                                 kHWRouter_completion: completion
                                 }
             shouldCacheTarget:NO];
}

//present
- (void)HWRouter_PresentViewController:(NSString *)pageName
                        animation:(BOOL)animation
                       completion:(void(^)(void))completion {
    [self HWRouter_PresentViewController:pageName
                             params:@{}
                          animation:animation
                         completion:completion];
}

- (void)HWRouter_PresentViewController:(NSString *)pageName
                           params:(NSDictionary *)params
                       completion:(void(^)(void))completion{
    [self HWRouter_PresentViewController:pageName
                             params:params
                          animation:YES
                         completion:completion];
}

- (void)HWRouter_PresentViewController:(NSString *)pageName
                           params:(NSDictionary *)params
                        animation:(BOOL)animation
                       completion:(void(^)(void))completion{
    [self performTarget:kHWRouter_Target
                 action:kHWRouter_Action_PresentViewController
                 params:@{kHWRouter_pageName: pageName,
                          kHWRouter_params: params ? : @{},
                          kHWRouter_animation: @(animation),
                          kHWRouter_completion: completion
                          }
      shouldCacheTarget:NO];
}

//pop

- (void)HWRouter_PopViewController:(void(^)(void))completion{
    [self HWRouter_PopViewController:nil
                         params:nil
                      isPopRoot:NO
                      animation:YES
                     completion:completion];
}

- (void)HWRouter_PopViewController:(BOOL)animation
                   completion:(void(^)(void))completion{
    [self HWRouter_PopViewController:nil
                         params:nil
                      isPopRoot:NO
                      animation:animation
                     completion:completion];
}

- (void)HWRouter_PopRootViewController:(BOOL)animation
                       completion:(void(^)(void))completion {
    [self HWRouter_PopViewController:nil
                         params:nil
                      isPopRoot:YES
                      animation:animation
                     completion:completion];
}

- (void)HWRouter_PopViewController:(nullable NSString *)pageName
                    animation:(BOOL)animation
                   completion:(void(^)(void))completion{
    [self HWRouter_PopViewController:pageName
                         params:nil
                      isPopRoot:NO
                      animation:animation
                     completion:completion];
}

- (void)HWRouter_PopViewController:(nullable NSString *)pageName
                       params:(nullable NSDictionary *)params
                    animation:(BOOL)animation
                   completion:(void(^)(void))completion{
    [self HWRouter_PopViewController:pageName
                         params:params
                      isPopRoot:NO
                      animation:animation
                     completion:completion];
}

- (void)HWRouter_PopViewController:(nullable NSString *)pageName
                       params:(NSDictionary *)params
                    isPopRoot:(BOOL)isPopRoot
                    animation:(BOOL)animation
                   completion:(void(^)(void))completion {
    NSMutableDictionary *popParams = [NSMutableDictionary dictionaryWithCapacity:1];
    if (pageName != nil) {
        [popParams setObject:pageName forKey:kHWRouter_pageName];
    }
    [popParams setObject:@(animation) forKey:kHWRouter_animation];
    [popParams setObject:params ? : @{} forKey:kHWRouter_params];
    [popParams setObject:completion forKey:kHWRouter_completion];
    [popParams setObject:@(isPopRoot) forKey:kHWRouter_popPage];
    [self performTarget:kHWRouter_Target
                 action:kHWRouter_Action_PopViewController
                 params:popParams
      shouldCacheTarget:NO];
}
@end
