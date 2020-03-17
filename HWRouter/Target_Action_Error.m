//
//  Target_Action_Error.m
//  HWRouter
//
//  Created by howe on 2019/8/1.
//  Copyright © 2019 howe All rights reserved.
//

#import "Target_Action_Error.h"
#import "HWRouter_KeyDefault.h"
@implementation Target_Action_Error
- (void)Action_Error:(NSDictionary *)error {
    NSLog(@"\nHWMT_Target_Action_Error -----------------\nError Message:%@\nTarget:  %@\nAction:  %@\n------------------",
          [error valueForKey:kCTMediator_Action_Error_Message],
          [error valueForKey:kCTMediator_Action_Error_Target],
          [error valueForKey:kCTMediator_Action_Error_Action]);
}
@end
