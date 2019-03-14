//
//  MLChatInputTextView.h
//  ChatDemo
//
//  Created by midland on 2019/3/14.
//  Copyright © 2019年 midland. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 IM 聊天带有提示文字的输入框
 */
@interface MLChatInputTextView : UITextView

/* 占位文字 */
@property(nonatomic, copy) NSString *placeholder;
/* 占位文字颜色 */
@property(nonatomic, strong) UIColor *placeholderColor;

@property (nonatomic, weak) UIResponder *overrideNextResponder;

@end

NS_ASSUME_NONNULL_END
