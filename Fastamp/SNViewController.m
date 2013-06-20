//
//  SNViewController.m
//  Fastamp
//
//  Created by Noda Shimpei on 2013/06/13.
//  Copyright (c) 2013年 Noda Shimpei. All rights reserved.
//

#import "SNViewController.h"
#import "SNPhotoViewController.h"

@interface SNViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, readwrite) BOOL enableSheet;

@end

@implementation SNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setEnableSheet:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![self enableSheet])
        return;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Please select a photo" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"from Camera", @"from Album", nil];
    [actionSheet showInView:[self view]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    if ([title isEqualToString:@"from Camera"] &&
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePickerController setDelegate:self];
    } else {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePickerController setDelegate:self];
    }
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self setEnableSheet:NO];
    [picker dismissViewControllerAnimated:YES completion:^(void) {
        SNPhotoViewController *photoViewController = (SNPhotoViewController *)[[self storyboard] instantiateViewControllerWithIdentifier:@"SNPhotoViewController"];
        [[photoViewController imageView] setImage:image];
        [self presentViewController:photoViewController animated:YES completion:^(void) {
            [self setEnableSheet:YES];
        }];
    }];
}

@end
