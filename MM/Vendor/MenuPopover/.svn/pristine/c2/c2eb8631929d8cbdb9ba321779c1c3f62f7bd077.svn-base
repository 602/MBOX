//
//  MLKMenuPopover.h
//  MLKMenuPopover
//
//  Created by NagaMalleswar on 20/11/14.
//  Copyright (c) 2014 NagaMalleswar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, QQcloseToBorderStyle) {
    QQcloseToBorderStyleLeft = 0, // Dark content, for use on light backgrounds
    QQcloseToBorderStyleRight
};

@class MLKMenuPopover;

@protocol MLKMenuPopoverDelegate

- (void)menuPopover:(MLKMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex;

@end

@interface MLKMenuPopover : UIView <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,assign) id<MLKMenuPopoverDelegate> menuPopoverDelegate;

- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)menuItems menuImages:(NSArray*)amenuImages closeTo:(QQcloseToBorderStyle)closeToBorderStyle;
- (void)showInView:(UIView *)view;
- (void)dismissMenuPopover;
- (void)layoutUIForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end