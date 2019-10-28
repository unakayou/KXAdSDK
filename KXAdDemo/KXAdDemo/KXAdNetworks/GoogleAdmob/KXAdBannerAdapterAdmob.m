//
//  KXAdBannerAdapterAdmob.m
//  KXAdDemo
//
//  Created by unakayou on 6/19/19.
//  Copyright © 2019 KXNet. All rights reserved.
//

#import "KXAdBannerAdapterAdmob.h"
#import <KXAdSDK/KXAdBannerView.h>

@implementation KXAdBannerAdapterAdmob
+ (KXAdNetworkType)networkType {
    return KXAdNetworkType_Admob;
}

+ (void)load {
    if(NSClassFromString(@"GADBannerView") != nil && NSClassFromString(@"GADRequest") != nil) {
        /*
         * 保存[Adapter class]到一个单例 AdAdapterRegisterManager 里面,标记有Admob的广告SDK.第一次请求配置时传到服务器,告知有哪几个广告平台SDK存在.
         * 然后用networkType去AdAdapterRegisterManager里面查询要使用的adapter
         */
    }
}

- (void)getAd {
    Class adMobViewClass = NSClassFromString (@"GADBannerView");
    Class GADRequestClass = NSClassFromString(@"GADRequest");
    
    if (!adMobViewClass || !GADRequestClass) {
        [self.bannerView adapter:self didFailAd:[NSError errorWithDomain:@"No Admob SDK" code:0 userInfo:nil]];
        return;
    }
    
    GADBannerView * adMobView = [[adMobViewClass alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    if (nil == adMobView) {
        [self.bannerView adapter:self didFailAd:[NSError errorWithDomain:@"Can't init Admob" code:0 userInfo:nil]];
        return;
    }
    
    [adMobView performSelector:@selector(setAdUnitID:) withObject:@""];
    [adMobView performSelector:@selector(setDelegate:) withObject:self];
    [adMobView performSelector:@selector(setRootViewController:) withObject:[self.delegate viewControllerForPresentingModalView]];
    
    GADRequest *request = [GADRequestClass request];
    request.testDevices = nil;
    [adMobView loadRequest:request];
    [self.bannerView adapter:self startRequestAdView:adMobView];

    self.adNetworkView = adMobView;
}

- (void)stopBeingDelegate {
    GADBannerView *adMobView = (GADBannerView *)self.adNetworkView;
    if (adMobView != nil) {
        [adMobView performSelector:@selector(setDelegate:) withObject:nil];
        [adMobView performSelector:@selector(setRootViewController:) withObject:nil];
        self.adNetworkView = nil;
    }
}

#pragma mark GADBannerViewDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    [self.bannerView adapter:self didReceiveAdView:bannerView];
    
    //adMob没有点击回调 所以可以不写这个.
    [self.bannerView adapter:self didClick:bannerView];
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    [self.bannerView adapter:self didFailAd:error];
}

- (void)adViewWillPresentScreen:(GADBannerView *)bannerView {
    
}

- (void)adViewDidDismissScreen:(GADBannerView *)bannerView {
    
}

@end
