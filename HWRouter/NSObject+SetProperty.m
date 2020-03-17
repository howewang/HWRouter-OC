//
//  NSObject+SetProperty.m
//  HWRouter
//
//  Created by howe on 2019/7/31.
//  Copyright © howe All rights reserved.
//

#import "NSObject+SetProperty.h"
#import <objc/runtime.h>
@implementation NSObject (SetProperty)
- (void)setPropertyWithParams:(NSDictionary *)params {
    unsigned int count = 0;
    //获取类的属性列表
    Ivar *ivars = class_copyIvarList([self class], &count);
    //给属性赋值
    for (int i = 0; i<count; i++)
    {
        Ivar ivar = ivars[i];
        //获取变量名称
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        //生成setter方法
        NSString *usefullStr = [key substringFromIndex:1];          //跳过下划线
//        key = usefullStr.capitalizedString;                         //大写首字母
        NSMutableString *result = [usefullStr mutableCopy];
        [result enumerateSubstringsInRange:NSMakeRange(0, [result length])
                                   options:NSStringEnumerationByWords
                                usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                    [result replaceCharactersInRange:NSMakeRange(substringRange.location, 1)
                                                          withString:[[substring substringToIndex:1] uppercaseString]];
                                }];
        key = result;
        key = [NSString stringWithFormat:@"set%@:", key];           //拼接set方法字符串
        SEL setSel = NSSelectorFromString(key);
        //调用setter方法
        if ([self respondsToSelector:setSel])
        {
            id value = @"";
            if ([params objectForKey:usefullStr]!=nil) {
                value = [params objectForKey:usefullStr];
            }
//            if ([[value class] isKindOfClass:[NSObject class]]) {
                    //找个方法无法给基础类型赋值
//                [self performSelectorOnMainThread:setSel withObject:value waitUntilDone:[NSThread isMainThread]];
//            }else {
                [self setValue:value forKey:usefullStr];
//            }
            
        }
    }
    free(ivars);
}

@end
