//
//  IHLabel.h
//  QQing
//
//  Created by 王涛 on 3/16/15.
//
// Icon Header label
//

#import <UIKit/UIKit.h>

@interface IHLabel : UIView

@property (nonatomic, assign) NSTextAlignment layoutAlignment;

@property (strong, nonatomic, readonly) UIImageView *headImg;
@property (strong, nonatomic, readonly) UILabel *textLabel;

@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *img;

@property (nonatomic, assign) BOOL autoAdjust; // 自适应

/**
 * - initWithFrame
 * - setText
 */

- (id)initWithFrame:(CGRect)frame imageName:(NSString *)img text:(NSString *)text_ textColor:(UIColor *)color;
- (id)init;
@end
