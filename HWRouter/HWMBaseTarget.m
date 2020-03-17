//
//  HWMBaseTarget.m
//  HWRouter
//
//  Created by Howe on 2020/3/15.
//  Copyright © 2020 yuanxl. All rights reserved.
//

#import "HWMBaseTarget.h"

@implementation HWMBaseTarget
- (void)notFoundAction:(NSDictionary *)errorInfo {
    NSLog(@"\nHWMT Error: Action not found Params: %@", errorInfo);
}
@end
