//
//  PDTMapDirectViewController.m
//  TENPocodotMapView
//
//  Created by 444ten on 1/6/16.
//  Copyright © 2016 444ten. All rights reserved.
//

#import "PDTMapDirectViewController.h"

@interface PDTMapDirectViewController ()
- (CGFloat)angleBetweenLinesInRadians:(CGPoint)line1Start
                             line1End:(CGPoint)line1End
                           line2Start:(CGPoint)line2Start
                             line2End:(CGPoint)line2End;
@end

@implementation PDTMapDirectViewController

#pragma mark -
#pragma mark UIResponder

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UIView *mainView = self.view;
    NSArray *allTouches = [event allTouches].allObjects;
    
    if (allTouches.count == 1) {
        UITouch *touch = allTouches[0];
        
        CGPoint previousLocation = [touch previousLocationInView:mainView];
        CGPoint touchLocation = [touch locationInView:mainView];
        
        CGFloat deltaX = previousLocation.x - touchLocation.x;
        CGFloat deltaY = previousLocation.y - touchLocation.y;
        
//        NSLog(@"%.0f - %.0f", deltaX, deltaY);
        
        [self.delegate scrollByX:deltaX Y:deltaY];
    } else if (allTouches.count == 2) {
        UITouch *first = allTouches[0];
        UITouch *second = allTouches[1];
        
        CGFloat currentAngle = [self angleBetweenLinesInRadians:[first previousLocationInView:mainView]
                                                       line1End:[second previousLocationInView:mainView]
                                                     line2Start:[first locationInView:mainView]
                                                       line2End:[second locationInView:mainView]];
        
        currentAngle = currentAngle * 180 / M_PI;
        [self.delegate bearing:currentAngle];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
}

- (void)touchesCancelled:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
}

#pragma mark -
#pragma mark Private Methods

- (CGFloat)angleBetweenLinesInRadians:(CGPoint)line1Start
                             line1End:(CGPoint)line1End
                           line2Start:(CGPoint)line2Start
                             line2End:(CGPoint)line2End
{
    CGFloat a = line1End.x - line1Start.x;
    CGFloat b = line1End.y - line1Start.y;
    CGFloat c = line2End.x - line2Start.x;
    CGFloat d = line2End.y - line2Start.y;
    
    CGFloat line1Slope = (line1End.y - line1Start.y) / (line1End.x - line1Start.x);
    CGFloat line2Slope = (line2End.y - line2Start.y) / (line2End.x - line2Start.x);
    
    CGFloat degs = acosf(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
    
    return (line2Slope > line1Slope) ? -degs : degs;
}

@end
