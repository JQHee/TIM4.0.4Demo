//
//  THouseInfoCellData.h
//  ChatDemo
//
//  Created by midland on 2019/3/12.
//  Copyright © 2019年 midland. All rights reserved.
//

#import "TMessageCell.h"

@interface THouseInfoCellData : TMessageCellData

// 房源标题
@property (nonatomic, copy) NSString *title;
// 房源图片
@property (nonatomic, copy) NSString *imgURL;

@end

