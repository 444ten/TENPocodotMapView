//
//  TENNavMapViewController.m
//  TENPocodotMapView
//
//  Created by 444ten on 1/5/16.
//  Copyright © 2016 444ten. All rights reserved.
//

#import "TENNavMapViewController.h"
#import "TENNavGroupSizeViewController.h"

static const CLLocationDegrees  kDefaultLatitude    = 50.44;
static const CLLocationDegrees  kDefaultLongitude   = 30.60;
static const float              kDefaultZoom        = 15.0;


@interface TENNavMapViewController ()
- (void)setupMapView;
- (void)presentGroupSizeViewController;
@end

@implementation TENNavMapViewController {

}

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMapView];
    [self presentGroupSizeViewController];
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onGroupSize:(UIButton *)sender {
    [self presentGroupSizeViewController];
}

#pragma mark -
#pragma mark Private Methods

- (void)setupMapView {
    self.mapView.camera = [GMSCameraPosition cameraWithLatitude:kDefaultLatitude
                                                      longitude:kDefaultLongitude
                                                           zoom:kDefaultZoom];
}

- (void)presentGroupSizeViewController {
    TENNavGroupSizeViewController *groupSizeController = [TENNavGroupSizeViewController new];
    groupSizeController.delegate = self;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: groupSizeController];
    navigationController.navigationBarHidden = YES;
    navigationController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    [self presentViewController:navigationController animated:NO completion:nil];
}

#pragma mark -
#pragma mark TENNavMapViewDelegate

- (void)scrollByX:(CGFloat)dX Y:(CGFloat)dY {
    [self.mapView moveCamera:[GMSCameraUpdate scrollByX:dX Y:dY]];
}

- (void)bearing:(CLLocationDirection)degree {
    GMSMapView *mapView = self.mapView;
    
    GMSMutableCameraPosition *camera = mapView.camera.mutableCopy;
    camera.bearing += degree;
    
    mapView.camera = camera;
}

@end








