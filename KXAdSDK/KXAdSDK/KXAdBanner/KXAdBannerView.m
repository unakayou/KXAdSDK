//
//  KXAdBannerView.m
//  KXAdSDK
//
//  Created by unakayou on 6/10/19.
//  Copyright © 2019 KXNet. All rights reserved.
//

#import "KXAdBannerView.h"
#import "KXAdBannerModel.h"
#import "KXAdBannerAdapter.h"

@interface KXAdBannerView()
@property (nonatomic, copy) NSString * appKey;
@property (nonatomic, strong) KXAdBannerAdapter * adapter;
@end

@implementation KXAdBannerView
+ (KXAdBannerView *)requestAdBannerViewWithAppKey:(NSString *)appkey WithDelegate:(id<KXAdBannerViewProtocol>)delegate {
    KXAdBannerView * bannerView = [[KXAdBannerView alloc] initAdbannerViewWithAppKey:appkey WithDelegate:delegate];
    return bannerView;
}

- (instancetype)initAdbannerViewWithAppKey:(NSString *)appkey WithDelegate:(id<KXAdBannerViewProtocol>)delegate {
    if (self = [super init]) {
        self.appKey = appkey;
        self.delegate = delegate;
        NSLog(@"开始请求可以轮询的聚合平台");
        /*
         * TO DO: 通知服务器本地 SDK - AdAdapterRegisterManager 支持的平台,获取服务器配置.比如调用聚合广告平台比例、切换间隔等.
         */
        __block KXAdBannerModel * model = nil;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"配置信息请求完毕, 假设请求回来10个广告平台数据");
            //假如服务器返回10个平台,每个平台10%几率展示.简单的这样写.应该有个AdAdapterRegisterManager管理这些平台对象,用服务器下发的networkType来取对应的平台
            model = [[KXAdBannerModel alloc] init];
            KXAdBannerPlatform * platform = [model getOnePlatformForRequest];   //伪随机取一个平台
            NSLog(@"本次获取平台 %@",platform.adapterClassName);
            
            self.adapter = [[platform.adapterClassName alloc] initAdapterWithAdViewDelegate:delegate view:self];
            if (!self.adapter && [self.delegate respondsToSelector:@selector(bannerViewFailRequestAd:error:)]) {
                [self.delegate bannerViewFailRequestAd:self error:[NSError errorWithDomain:@"No Adapter" code:0 userInfo:nil]];
            } else {
                [self.adapter getAd];
            }
        });
    }
    return self;
}
- (void)adapter:(KXAdBannerAdapter *)adapter startRequestAdView:(UIView *)view {
    if ([self.delegate respondsToSelector:@selector(bannerViewStartGetAd:)]) {
        [self.delegate bannerViewStartGetAd:self];
    }
}

- (void)adapter:(KXAdBannerAdapter *)adapter didReceiveAdView:(UIView *)view {
    //还需要做各种处理、布局等等.上报广告请求成功
    if (adapter.adNetworkView == view) {
        self.frame = view.frame;
        [self addSubview:view];
        
        if ([self.delegate respondsToSelector:@selector(bannerViewDidReceiveAd:)]) {
            [self.delegate bannerViewDidReceiveAd:self];
        }
    }
}

- (void)adapter:(KXAdBannerAdapter *)adapter didFailAd:(NSError *)error {
    //发送错误日志
    if ([self.delegate respondsToSelector:@selector(bannerViewFailRequestAd:error:)]) {
        [self.delegate bannerViewFailRequestAd:self error:error];
    }
}

- (void)adapter:(KXAdBannerAdapter *)adapter didClick:(UIView *)view {
    //这里还要发送点击汇报
    if ([self.delegate respondsToSelector:@selector(bannerViewDidClickAd:)]) {
        [self.delegate bannerViewDidClickAd:self];
    }
}

@end
