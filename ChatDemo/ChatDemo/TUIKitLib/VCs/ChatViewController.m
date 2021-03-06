//
//  ChatViewController.m
//  TUIKitDemo
//
//  Created by kennethmiao on 2018/10/10.
//  Copyright © 2018年 kennethmiao. All rights reserved.
//

#import "ChatViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "TVideoMessageCell.h"
#import "TFileMessageCell.h"
#import "ImageViewController.h"
#import "VideoViewController.h"
#import "FileViewController.h"

@interface ChatViewController () <TChatControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate>
@property (nonatomic, strong) TChatController *chat;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _chat = [[TChatController alloc] init];
    _chat.conversation = _conversation;
    _chat.delegate = self;
    [self addChildViewController:_chat];
    [self.view addSubview:_chat.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)chatControllerDidClickRightBarButton:(TChatController *)controller
{

}

- (void)chatController:(TChatController *)chatController didSelectMoreAtIndex:(NSInteger)index
{

    if(index == 0 || index == 1 || index == 2){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        if(index == 0){ // 相册
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        }
        else if(index == 1) { // 相机
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        }
        else{ // 视频
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
            picker.cameraCaptureMode =UIImagePickerControllerCameraCaptureModeVideo;
            picker.videoQuality =UIImagePickerControllerQualityTypeHigh;
        }
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    } else if (index == 3){ // 文档选取
        UIDocumentPickerViewController *picker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[(NSString *)kUTTypeData] inMode:UIDocumentPickerModeOpen];
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    } else  { // 发送房源信息
        [self sendHouseInfoMessage];
    }
}

- (void)chatController:(TChatController *)chatController didSelectMessages:(NSMutableArray *)msgs atIndex:(NSInteger)index
{
    TMessageCellData *data = msgs[index];
    if([data isKindOfClass:[TImageMessageCellData class]]){
        ImageViewController *image = [[ImageViewController alloc] init];
        image.data = (TImageMessageCellData *)data;
        [self presentViewController:image animated:YES completion:nil];
    }
    else if([data isKindOfClass:[TVideoMessageCellData class]]){
        VideoViewController *video = [[VideoViewController alloc] init];
        video.data = (TVideoMessageCellData *)data;
        [self presentViewController:video animated:YES completion:nil];
    }
    else if([data isKindOfClass:[TFileMessageCellData class]]){
        FileViewController *file = [[FileViewController alloc] init];
        file.data = (TFileMessageCellData *)data;
        // UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:file];
        //[self presentViewController:nav animated:YES completion:nil];
        [self.navigationController pushViewController:file animated:YES];
    }
}

#warning mark - 发送房源信息
- (void) sendHouseInfoMessage {
    TIMCustomElem *model = [TIMCustomElem new];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"title"] = @"房源标题";
    dictionary[@"imgURL"] = @"https://www.baidu.com";
    model.data = [TIMCustomElemTool packToSendData:HOUSE_INFO params:dictionary];
    [_chat sendHouseInfo:model];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImageOrientation imageOrientation =  image.imageOrientation;
        if(imageOrientation != UIImageOrientationUp)
        {
            UIGraphicsBeginImageContext(image.size);
            [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }

        [_chat sendImageMessage:image];
    }
    else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        [_chat sendVideoMessage:url];
    }

    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url
{
    [_chat sendFileMessage:url];
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)getLocalPath:(NSURL *)url
{
    NSString *imageName = [url lastPathComponent];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *localFilePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    return localFilePath;
}
@end
