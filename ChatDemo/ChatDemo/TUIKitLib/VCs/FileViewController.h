//
//  FileViewController.h
//  TUIKitDemo
//
//  Created by kennethmiao on 2018/11/12.
//  Copyright © 2018年 kennethmiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFileMessageCell.h"

// MARK: - 文件选择页面
@interface FileViewController : UIViewController
@property (nonatomic, strong) TFileMessageCellData *data;
@end
