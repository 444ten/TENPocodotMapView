//
//  TENNavConfirmViewController.m
//  TENPocodotMapView
//
//  Created by 444ten on 1/6/16.
//  Copyright © 2016 444ten. All rights reserved.
//

#import "TENNavConfirmViewController.h"
#import "TENNavContactViewController.h"

@interface TENNavConfirmViewController ()

@end

@implementation TENNavConfirmViewController

#pragma mark -
#pragma mark Interaface Handling

- (IBAction)onBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)onContact:(UIButton *)sender {
    TENNavContactViewController *contactViewController = [TENNavContactViewController new];
    contactViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    [self presentViewController:contactViewController animated:NO completion:nil];
}

- (IBAction)onConfirm:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
