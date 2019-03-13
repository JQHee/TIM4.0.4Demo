//
//  TIMCustomElemTool.h
//  ChatDemo
//
//  Created by midland on 2019/3/13.
//  Copyright © 2019年 midland. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TIMCustomElemTool : NSObject

/**
 自定义消息打包

 @param action 所属类型
 @param params 参数
 @return 打包好的 nsdata 数据
 */
+  (NSData *)packToSendData: (NSString *) action params:(id) params;


/**
 解析data成OC对象

 @param data 参数
 @return 自定义的消息体
 */
+ (NSDictionary *)parsingData:(NSData *) data;

@end

NS_ASSUME_NONNULL_END
