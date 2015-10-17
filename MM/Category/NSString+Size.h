//
//  NSString+Size.h
//  QQing
//
//  Created by 李杰 on 2/13/15.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end