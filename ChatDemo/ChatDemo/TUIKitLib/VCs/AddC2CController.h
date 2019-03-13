//
//  AddC2CController.h
//  TUIKit
//
//  Created by kennethmiao on 2018/10/15.
//  Copyright © 2018年 kennethmiao. All rights reserved.
//

#import <UIKit/UIKit.h>

// MARK: - 添加会话
@class TConversationCellData;
@interface AddC2CController : UIViewController

@property (nonatomic, copy) void(^finishBlock)(TConversationCellData *data) ;

@end
