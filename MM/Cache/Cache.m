//
//  Cache.m
//  QQing
//
//  Created by 王涛 on 1/29/15.
//
//

#import "Cache.h"

#define kUsername @"UserName"
#define kPassword @"PassWord"

@implementation Cache
@synthesize isSignin;

SINGLETON_GCD(Cache);

// 保存用户名和密码
- (void)setUsername:(NSString *)username password:(NSString *)password {
    UICKeyChainStore *keychainStore = [UICKeyChainStore keyChainStore];
    [keychainStore removeItemForKey:kUsername];
    [keychainStore removeItemForKey:kPassword];
    [keychainStore setString:username forKey:kUsername];
    [keychainStore setString:password forKey:kPassword];
}

- (void)setUsername:(NSString *)username {
    UICKeyChainStore *keychainStore = [UICKeyChainStore keyChainStore];
    [keychainStore removeItemForKey:kUsername];
    [keychainStore setString:username forKey:kUsername];
}

- (NSString *)username {
    UICKeyChainStore *keychainStore = [UICKeyChainStore keyChainStore];
    return [keychainStore stringForKey:kUsername];
}

- (NSString *)password {
    UICKeyChainStore *keychainStore = [UICKeyChainStore keyChainStore];
    return [keychainStore stringForKey:kPassword];
}

- (void)setUserID:(long long)userID {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:@"UID"];
    [ud setObject:[NSNumber numberWithLongLong:userID] forKey:@"UID"];
    [ud synchronize];
}

- (long long)userID {
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSNumber *value = [ud objectForKey:@"UID"];
    if (value && ![value isEqualToNumber:[NSNumber numberWithLongLong:0]]) {
        return [value longLongValue];
    } else {
        return 0;
    }
}
- (void)setCookie:(BOOL)_isSignin {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:@"cookie"];
    [ud setObject:[NSNumber numberWithBool:_isSignin] forKey:@"cookie"];
    [ud synchronize];
}

- (BOOL)cookie {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSNumber *value = [ud objectForKey:@"cookie"];
    if (value && [value boolValue]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)setSession:(long)session {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:@"session"];
    [ud setObject:[NSNumber numberWithLong:session] forKey:@"session"];
    [ud synchronize];
}

- (long)session {
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSNumber *value = [ud objectForKey:@"session"];
    if (value && ![value isEqualToNumber:[NSNumber numberWithLongLong:0]]) {
        return [value longValue];
    } else {
        return 0;
    }
}

- (void)setTokenId:(NSString *)tokenId {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:@"tokenId"];
    [ud setObject:tokenId forKey:@"tokenId"];
    [ud synchronize];
}

- (NSString *)tokenId {
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString *value = [ud objectForKey:@"tokenId"];
    return value;
}

- (void)resetUser {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    // 移除已登录过标识
    [ud removeObjectForKey:@"cookie"];
    [ud removeObjectForKey:@"tokenId"];
    [ud synchronize];
    /**
     *  用户名密码 使用钥匙串处理
     */
     UICKeyChainStore *keychainStore = [UICKeyChainStore keyChainStore];
    // 移除用户名
    [keychainStore removeItemForKey:kUsername];
    // 移除密码
    [keychainStore removeItemForKey:kPassword];
}

@end
