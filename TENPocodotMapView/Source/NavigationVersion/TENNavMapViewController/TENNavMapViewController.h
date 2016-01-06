//
//  TENNavMapViewController.h
//  TENPocodotMapView
//
//  Created by 444ten on 1/5/16.
//  Copyright © 2016 444ten. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GoogleMaps;

@protocol TENNavMapViewDelegate <NSObject>
- (void)scrollByX:(CGFloat)dX Y:(CGFloat)dY;
- (void)bearing:(CLLocationDirection)degree;

@end

@interface TENNavMapViewController : UIViewController <TENNavMapViewDelegate>
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;

@end
