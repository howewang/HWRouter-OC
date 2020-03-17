//
//  HWMT_DeepLink.m
//  HWRouter
//
//  Created by howe on 2019/8/5.
//  Copyright © 2019 howe All rights reserved.
//

#import "HWMT_DeepLink.h"
#import "CTMediator+HWRouter.h"
#import "HWRouter_KeyDefault.h"

@implementation HWMT_DeepLink
- (void)HWMA_DeepLinkRouter:(NSDictionary *)params {
    [[CTMediator sharedInstance] HWRouter_PushViewController:[params valueForKey:kHWRouter_pageName]
                                                  params:[params valueForKey:kHWRouter_params]
                                             completion:^{
                                                 void (^com)(NSDictionary *) = [params valueForKey:kHWRouter_completion];
                                                 if (com != nil) {
                                                     com(@{});
                                                 }
                                             }];
}
@end
