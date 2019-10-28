//
//  KXAdBannerModel.h
//  KXAdSDK
//
//  Created by unakayou on 6/10/19.
//  Copyright © 2019 KXNet. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface KXAdBannerPlatform : NSObject
@property (nonatomic, strong) Class adapterClassName;   //平台名
@property (nonatomic, assign) NSInteger percent;        //展示百分比
@end

@interface KXAdBannerModel : NSObject
@property (nonatomic, strong) NSArray <KXAdBannerPlatform *>* platforms;  //支持的平台

/**
 获取本次请求的平台

 @return 平台Model
 */
- (KXAdBannerPlatform *)getOnePlatformForRequest;
@end

NS_ASSUME_NONNULL_END
