//
//  VideoViewController.h
//  TUIKitDemo
//
//  Created by kennethmiao on 2018/11/9.
//  Copyright © 2018年 kennethmiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVideoMessageCell.h"

// MARK: - 视频选择页面
@interface VideoViewController : UIViewController
@property (nonatomic, strong) TVideoMessageCellData *data;
@end
