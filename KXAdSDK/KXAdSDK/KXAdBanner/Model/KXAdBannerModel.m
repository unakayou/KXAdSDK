//
//  KXAdBannerModel.m
//  KXAdSDK
//
//  Created by unakayou on 6/10/19.
//  Copyright © 2019 KXNet. All rights reserved.
//

#import "KXAdBannerModel.h"
@implementation KXAdBannerPlatform

@end

@implementation KXAdBannerModel

//创建几个平台.正式情况下应该从服务器端获取.
- (NSArray <KXAdBannerPlatform *>*)platforms {
    if (!_platforms) {
        NSMutableArray * tmpArray = [[NSMutableArray alloc] initWithCapacity:10];
        for (int i = 0; i < 10; i++) {
            KXAdBannerPlatform * platform = [KXAdBannerPlatform new];
            Class adapterClass = NSClassFromString(@"KXAdBannerAdapterAdmob");
            platform.adapterClassName = adapterClass;
            platform.percent = 10;
            [tmpArray addObject:platform];
            _platforms = [tmpArray copy];
        }
    }
    return _platforms;
}

//生成一个随机数,比如75.每次遍历一个平台,累加他的百分比,直到百分比大于等于75,这个平台就是随机到的,并返回这个平台.
- (KXAdBannerPlatform *)getOnePlatformForRequest {
    NSInteger javelin = arc4random() % 100;
    __block NSInteger tmpPercent = 0;
    __block KXAdBannerPlatform * retPlatform = nil;
    [self.platforms enumerateObjectsUsingBlock:^(KXAdBannerPlatform * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (javelin > tmpPercent) {
            tmpPercent += obj.percent;
            if (javelin <= tmpPercent) {
                retPlatform = obj;
                *stop = YES;
            }
        }
    }];
    return retPlatform;
}
@end
