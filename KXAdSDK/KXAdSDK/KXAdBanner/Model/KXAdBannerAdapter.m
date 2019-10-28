//
//  KXAdBannerAdapter.m
//  KXAdSDK
//
//  Created by unakayou on 6/10/19.
//  Copyright © 2019 KXNet. All rights reserved.
//

#import "KXAdBannerAdapter.h"

@interface KXAdBannerAdapter()

@end

@implementation KXAdBannerAdapter
+ (KXAdNetworkType)networkType {
    return KXAdNetworkType_None;
}

- (id)initAdapterWithAdViewDelegate:(id<KXAdBannerViewProtocol>)delegate view:(KXAdBannerView *)view {
    if (self = [super init]) {
        self.delegate = delegate;
        self.bannerView = view;
    }
    return self;
}

- (void)getAd{NSLog(@"%s",__FUNCTION__);}
- (void)stopBeingDelegate{NSLog(@"%s",__FUNCTION__);}
- (void)dealloc {NSLog(@"%s",__FUNCTION__);}
@end
