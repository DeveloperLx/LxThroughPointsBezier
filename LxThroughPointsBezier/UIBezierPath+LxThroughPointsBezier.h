//
//  UIBezierPath+LxThroughPointsBezier.h
//  LxThroughPointsBezierDemo
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (LxThroughPointsBezier)

/**
 *  The curve‘s bend level. The good value is about 0.6 ~ 0.8. The default and recommended value is 0.7.
 */
@property (nonatomic) CGFloat contractionFactor;

/**
 *  You must wrap CGPoint struct to NSValue object.
 *
 *  @param pointArray Points you want to through. You must give at least 1 point for drawing curve.
 */
- (void)addBezierThroughPoints:(NSArray *)pointArray;

@end
