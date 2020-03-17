//
//  CTMediator+HWRouter.h
//  HWRouter
//
//  Created by Howe on 2020/3/17.
//  Copyright © 2020 howe. All rights reserved.
//


#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (HWRouter)
//获取目标控制器
- (UIViewController *)HWRouter_ViewController:(NSString *)pageName;
- (UIViewController *)HWRouter_ViewController:(NSString *)pageName
                                  params:(nullable NSDictionary *)params;

//push 到目标控制器
- (void)HWRouter_PushViewController:(nullable NSString *)pageName
                    completion:(void(^)(void))completion;

- (void)HWRouter_PushViewController:(NSString *)pageName
                        params:(nullable NSDictionary *)params
                    completion:(void(^)(void))completion;

- (void)HWRouter_PushViewController:(NSString *)pageName
                        params:(nullable NSDictionary *)params
                       destory:(BOOL)destory
                    completion:(void(^)(void))completion;

- (void)HWRouter_PushViewController:(NSString *)pageName
                        params:(nullable NSDictionary *)params
                       destory:(BOOL)destory
                     animation:(BOOL)animation
                    completion:(void(^)(void))completion;

//present
- (void)HWRouter_PresentViewController:(NSString *)pageName
                        animation:(BOOL)animation
                       completion:(void(^)(void))completion;

- (void)HWRouter_PresentViewController:(NSString *)pageName
                           params:(nullable NSDictionary *)params
                       completion:(void(^)(void))completion;

- (void)HWRouter_PresentViewController:(NSString *)pageName
                           params:(nullable NSDictionary *)params
                        animation:(BOOL)animation
                       completion:(void(^)(void))completion;

//pop
- (void)HWRouter_PopViewController:(void(^)(void))completion;

- (void)HWRouter_PopViewController:(BOOL)animation
                   completion:(void(^)(void))completion;

- (void)HWRouter_PopRootViewController:(BOOL)animation
                       completion:(void(^)(void))completion;

- (void)HWRouter_PopViewController:(nullable NSString *)pageName
                    animation:(BOOL)animation
                   completion:(void(^)(void))completion;

- (void)HWRouter_PopViewController:(nullable NSString *)pageName
                       params:(nullable NSDictionary *)params
                    animation:(BOOL)animation
                   completion:(void(^)(void))completion;

- (void)HWRouter_PopViewController:(nullable NSString *)pageName
                       params:(nullable NSDictionary *)params
                    isPopRoot:(BOOL)isPopRoot
                    animation:(BOOL)animation
                   completion:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
