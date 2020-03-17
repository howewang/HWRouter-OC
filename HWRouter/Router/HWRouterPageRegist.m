//
//  HWRouterPageRegist.m
//  HWRouter
//
//  Created by howe on 2019/7/31.
//  Copyright © 2019 howe All rights reserved.
//

#import "HWRouterPageRegist.h"



@implementation HWMPageModel

+ (HWMPageModel *)page:(NSString *)pageName class:(NSString *)className {
    HWMPageModel *model = [[HWMPageModel alloc] init];
    model.pageName = pageName;
    model.pageClassName = className;
    return model;
}
@end

@interface HWRouterPageRegist ()
@property (nonatomic , strong) NSMutableDictionary *pageDataDic;
@end

@implementation HWRouterPageRegist
static HWRouterPageRegist *m_pageRegist;

+ (HWRouterPageRegist *)sharedRegist {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m_pageRegist = [[HWRouterPageRegist alloc] init];
    });
    return m_pageRegist;
}

-(id)copyWithZone:(NSZone *)zone
{
    return m_pageRegist;
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return m_pageRegist;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _pageDataDic = [NSMutableDictionary dictionaryWithCapacity:1];
        if ([self respondsToSelector:@selector(registPages)] == YES) {
            [self performSelector:NSSelectorFromString(@"registPages")];
        }
    }
    return self;
}

- (void)addPage:(NSString *)pageName
  pageClassName:(NSString *)pageClassName {
    [self.pageDataDic setObject:[HWMPageModel page:pageName
                                             class:pageClassName]
                         forKey:pageName];
}

- (Class)pageClass:(NSString *)pageName {
    HWMPageModel *model = [self.pageDataDic objectForKey:pageName];
    if (model == nil) {
        return nil;
    }
    return NSClassFromString(model.pageClassName);
}

- (NSString *)pageClassName:(NSString *)pageName {
    HWMPageModel *model = [self.pageDataDic objectForKey:pageName];
    if (model == nil) {
        return nil;
    }
    return model.pageClassName;
}

- (NSString *)pageName:(NSString *)pageClass {
    for (HWMPageModel *model in self.pageDataDic.allValues) {
        if ([model.pageClassName isEqualToString:pageClass]) {
            return model.pageName;
        }
    }
    return nil;
}

- (HWMPageModel *)page:(NSString *)pageName {
    return [self.pageDataDic objectForKey:pageName];
}

@end
