//
//  TIMCustomElemTool.m
//  ChatDemo
//
//  Created by midland on 2019/3/13.
//  Copyright © 2019年 midland. All rights reserved.
//

#import "TIMCustomElemTool.h"

@implementation TIMCustomElemTool

+  (NSData *)packToSendData: (NSString *) action params:(id) params {
    NSMutableDictionary *post = [NSMutableDictionary dictionary];
    [post setObject:action forKey:@"userAction"];
    [post setObject:params forKey:@"actionParam"];
    
    if ([NSJSONSerialization isValidJSONObject:post]) {
        NSError *error = nil;
        //这是demo带的方法，这么上传，微信端总是带转义符，无法解析。
        // NSData *data = [NSJSONSerialization dataWithJSONObject:post options:NSJSONWritingPrettyPrinted error:&error];
        
        // 自己写，不要完全相信demo，会坑死人。
        NSString *jsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:post options:kNilOptions error:&error] encoding:NSUTF8StringEncoding];
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        
        if(error) {
            return nil;
        }
        return data;
    }else {
        return nil;
    }
}

+ (NSDictionary *)parsingData:(NSData *) data {
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
}

@end
