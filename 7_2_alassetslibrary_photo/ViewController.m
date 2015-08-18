//
//  ViewController.m
//  7_2_alassetslibrary_photo
//
//  Created by Shinya Hirai on 2015/08/18.
//  Copyright (c) 2015年 Shinya Hirai. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openCamera:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePickerController setAllowsEditing:YES];
        [imagePickerController setDelegate:self];
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    } else {
        NSLog(@"camera invalid");
    }
}

- (IBAction)openPhoto:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePickerController setAllowsEditing:YES];
        [imagePickerController setDelegate:self];
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    } else {
        NSLog(@"photo library invalid");
    }
}

// 写真を選択したあとに呼ばれるメソッド
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"選択");
    
    // infoから画像のurl(iphone内のpath)を取得します
    NSURL *photoUrl = [info objectForKey:UIImagePickerControllerReferenceURL];
    NSString *urlStr = [photoUrl absoluteString];
    NSLog(@"Photoのassets url = %@", urlStr);
    
    // assetsLibraryに変換する
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library assetForURL:photoUrl resultBlock:^(ALAsset *asset) {
        // まずはassetsからバッファをつくる
        ALAssetRepresentation *rep = [asset defaultRepresentation];
        
        Byte *buffer = (Byte *)malloc(rep.size);
        
        NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
        
        // dataにする
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
        
        // imageにする
        UIImage *imagFromFile = [UIImage imageWithData:data];
        
        // 表示する
        self.imageView.image = imagFromFile;
        
    } failureBlock:^(NSError *error) {
        // error handling
    }];
    
    
    // pickerViewを閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
