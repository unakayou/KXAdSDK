//
//  ViewController.m
//  KXAdDemo
//
//  Created by unakayou on 6/10/19.
//  Copyright © 2019 KXNet. All rights reserved.
//

#import "ViewController.h"
#import <KXAdSDK/KXAdBannerView.h>

@interface ViewController () <KXAdBannerViewProtocol>
@property (nonatomic, strong) KXAdBannerView * banner;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.banner = [KXAdBannerView requestAdBannerViewWithAppKey:@"SDK12345678" WithDelegate:self];
    [self.view addSubview:self.banner];    
}

- (void)bannerViewStartGetAd:(nonnull KXAdBannerView *)bannerView {
    NSLog(@"%s",__FUNCTION__);
}

//可以再次调整尺寸
- (void)bannerViewDidReceiveAd:(KXAdBannerView *)bannerView {
    NSLog(@"%s",__FUNCTION__);
}

- (void)bannerViewDidClickAd:(nonnull KXAdBannerView *)bannerView {
    NSLog(@"%s",__FUNCTION__);
}


- (void)bannerViewFailRequestAd:(nonnull KXAdBannerView *)bannerView error:(nonnull NSError *)error {
    if (self.banner == bannerView) {
        [self.banner removeFromSuperview];
        self.banner = nil;
    }
    NSLog(@"%s",__FUNCTION__);
}

- (nonnull UIViewController *)viewControllerForPresentingModalView {
    return self;
}
@end
