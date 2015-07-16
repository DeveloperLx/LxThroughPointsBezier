//
//  ViewController.m
//  LxThroughPointsBezierDemo
//

#import "ViewController.h"
#import "PointView.h"
#import "UIBezierPath+LxThroughPointsBezier.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UIBezierPath * _curve;
    CAShapeLayer * _shapeLayer;
    NSMutableArray * _pointViewArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISlider * slider = [[UISlider alloc]init];
    slider.minimumValue = 0;
    slider.maximumValue = 1.4;
    slider.value = 0.7;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
    slider.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray * sliderHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[slider]-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(slider)];
    NSArray * sliderVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topMargin-[slider(==sliderHeight)]" options:NSLayoutFormatDirectionLeadingToTrailing metrics:@{@"sliderHeight":@6, @"topMargin":@60} views:NSDictionaryOfVariableBindings(slider)];
    [self.view addConstraints:sliderHorizontalConstraints];
    [self.view addConstraints:sliderVerticalConstraints];

    
    _pointViewArray = [[NSMutableArray alloc]init];
    
    NSMutableArray * pointValueArray = [NSMutableArray array];
    
    ViewController * __weak weakSelf = self;
    
    for (int i = 0; i < 6; i++) {
        
        PointView * pointView = [PointView aInstance];
        
        pointView.center = CGPointMake(i * 60 + 30, 420);
        pointView.dragCallBack = ^(PointView * pv){
        
            ViewController * __strong strongSelf = weakSelf;
            [strongSelf sliderValueChanged:slider];
        };
        
        [self.view addSubview:pointView];
        [_pointViewArray addObject:pointView];
        
        [pointValueArray addObject:[NSValue valueWithCGPoint:pointView.center]];
    }
    
    NSValue * firstPointValue = pointValueArray.firstObject;
    
    _curve = [UIBezierPath bezierPath];
    [_curve moveToPoint:firstPointValue.CGPointValue];
    [_curve addBezierThroughPoints:pointValueArray];
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    _shapeLayer.fillColor = nil;
    _shapeLayer.lineWidth = 3;
    _shapeLayer.path = _curve.CGPath;
    _shapeLayer.lineCap = kCALineCapRound;
    [self.view.layer addSublayer:_shapeLayer];
}

- (void)sliderValueChanged:(UISlider *)slider
{
    [_curve removeAllPoints];
    _curve.contractionFactor = slider.value;
    
    PointView * firstPointView = _pointViewArray.firstObject;
    
    [_curve moveToPoint:firstPointView.center];
    
    NSMutableArray * pointValueArray = [NSMutableArray array];
    for (PointView * pointView in _pointViewArray) {
        
        [pointValueArray addObject:[NSValue valueWithCGPoint:pointView.center]];
    }
    [_curve addBezierThroughPoints:pointValueArray];
    
    _shapeLayer.path = _curve.CGPath;
}

@end
