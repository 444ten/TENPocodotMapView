//
//  TENNavGroupSizeViewController.m
//  TENPocodotMapView
//
//  Created by 444ten on 1/5/16.
//  Copyright © 2016 444ten. All rights reserved.
//

#import "TENNavGroupSizeViewController.h"
#import "TENNavConfirmViewController.h"

@interface TENNavGroupSizeViewController ()

@end

@implementation TENNavGroupSizeViewController

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)onGroupSize:(UIButton *)sender {
    TENNavConfirmViewController *confirmViewController = [TENNavConfirmViewController new];
    confirmViewController.delegate = self.delegate;
    
    [self.navigationController pushViewController:confirmViewController animated:NO];
}

@end
