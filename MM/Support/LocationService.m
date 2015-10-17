//
//  LocationService.m
//  QQing
//
//  Created by 王涛 on 2/27/15.
//
//

#import "LocationService.h"

@interface LocationService ()

@property (strong, nonatomic) LocationModel *curLocation;
@property (strong, nonatomic) LocationModel *lastLocation;

@end

@implementation LocationService
@synthesize locationManager;

@synthesize curLocation;
@synthesize lastLocation;

SINGLETON_GCD(LocationService);

#pragma mark - Initialization

- (void)initLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    
    //delegate
    self.locationManager.delegate = self;
    
    //The desired location accuracy.
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //Specifies the minimum update distance in meters.
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone;//fixme
}

- (id)init {
    if (self = [super init]) {
        [self initLocationManager];
    }
    
    return self;
}

#pragma mark - ctrl

- (void)start {
    [self.locationManager startUpdatingLocation];
}

- (void)stop {
    [self.locationManager stopUpdatingLocation];
}


#pragma mark - 外部信息提供

- (LocationModel *)lastLocation {
    return self.lastLocation;
}

- (LocationModel *)location {
    return self.curLocation;
}

/**
 *  判断用户是否打开了定位
 */
- (BOOL)isAllowGetLocation {
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
            QQLog(@"定位功能可用");
            return YES;
    } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        return NO;
    }
    
    return YES;
}

/**
 *  获取当前用户所在的城市名...and so on...
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    // 存储用户当前的位置
    CLLocationCoordinate2D coordinate = ((CLLocation *)[locations lastObject]).coordinate;
    self.curLocation = [LocationModel modelWithAddress:nil
                                             longitude:coordinate.longitude
                                              latitude:coordinate.latitude];
    // fixme : curLocation==lastLocation
    coordinate = ((CLLocation *)[locations lastObject]).coordinate;
    self.lastLocation = [LocationModel modelWithLongitude:coordinate.longitude
                                                 latitude:coordinate.latitude];
    
    // 解析用户当前城市
    CLLocation *cloc = [locations lastObject];
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:cloc completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error)
        {
            for (CLPlacemark * placemark in placemarks) {
                
                NSDictionary *test = [placemark addressDictionary];
                //  Country(国家)  State(城市)  SubLocality(区)
                NSString *addStr = [test objectForKey:@"State"];
                if (addStr && addStr.length != 0) {
                    // fixme : 这部分分功能，分别写到各个函数，功能的开启，外部bool
                    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationGetUserLocation object:addStr];
                }
            }
        }
    }];
}

/**
 *  检测当前网络连接状态
 *
 *  @return
 */
- (BOOL)isExistNetWork{
    BOOL isExist = NO;
    // fixme: AFNetworkReachabilityManager
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable: //无网络
            isExist = NO;
            break;
        case ReachableViaWWAN://WLAN
        {
            isExist = YES;
        }
            break;
        case ReachableViaWiFi://WIFI
        {
            isExist = YES;
        }
        default:
            break;
    }

    
    
    
    return isExist;
}
-(BOOL)checkNetworkConnection
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"didChangeAuthorizationStatus---%u",status);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didChangeAuthorizationStatus----%@",error);
}

@end

@implementation LocationModel
@synthesize longitude;
@synthesize latitude;
@synthesize address;

+ (id)modelWithLongitude:(double)lo latitude:(double)la {
    return [LocationModel modelWithAddress:@"" longitude:lo latitude:la];
}

+ (id)modelWithAddress:(NSString *)addr longitude:(double)lo latitude:(double)la {
    LocationModel *m = [LocationModel new];
    m.address = addr;
    m.longitude = lo;
    m.latitude = la;
    return m;
}

+ (double)countDistanceBetween:(LocationModel *)black with:(LocationModel *)red {
    //根据经纬度创建两个位置对象
    CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:black.latitude
                                               longitude:black.longitude];
    CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:red.latitude
                                               longitude:red.longitude];
    
    //计算两个位置之间的距离
    CLLocationDistance distance = [loc1 distanceFromLocation:loc2];
    return distance/1000;
}

- (double)countDistanceWith:(LocationModel *)lm {
    return [LocationModel countDistanceBetween:self with:lm];
}

@end