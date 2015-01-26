//
//  UIBezierPath+LxThroughPointsBezier.m
//  LxThroughPointsBezierDemo
//

#import "UIBezierPath+LxThroughPointsBezier.h"
#import <objc/runtime.h>

@implementation UIBezierPath (LxThroughPointsBezier)

- (void)setContractionFactor:(CGFloat)contractionFactor
{
    objc_setAssociatedObject(self, @selector(contractionFactor), @(contractionFactor), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)contractionFactor
{
    id contractionFactorAssociatedObject = objc_getAssociatedObject(self, @selector(contractionFactor));
    if (contractionFactorAssociatedObject == nil) {
        return 0.7;
    }
    return [contractionFactorAssociatedObject floatValue];
}

- (void)addCurvesThroughPoints:(NSArray *)pointArray
{
    if (pointArray.count < 4) {

        NSAssert(pointArray.count >= 2, @"You must give at least 2 point for drawing the curve.");
        
        if (pointArray.count == 2) {
            
            NSValue * point0Value = pointArray[0];
            CGPoint point0 = [point0Value CGPointValue];
            NSValue * point1Value = pointArray[1];
            CGPoint point1 = [point1Value CGPointValue];
            
            [self moveToPoint:point0];
            [self addLineToPoint:point1];
        }
        else if (pointArray.count == 3) {
            
            NSValue * point0Value = pointArray[0];
            CGPoint point0 = [point0Value CGPointValue];
            NSValue * point1Value = pointArray[1];
            CGPoint point1 = [point1Value CGPointValue];
            NSValue * point2Value = pointArray[2];
            CGPoint point2 = [point2Value CGPointValue];
            
            [self moveToPoint:point0];
            [self addQuadCurveToPoint:point2 controlPoint:controlPointThatBezierPathCanThroughThe3Point(point0, point1, point2)];
        }
        else {
            
        }
        return;
    }
    
    CGFloat contractionFactor = MAX(0, self.contractionFactor);
    
    CGPoint previousPoint = CGPointZero;
    CGPoint previousPreviousPoint = CGPointZero;
    
    CGPoint centerPoint1 = CGPointZero;
    CGPoint centerPoint2 = CGPointZero;
    CGFloat centerPointDistance = 0;
    
    CGFloat obliqueRatio = 0;
    CGFloat obliqueAngle = 0;
    
    CGPoint controlPoint1 = CGPointZero;
    CGPoint controlPoint2 = CGPointZero;
    
    CGPoint previousControlPoint2 = CGPointZero;
    
    for (int i = 0; i < pointArray.count; i++) {
        
        NSValue * pointValue = pointArray[i];
        CGPoint point = [pointValue CGPointValue];
        
        if (i == 2) {
            centerPoint1 = CGPointMake((previousPreviousPoint.x + previousPoint.x) / 2, (previousPreviousPoint.y + previousPoint.y) / 2);
            centerPoint2 = CGPointMake((previousPoint.x + point.x) / 2, (previousPoint.y + point.y) / 2);
            
            centerPointDistance = distanceBetweenPoint(centerPoint1, centerPoint2);
            
            if (centerPoint1.x != centerPoint2.x) {
                obliqueRatio = (centerPoint2.y - centerPoint1.y) / (centerPoint2.x - centerPoint1.x);
                obliqueAngle = atan(obliqueRatio);
            }
            else {
                obliqueAngle = M_PI_2;
            }
            
            controlPoint1 = CGPointMake(previousPoint.x - 0.5 * contractionFactor * centerPointDistance * cos(obliqueAngle), previousPoint.y - 0.5 * centerPointDistance * sin(obliqueAngle));
            controlPoint2 = CGPointMake(previousPoint.x + 0.5 * contractionFactor * centerPointDistance * cos(obliqueAngle), previousPoint.y + 0.5 * centerPointDistance * sin(obliqueAngle));
            
            [self moveToPoint:previousPreviousPoint];
            [self addQuadCurveToPoint:previousPoint controlPoint:controlPoint1];
            
            previousControlPoint2 = controlPoint2;
        }
        else if (i > 2 && i < pointArray.count - 1) {
            centerPoint1 = CGPointMake((previousPreviousPoint.x + previousPoint.x) / 2, (previousPreviousPoint.y + previousPoint.y) / 2);
            centerPoint2 = CGPointMake((previousPoint.x + point.x) / 2, (previousPoint.y + point.y) / 2);
            
            centerPointDistance = distanceBetweenPoint(centerPoint1, centerPoint2);
            
            if (centerPoint1.x != centerPoint2.x) {
                obliqueRatio = (centerPoint2.y - centerPoint1.y) / (centerPoint2.x - centerPoint1.x);
                obliqueAngle = atan(obliqueRatio);
            }
            else {
                obliqueAngle = M_PI_2;
            }
            
            controlPoint1 = CGPointMake(previousPoint.x - 0.5 * contractionFactor * centerPointDistance * cos(obliqueAngle), previousPoint.y - 0.5 * centerPointDistance * sin(obliqueAngle));
            controlPoint2 = CGPointMake(previousPoint.x + 0.5 * contractionFactor * centerPointDistance * cos(obliqueAngle), previousPoint.y + 0.5 * centerPointDistance * sin(obliqueAngle));
            
            [self moveToPoint:previousPreviousPoint];
            [self addCurveToPoint:previousPoint controlPoint1:previousControlPoint2 controlPoint2:controlPoint1];
            
            previousControlPoint2 = controlPoint2;
        }
        else if (i == pointArray.count - 1) {
            centerPoint1 = CGPointMake((previousPreviousPoint.x + previousPoint.x) / 2, (previousPreviousPoint.y + previousPoint.y) / 2);
            centerPoint2 = CGPointMake((previousPoint.x + point.x) / 2, (previousPoint.y + point.y) / 2);
            
            centerPointDistance = distanceBetweenPoint(centerPoint1, centerPoint2);
            
            if (centerPoint1.x != centerPoint2.x) {
                obliqueRatio = (centerPoint2.y - centerPoint1.y) / (centerPoint2.x - centerPoint1.x);
                obliqueAngle = atan(obliqueRatio);
            }
            else {
                obliqueAngle = M_PI_2;
            }
            
            controlPoint1 = CGPointMake(previousPoint.x - 0.5 * contractionFactor * centerPointDistance * cos(obliqueAngle), previousPoint.y - 0.5 * centerPointDistance * sin(obliqueAngle));
            controlPoint2 = CGPointMake(previousPoint.x + 0.5 * contractionFactor * centerPointDistance * cos(obliqueAngle), previousPoint.y + 0.5 * centerPointDistance * sin(obliqueAngle));
            
            [self moveToPoint:previousPreviousPoint];
            [self addCurveToPoint:previousPoint controlPoint1:previousControlPoint2 controlPoint2:controlPoint1];
            [self addQuadCurveToPoint:point controlPoint:controlPoint2];
        }
        else {
            
        }
        
        previousPreviousPoint = previousPoint;
        previousPoint = point;
    }
}

CGPoint controlPointThatBezierPathCanThroughThe3Point(CGPoint point1, CGPoint point2, CGPoint point3)
{
    return CGPointMake(2 * point2.x - (point1.x + point3.x) / 2, 2 * point2.y - (point1.y + point3.y) / 2);
}

CGFloat distanceBetweenPoint(CGPoint point1, CGPoint point2)
{
    return sqrt((point1.x - point2.x) * (point1.x - point2.x) + (point1.y - point2.y) * (point1.y - point2.y));
}

@end
