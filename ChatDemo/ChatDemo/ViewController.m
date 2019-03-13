//
//  ViewController.m
//  ChatDemo
//
//  Created by midland on 2019/3/11.
//  Copyright © 2019年 midland. All rights reserved.
//

#import "ViewController.h"
#import "ConversationController.h"
#import "ChatViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)buttonClick:(UIButton *)sender {
    NSLog(@"%@", sender.titleLabel.text);
    NSString *btnTitle = sender.titleLabel.text;
    if ([btnTitle isEqualToString:@"登录"]) {
        [self loginAction];
    } else if ([btnTitle isEqualToString:@"会话"]) {
        [self conversationAction];
    } else if ([btnTitle isEqualToString:@"C2C"]) {
        [self c2cAction];
    } else if ([btnTitle isEqualToString:@"退出"]) {
        [self logoutAction];
    }
}

#pragma mark - event response
- (void) loginAction {
    [[TUIKit sharedInstance] loginKit:USER_NAME userSig:IDENTIFIER succ:^{
        // 自动登录成功跳转其他页面
        NSLog(@"登录成功");
    } fail:^(int code, NSString *msg) {
        NSLog(@"登录失败 -- %@", msg);
    }];
}

- (void) conversationAction {
    ConversationController *VC = [[ConversationController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void) c2cAction {
    
    NSString *user = @"erp_pk_0BF71FA87590F655E050007F01007F2F";
    TConversationCellData *data = [[TConversationCellData alloc] init];
    data.convId = user;
    data.convType = TConv_Type_C2C;
    data.title = user;
    
    ChatViewController *chat = [[ChatViewController alloc] init];
    chat.conversation = data;
    [self.navigationController pushViewController:chat animated:YES];
}

- (void) logoutAction {
    [[TUIKit sharedInstance] logoutKit:^{
        NSLog(@"退出成功");
    } fail:^(int code, NSString *msg) {
        NSLog(@"退出失败 -- %@", msg);
    }];
}

@end
