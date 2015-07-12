//
//  PointView.h
//  LxThroughPointsBezierDemo
//

#import <UIKit/UIKit.h>

@interface PointView : UIControl

+ (PointView *)aInstance;

@property (nonatomic,copy) void (^dragCallBack)(PointView * pointView);

@end
