//
//  MLChatInputTextView.m
//  ChatDemo
//
//  Created by midland on 2019/3/14.
//  Copyright © 2019年 midland. All rights reserved.
//

#import "MLChatInputTextView.h"

@implementation MLChatInputTextView

- (instancetype)init{
    
    
    if (self = [super init]) {
        // 设置默认字
        self.font = [UIFont systemFontOfSize:17];
        // 设置默认颜色
        self.placeholderColor = [UIColor grayColor];
        // 使用通知监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
        
    }
    return self;
    
}

- (UIResponder *)nextResponder
{
    if(_overrideNextResponder == nil){
        return [super nextResponder];
    }
    else{
        return _overrideNextResponder;
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (_overrideNextResponder != nil)
        return NO;
    else
        return [super canPerformAction:action withSender:sender];
}

- (void)textDidChange:(NSNotification *)note{
    
    // 会重新调用drawRect:方法
    [self setNeedsDisplay];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 * 每次调用drawRect:方法，都会将以前画的东西清除掉
 */
- (void)drawRect:(CGRect)rect{
    // 如果有文字，就直接返回，不需要画占位文字
    if (self.hasText) return;
    // 属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    // 画文字
    rect.origin.x = 5;
    rect.origin.y = 8;
    rect.size.width -= 2 * rect.origin.x;
    [self.placeholder drawInRect:rect withAttributes:attrs];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

#pragma mark - setter
//重写setter方法调用setNeedsDisplay方法刷新
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

@end
