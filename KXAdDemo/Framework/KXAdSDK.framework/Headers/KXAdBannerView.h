//
//  KXAdBannerView.h
//  KXAdSDK
//
//  Created by unakayou on 6/10/19.
//  Copyright © 2019 KXNet. All rights reserved.
//  Banner请求入口

#import <UIKit/UIKit.h>
#import <KXAdSDK/KXAdBannerAdapter.h>
@class KXAdBannerView;

NS_ASSUME_NONNULL_BEGIN
//bannerView 对外的协议
@protocol KXAdBannerViewProtocol <NSObject>
@required
- (UIViewController *)viewControllerForPresentingModalView;
@optional
- (void)bannerViewDidReceiveAd:(KXAdBannerView *)bannerView;
- (void)bannerViewFailRequestAd:(KXAdBannerView *)bannerView error:(NSError*)error;
- (void)bannerViewDidClickAd:(KXAdBannerView *)bannerView;  //有的平台没有点击回调 比如admob
- (void)bannerViewStartGetAd:(KXAdBannerView *)bannerView;
@end

@interface KXAdBannerView : UIView <KXAdBannerAdapterProtocol>
@property (nonatomic, weak) id <KXAdBannerViewProtocol> delegate;

+ (KXAdBannerView *)requestAdBannerViewWithAppKey:(NSString*)appkey WithDelegate:(id<KXAdBannerViewProtocol>)delegate;
@end

NS_ASSUME_NONNULL_END
