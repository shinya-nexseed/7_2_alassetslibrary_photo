//
//  ViewController.h
//  7_2_alassetslibrary_photo
//
//  Created by Shinya Hirai on 2015/08/18.
//  Copyright (c) 2015年 Shinya Hirai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (IBAction)openCamera:(id)sender;
- (IBAction)openPhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

