//
//  AppSystem.m
//  QQing
//
//  Created by 李杰 on 5/22/15.
//
//

#import "AppSystem.h"

/**
 *  @author fallenink
 
 *  About error: @""
 
 *  Initialize in Class Method: @"+ (void)initialize"
 *  or change file suffix from "*.m" to "*.mm"
 */

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
const BOOL IOS8_OR_LATER = ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending );
const BOOL IOS7_OR_LATER = ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending );
const BOOL IOS6_OR_LATER = ( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending );
const BOOL IOS5_OR_LATER = ( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending );
const BOOL IOS4_OR_LATER = ( [[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending );
const BOOL IOS3_OR_LATER = ( [[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending );

const BOOL IOS7_OR_EARLIER = !IOS8_OR_LATER;
const BOOL IOS6_OR_EARLIER = !IOS7_OR_LATER;
const BOOL IOS5_OR_EARLIER = !IOS6_OR_LATER;
const BOOL IOS4_OR_EARLIER = !IOS5_OR_LATER;
const BOOL IOS3_OR_EARLIER = !IOS4_OR_LATER;

const BOOL IS_SCREEN_4_INCH = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO);
const BOOL IS_SCREEN_35_INCH = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO);
#else
const BOOL IOS8_OR_LATER = NO;
const BOOL IOS7_OR_LATER = NO;
const BOOL IOS6_OR_LATER = NO;
const BOOL IOS5_OR_LATER = NO;
const BOOL IOS4_OR_LATER = NO;
const BOOL IOS3_OR_LATER = NO;

const BOOL IOS7_OR_EARLIER = NO;
const BOOL IOS6_OR_EARLIER = NO;
const BOOL IOS5_OR_EARLIER = NO;
const BOOL IOS4_OR_EARLIER = NO;
const BOOL IOS3_OR_EARLIER = NO;

const BOOL IS_SCREEN_4_INCH = NO;
const BOOL IS_SCREEN_35_INCH = NO;

#endif


@implementation AppSystem

+ (NSString *)OSVersion {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    return [NSString stringWithFormat:@"%@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion];
#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    return nil;
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
}

+ (NSString *)appVersion {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR || TARGET_OS_MAC)
    NSString * value = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    if ( nil == value || 0 == value.length ) {
        value = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersion"];
    }
    return value;
#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    return nil;
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
}

+ (NSString *)appIdentifier {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    static NSString * __identifier = nil;
    if ( nil == __identifier ) {
        __identifier = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    }
    return __identifier;
#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    return @"";
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
}

+ (NSString *)appSchema {
    return [self appSchema:nil];
}

+ (NSString *)appSchema:(NSString *)name {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    NSArray * array = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"];
    for ( NSDictionary * dict in array ) {
        if ( name ) {
            NSString * URLName = [dict objectForKey:@"CFBundleURLName"];
            if ( nil == URLName ) {
                continue;
            }
            
            if ( NO == [URLName isEqualToString:name] ) {
                continue;
            }
        }
        
        NSArray * URLSchemes = [dict objectForKey:@"CFBundleURLSchemes"];
        if ( nil == URLSchemes || 0 == URLSchemes.count ) {
            continue;
        }
        
        NSString * schema = [URLSchemes objectAtIndex:0];
        if ( schema && schema.length )
        {
            return schema;
        }
    }
    
    return nil;
#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    return nil;
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
}

+ (NSString *)deviceModel {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    return [UIDevice currentDevice].model;
#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    return nil;
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
}


#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
static const char * __jb_app = NULL;
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

+ (BOOL)isJailBroken NS_AVAILABLE_IOS(4_0) {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    static const char * __jb_apps[] = {
        "/Application/Cydia.app",
        "/Application/limera1n.app",
        "/Application/greenpois0n.app",
        "/Application/blackra1n.app",
        "/Application/blacksn0w.app",
        "/Application/redsn0w.app",
        NULL
    };
    
    __jb_app = NULL;
    
    // method 1
    for ( int i = 0; __jb_apps[i]; ++i ) {
        if ( [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:__jb_apps[i]]] ) {
            __jb_app = __jb_apps[i];
            return YES;
        }
    }
    
    // method 2
    if ( [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"] ) {
        return YES;
    }
    
    // method 3
    if ( 0 == system("ls") ) {
        return YES;
    }
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    
    return NO;
}

+ (NSString *)jailBreaker NS_AVAILABLE_IOS(4_0) {
#if (TARGET_OS_IPHONE)
    if ( __jb_app ) {
        return [NSString stringWithUTF8String:__jb_app];
    }
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    
    return @"";
}


@end
