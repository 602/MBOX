//
//  LocationService.h
//  QQing
//
//  Created by 王涛 on 2/27/15.
//
//

#import <Foundation/Foundation.h>

@class LocationModel;

@interface LocationService : NSObject <CLLocationManagerDelegate> {
    @private
    CLLocationManager *_locationManager;
}

+ (LocationService *)sharedLocationService;

- (void)start;
- (void)stop;

/**
 *  判断用户是否打开了定位
 */
- (BOOL)isAllowGetLocation;

- (LocationModel *)lastLocation;
- (LocationModel *)location;

/**
 *  判断用户当前网络状态
 */
- (BOOL)isExistNetWork;
- (BOOL)checkNetworkConnection;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

//LocationService的Model
@interface LocationModel : NSObject
@property (nonatomic, copy) NSString * address;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) int cityCode;

+ (id)modelWithLongitude:(double)lo latitude:(double)la;

+ (id)modelWithAddress:(NSString *)addr longitude:(double)lo latitude:(double)la;

+ (double)countDistanceBetween:(LocationModel *)black with:(LocationModel *)red;

- (double)countDistanceWith:(LocationModel *)lm;




@end
