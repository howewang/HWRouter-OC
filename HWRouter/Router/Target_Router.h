//
//  Target_Router.h
//  HWRouter
//
//  Created by howe on 2019/8/5.
//  Copyright © 2019 howe All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface Target_Router : NSObject
- (UIViewController *)Action_ViewController:(NSDictionary *)params;

- (void)Action_PushViewController:(NSDictionary *)params;

- (void)Action_PresentViewController:(NSDictionary *)params;

- (void)Action_PopViewController:(NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
