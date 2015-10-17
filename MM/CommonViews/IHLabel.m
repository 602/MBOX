//
//  IHLabel.m
//  QQing
//
//  Created by 王涛 on 3/16/15.
//
//

#import "IHLabel.h"

#define kDefaultHeadImageWidth 20.f
#define kDefaultHeadImageHeight kDefaultHeadImageWidth

#define kDefaultTextLabelWidth 480.f
#define kDefaultTextLabelHeight 30.f

@implementation IHLabel

#pragma mark - Initialization

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        [self commonInit:self.frame];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame imageName:(NSString *)img text:(NSString *)text_ textColor:(UIColor *)color {
    if (self = [super initWithFrame:frame]) {
        [self commonInit:frame];
        
        [self setImg:img];
        [self setText:text_];
        self.textLabel.textColor = color;
    }
    
    return self;
}
- (id)init{

    if (self = [super init]) {
        [self commonInit:self.frame];
    }
    
    return self;
}
- (void)commonInit:(CGRect)frame {
    // head icon
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDefaultHeadImageWidth, kDefaultHeadImageHeight)];
    [self addSubview:_headImg];
    [_headImg setCenter:CGPointMake(_headImg.width/2, frame.size.height/2)];
    // text
    _textLabel = [UIUtils labelWith:@"" size:16.0 color:[UIColor blackColor]];
    
    [_textLabel setFrame:CGRectMake(_headImg.x+_headImg.width+PIXEL_4, 0, self.bounds.size.width-_headImg.x-_headImg.width-PIXEL_4, kDefaultTextLabelHeight)];
    [self addSubview:_textLabel];
    [_textLabel setCenterY:frame.size.height/2];
    // layout
//    [self layoutSizeFit];
}

#pragma mark - Utility

- (CGSize)autoSize {
    return [self.textLabel.text boundingRectWithSize:self.textLabel.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textLabel.font} context:nil].size;
}

#pragma mark - Override

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    QQLog(@"head:x(%f)y(%f), text:x(%f)y(%f)", self.headImg.centerX, self.headImg.centerY,
//          self.textLabel.centerX, self.textLabel.centerY);
    
    [self setLayoutAlignment:_layoutAlignment];
}

#pragma mark - Properties setting

- (void)setImg:(NSString *)img {
    if (!img ||
        ![img length]) {
        return;
    }
    
    _img = img;
    UIImage *image = [UIImage imageNamed:img];
    [_headImg setImage:image];
    
    // size layout
//    CGSize size = image.size;
//    [_headImg setCenter:CGPointMake(PIXEL_8+size.width/2, self.height/2)];
    
//    [self layoutSizeFit];
}

- (void)setText:(NSString *)text {
    _textLabel.text = text;
    [_textLabel setFrame:CGRectMake(_textLabel.x,
                                   _textLabel.y,
                                   [self autoSize].width,
                                   [self autoSize].height)];
    
//    QQLog(@"[%@] [%@]", _textLabel.text, NSStringFromCGSize([self autoSize]));
    
    [_textLabel setCenterY:self.height/2];
    
//    [self layoutSizeFit];
}

- (void)setLayoutAlignment:(NSTextAlignment)layoutAlign {
    _layoutAlignment = layoutAlign;
    
//    QQLog(@"self width=%f", self.width);
    
    // 计算icon＋label大小
    CGFloat contentWidth = 0;
    
    contentWidth += self.headImg.width;
    contentWidth += self.textLabel.width;
    
    if (_layoutAlignment == NSTextAlignmentLeft) {
        // default
    } else if (_layoutAlignment == NSTextAlignmentRight) {
        CGFloat fixX = self.width;
        fixX -= contentWidth;
        
        [self.headImg setCenter:CGPointMake(fixX+self.headImg.width/2-PIXEL_4, self.headImg.centerY)];
        
        [self.textLabel setCenterX:(fixX+self.headImg.width+self.textLabel.width/2)];
    } else if (_layoutAlignment == NSTextAlignmentCenter) {
        CGFloat fixX = self.width/2;
        fixX -= contentWidth/2;
        
        [self.headImg setCenter:CGPointMake(fixX+self.headImg.width/2-PIXEL_4, self.headImg.centerY)];
        
        [self.textLabel setCenterX:(fixX+self.headImg.width+self.textLabel.width/2)];
    }
}

@end
