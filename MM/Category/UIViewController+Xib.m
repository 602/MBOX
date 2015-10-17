//
//  UIViewController+Xib.m
//  QQing
//
//  Created by 李杰 on 2/20/15.
//
//

#import "UIViewController+Xib.h"

@implementation UIViewController (Xib)

- (id) _initWithNib {
    return [self initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

@end
