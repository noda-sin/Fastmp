//
//  SNPhotoViewController.m
//  Fastamp
//
//  Created by Noda Shimpei on 2013/06/14.
//  Copyright (c) 2013年 Noda Shimpei. All rights reserved.
//

#import "SNPhotoViewController.h"

@interface SNPhotoViewController ()

- (IBAction)dissmissView:(id)sender;

@end

@implementation SNPhotoViewController

- (IBAction)dissmissView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
