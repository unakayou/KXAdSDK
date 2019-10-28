//
//  KXAdBannerAdapter.h
//  KXAdSDK
//
//  Created by unakayou on 6/10/19.
//  Copyright © 2019 KXNet. All rights reserved.
//  用于调用不同广告平台的Adapter基类

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class KXAdBannerView;
@class KXAdBannerAdapter;
@protocol KXAdBannerViewProtocol;

typedef NS_ENUM(NSInteger, KXAdNetworkType) {
    KXAdNetworkType_None,
    KXAdNetworkType_Admob,
    KXAdNetworkType_Baidu
};

//对内的协议.也可以给KXAdBannerView写分类,把这些方法放入分类中
@protocol KXAdBannerAdapterProtocol <NSObject>
- (void)adapter:(KXAdBannerAdapter *)adapter startRequestAdView:(UIView *)view;
- (void)adapter:(KXAdBannerAdapter *)adapter didReceiveAdView:(UIView *)view;
- (void)adapter:(KXAdBannerAdapter *)adapter didFailAd:(NSError *)error;
- (void)adapter:(KXAdBannerAdapter *)adapter didClick:(UIView *)view;
@end

@interface KXAdBannerAdapter : NSObject
@property (nonatomic, strong) UIView * adNetworkView;               //三方平台Banner
@property (nonatomic, strong) KXAdBannerView * bannerView;          //我方承载Banner
@property (nonatomic, weak) id<KXAdBannerViewProtocol> delegate;    //Banner展示回调delegate

/**
 返回Adapter类型

 @return Adapter类型枚举
 */
+ (KXAdNetworkType)networkType;

/**
 基类初始化 仅仅是赋值delegate、最外层view.不会在子类中重写.
 */
- (id)initAdapterWithAdViewDelegate:(id <KXAdBannerViewProtocol>)delegate view:(KXAdBannerView *)view;

/**
 获取广告
 */
- (void)getAd;

/**
 停止广告
 */
- (void)stopBeingDelegate;
@end
