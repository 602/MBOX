//
//  UIView+Hierarchy.h
//  QQing
//
//  Created by 李杰 on 2/22/15.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Hierarchy)

- (NSUInteger)getSubviewIndex;

- (void)bringToFront;
- (void)sendToBack;

- (void)bringOneLevelUp;
- (void)sendOneLevelDown;

- (BOOL)isInFront;
- (BOOL)isAtBack;

- (void)swapDepthsWithView:(UIView*)swapView;

- (void)removeAllSubviews;
- (void)removeSubViewByTag:(NSUInteger)tag;
- (void)removeSubViews:(NSArray *)views;

- (BOOL)containsSubView:(UIView *)subView;
- (BOOL)containsSubViewOfClassType:(Class)classt;

@end
