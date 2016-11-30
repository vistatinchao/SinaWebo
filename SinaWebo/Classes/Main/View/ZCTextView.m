//
//  ZCTextView.m
//  SinaWebo
//
//  Created by mac on 2016/11/30.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCTextView.h"

@implementation ZCTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [ZCNotiCenter addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (self.hasText) return;
    CGFloat placeholderX = 5;
    CGFloat placeholderY = 8;
    CGFloat placeholderW = self.width-2*placeholderX;
    CGFloat placeholderH = self.height- 2*placeholderY;
    CGRect placeholderRect = CGRectMake(placeholderX, placeholderY, placeholderW, placeholderH);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = self.font;
    dict[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    [self.placeholder drawInRect:placeholderRect withAttributes:dict];
}

- (void)textChange
{
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [ZCNotiCenter removeObserver:self];
}



@end
