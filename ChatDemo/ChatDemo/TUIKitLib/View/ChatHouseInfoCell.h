//
//  ChatHouseInfoCell.h
//  ChatDemo
//
//  Created by midland on 2019/3/11.
//  Copyright © 2019年 midland. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 自定义的房源信息cell
 */
@interface ChatHouseInfoCell : TMessageCell

- (CGFloat) getHeight;

- (void)setData:(THouseInfoCellData *)data;;

@end

NS_ASSUME_NONNULL_END
