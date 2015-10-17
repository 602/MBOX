//
//  UIAlertView+fram.m
//  QQing
//
//  Created by 王涛 on 15/3/31.
//
//

#import "UIAlertView+fram.h"

@implementation UIAlertView (fram)
-(void)dismissAfter:(int)time{

    [self performSelector:@selector(hideAnimated) withObject:nil afterDelay:time];
}
- (void)hideAnimated{

    [self dismissWithClickedButtonIndex:0 animated:YES];
}
@end
