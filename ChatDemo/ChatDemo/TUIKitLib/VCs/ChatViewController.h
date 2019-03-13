//
//  ChatViewController.h
//  TUIKitDemo
//
//  Created by kennethmiao on 2018/10/10.
//  Copyright © 2018年 kennethmiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TChatController.h"

// MARK: - 聊天页面
@interface ChatViewController : UIViewController
@property (nonatomic, strong) TConversationCellData *conversation;
@end
