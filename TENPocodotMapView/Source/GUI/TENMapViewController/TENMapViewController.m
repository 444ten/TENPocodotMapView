//
//  TENMapViewController.m
//  TENPocodotMapView
//
//  Created by 444ten on 1/4/16.
//  Copyright © 2016 444ten. All rights reserved.
//

#import "TENMapViewController.h"

#import "TENBottomConfirmViewController.h"
#import "TENBottomGroupSizeViewController.h"

static const CGFloat TENGroupSizeViewHeight = 250.0;
static const CGFloat TENConfirmViewHeight = 150.0;

@interface TENMapViewController ()
@property (nonatomic, strong)   TENBottomGroupSizeViewController    *groupSizeViewController;
@property (nonatomic, strong)   TENBottomConfirmViewController      *confirmViewController;

@property (nonatomic, assign)   BOOL    bottomControllerPresent;

- (void)hideChildViews;
- (void)showChildViews;

- (void)displayContentController:(UIViewController*)content;

- (void)cycleFromViewController:(UIViewController *)oldVC
               toViewController:(UIViewController *)newVC;

- (void)changeFromViewController:(UIViewController *)oldVC
                 withOldVCHeight:(CGFloat)oldVCHeight
                toViewController:(UIViewController *)newVC
                 withNewVCHeight:(CGFloat)newVCHeight;

@end

@implementation TENMapViewController

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.groupSizeViewController = [TENBottomGroupSizeViewController new];
    self.confirmViewController = [TENBottomConfirmViewController new];
    
    self.bottomControllerPresent = NO;
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onGroupSize:(UIButton *)sender {
    if (self.bottomControllerPresent) {
        [self changeFromViewController:self.confirmViewController
                       withOldVCHeight:TENConfirmViewHeight
                      toViewController:self.groupSizeViewController
                       withNewVCHeight:TENGroupSizeViewHeight];
    } else {
        [self displayContentController:self.groupSizeViewController];
        self.bottomControllerPresent = YES;
    }
}

- (IBAction)onConfirm:(UIButton *)sender {
    if (self.bottomControllerPresent) {
        [self changeFromViewController:self.groupSizeViewController
                       withOldVCHeight:TENGroupSizeViewHeight
                      toViewController:self.confirmViewController
                       withNewVCHeight:TENConfirmViewHeight];
    } else {
        [self displayContentController:self.confirmViewController];
        self.bottomControllerPresent = YES;
    }
}

- (IBAction)onHideChildViews:(UIButton *)sender {
    [self hideChildViews];
}

- (IBAction)onShowChildViews:(id)sender {
    [self showChildViews];
}

#pragma mark -
#pragma mark Private Methods

- (void)displayContentController:(UIViewController*)content {
    [self addChildViewController:content];

//    content.view.frame = [self frameForContentController];
//    [self.view addSubview:self.currentClientView];
    
    [content didMoveToParentViewController:self];
}

- (void)changeFromViewController:(UIViewController *)oldVC
                 withOldVCHeight:(CGFloat)oldVCHeight
                toViewController:(UIViewController *)newVC
                 withNewVCHeight:(CGFloat)newVCHeight
{
    [oldVC willMoveToParentViewController:nil];
    [self addChildViewController:newVC];
    
    newVC.view.frame = CGRectMake(0, 1000, 375, newVCHeight);
    CGRect endFrame = CGRectMake(0, 1000, 375, oldVCHeight);
    
    // Queue up the transition animation.
    [self transitionFromViewController: oldVC toViewController: newVC
                              duration: 0.25 options:0
                            animations:^{
                                // Animate the views to their final positions.
                                newVC.view.frame = CGRectMake(0, 667-newVCHeight, 375, newVCHeight);
                                oldVC.view.frame = endFrame;
                            }
                            completion:^(BOOL finished) {
                                // Remove the old view controller and send the final
                                // notification to the new view controller.
                                [oldVC removeFromParentViewController];
                                [newVC didMoveToParentViewController:self];
                            }];
}


- (void)cycleFromViewController:(UIViewController*)oldVC
               toViewController:(UIViewController*)newVC
{
    // Prepare the two view controllers for the change.
    [oldVC willMoveToParentViewController:nil];
    [self addChildViewController:newVC];
    
    // Get the start frame of the new view controller and the end frame
    // for the old view controller. Both rectangles are offscreen.
//    newVC.view.frame = [self newViewStartFrame];
//    CGRect endFrame = [self oldViewEndFrame];
    newVC.view.frame = CGRectMake(0, 1000, 375, 150);
    CGRect endFrame = CGRectMake(0, 1000, 375, 150);;
    
    // Queue up the transition animation.
    [self transitionFromViewController: oldVC
                      toViewController: newVC
                              duration: 0.25
                               options:0
                            animations:^{
                                // Animate the views to their final positions.
                                newVC.view.frame = oldVC.view.frame;
                                oldVC.view.frame = endFrame;
                            }
                            completion:^(BOOL finished) {
                                // Remove the old view controller and send the final
                                // notification to the new view controller.
                                [oldVC removeFromParentViewController];
                                [newVC didMoveToParentViewController:self];
                            }];
}



- (void)hideChildViews {
    CGRect endFrame = self.bottomView.frame;
    endFrame.origin.y += endFrame.size.height;
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.bottomView.frame = endFrame;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)showChildViews {
    CGRect endFrame = self.bottomView.frame;
    endFrame.origin.y -= endFrame.size.height;
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.bottomView.frame = endFrame;
                     }];
}


@end
