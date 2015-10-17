//
//  def.h
//  QQing
//
//  Created by 王涛 on 1/26/15.
//
//

#ifndef QQing_def_h
#define QQing_def_h

#define FA_EXTERN    extern __attribute__((visibility ("default")))

/*!
 * @function Singleton GCD Macro
 */
#ifndef SINGLETON_GCD
#define SINGLETON_GCD(classname)                        \
\
+ (classname *)shared##classname {                      \
\
static dispatch_once_t pred;                        \
__strong static classname * shared##classname = nil;\
dispatch_once( &pred, ^{                            \
shared##classname = [[self alloc] init]; });    \
return shared##classname;                           \
}
#endif

#ifndef NS_ENUM
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif

//系统版本
#define SYSTEM_VERSION  [[UIDevice currentDevice].systemVersion doubleValue]

// Log
#define DEBUG_MODE 1
#if DEBUG
#define QQLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define QQLog( s, ... )
#endif

// RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r, g, b, 1.0f)

// Tag定义
#undef TAG_DEC // 声明
#define TAG_DEC( __name )       DEC_STATIC_PROPERTY( __name )

#undef TAG_DEF // 定义
#define TAG_DEF( __name )       DEF_STATIC_PROPERTY3( __name, @"tag", [self description] )

#undef TAG_EQUAL
#define TAG_EQUAL( __tag1, __tag2 ) ([__tag1 isEqualToString:__tag2])

// Notification定义


#endif
