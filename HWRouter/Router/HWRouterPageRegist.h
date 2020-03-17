//
//  HWRouterPageRegist.h
//  HWRouter
//
//  Created by howe on 2019/7/31.
//  Copyright © 2019 howe All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWMPageModel : NSObject
@property (nonatomic , copy) NSString *pageName;
@property (nonatomic , copy) NSString *pageClassName;
@end


@interface HWRouterPageRegist : NSObject

+ (HWRouterPageRegist *)sharedRegist;

- (void)addPage:(NSString *)pageName
  pageClassName:(NSString *)pageClassName;

- (Class)pageClass:(NSString *)pageName;

- (NSString *)pageClassName:(NSString *)pageName;

- (NSString *)pageName:(NSString *)pageClass;

- (HWMPageModel *)page:(NSString *)pageName;
@end

NS_ASSUME_NONNULL_END
