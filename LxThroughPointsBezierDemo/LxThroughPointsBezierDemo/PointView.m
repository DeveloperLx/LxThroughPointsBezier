//
//  PointView.m
//  LxThroughPointsBezierDemo
//

#import "PointView.h"

static CGFloat const RADIUS = 5;

@implementation PointView

+ (PointView *)aInstance
{
    PointView * aInstance = [[self alloc]initWithFrame:(CGRect){CGPointZero, CGSizeMake(RADIUS * 2, RADIUS * 2)}];
    aInstance.layer.cornerRadius = RADIUS;
    aInstance.layer.masksToBounds = YES;
    aInstance.backgroundColor = [UIColor magentaColor];
    [aInstance addTarget:aInstance action:@selector(touchDragInside:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    
    return aInstance;
}

- (void)touchDragInside:(PointView *)pointView withEvent:(UIEvent *)event
{
    pointView.center = [[[event allTouches]anyObject] locationInView:self.superview];
    
    if (self.dragCallBack) {
        self.dragCallBack(self);
    }
}

@end
