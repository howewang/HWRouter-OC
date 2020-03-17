//
//  HWRouter_KeyDefault.h
//  HWRouter
//
//  Created by Howe on 2020/3/17.
//  Copyright © 2020 howe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//mediator
FOUNDATION_EXPORT NSString * const kCTMediator_Target;
FOUNDATION_EXPORT NSString * const kCTMediator_Action;
FOUNDATION_EXPORT NSString * const kCTMediator_Error_Target;
FOUNDATION_EXPORT NSString * const kCTMediator_Error_Action;

//error key
FOUNDATION_EXPORT NSString * const kCTMediator_Action_Error_Message;
FOUNDATION_EXPORT NSString * const kCTMediator_Action_Error_Target;
FOUNDATION_EXPORT NSString * const kCTMediator_Action_Error_Action;
FOUNDATION_EXPORT NSString * const kCTMediator_Action_Error_Action_NotFound;
FOUNDATION_EXPORT NSString * const kCTMediator_Action_Error_Target_NotFound;


//target key
FOUNDATION_EXPORT NSString * const kHWRouter_Target;
//action key
FOUNDATION_EXPORT NSString * const kHWRouter_Action_ViewController;
FOUNDATION_EXPORT NSString * const kHWRouter_Action_PushViewController;
FOUNDATION_EXPORT NSString * const kHWRouter_Action_PresentViewController;
FOUNDATION_EXPORT NSString * const kHWRouter_Action_PopViewController;
//params key
FOUNDATION_EXPORT NSString * const kHWRouter_pageName;
FOUNDATION_EXPORT NSString * const kHWRouter_pageClassName;
FOUNDATION_EXPORT NSString * const kHWRouter_params;
FOUNDATION_EXPORT NSString * const kHWRouter_destory;
FOUNDATION_EXPORT NSString * const kHWRouter_animation;
FOUNDATION_EXPORT NSString * const kHWRouter_popPage;
FOUNDATION_EXPORT NSString * const kHWRouter_completion;

//deeplink
FOUNDATION_EXPORT NSString * const kHWMDeepLink_Target;
FOUNDATION_EXPORT NSString * const kHWMDeeplink_Action;

NS_ASSUME_NONNULL_END
