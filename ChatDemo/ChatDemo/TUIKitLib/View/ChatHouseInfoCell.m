//
//  ChatHouseInfoCell.m
//  ChatDemo
//
//  Created by midland on 2019/3/11.
//  Copyright © 2019年 midland. All rights reserved.
//

#import "ChatHouseInfoCell.h"

@implementation ChatHouseInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat) getHeight {
    return 65;
}

- (void)setData:(THouseInfoCellData *)data {
    
}

@end
