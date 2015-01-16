//
//  ViewController.m
//  LxThroughPointsBezierDemo
//

#import "ViewController.h"
#import "UIBezierPath+LxThroughPointsBezier.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UIBezierPath * _curve;
    CAShapeLayer * _shapeLayer;
    NSMutableArray * _pointArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGPoint point1 = CGPointMake(30, 180);
    CGPoint point2 = CGPointMake(90, 120);
    CGPoint point3 = CGPointMake(120, 200);
    CGPoint point4 = CGPointMake(160, 240);
    CGPoint point5 = CGPointMake(210, 160);
    CGPoint point6 = CGPointMake(240, 300);
    CGPoint point7 = CGPointMake(290, 140);
    
    NSValue * point1Value = [NSValue valueWithCGPoint:point1];
    NSValue * point2Value = [NSValue valueWithCGPoint:point2];
    NSValue * point3Value = [NSValue valueWithCGPoint:point3];
    NSValue * point4Value = [NSValue valueWithCGPoint:point4];
    NSValue * point5Value = [NSValue valueWithCGPoint:point5];
    NSValue * point6Value = [NSValue valueWithCGPoint:point6];
    NSValue * point7Value = [NSValue valueWithCGPoint:point7];
    
    _pointArray = [NSMutableArray array];
    [_pointArray addObjectsFromArray:@[point1Value, point2Value, point3Value, point4Value, point5Value, point6Value, point7Value]];
    
    _curve = [UIBezierPath bezierPath];
    [_curve addCurvesThroughPoints:_pointArray];
    
    [self drawPoint:point1];
    [self drawPoint:point2];
    [self drawPoint:point3];
    [self drawPoint:point4];
    [self drawPoint:point5];
    [self drawPoint:point6];
    [self drawPoint:point7];
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    _shapeLayer.fillColor = nil;
    _shapeLayer.lineWidth = 3;
    _shapeLayer.path = _curve.CGPath;
    [self.view.layer addSublayer:_shapeLayer];
    
    UISlider * slider = [[UISlider alloc]initWithFrame:CGRectMake(20, 84, 280, 6)];
    slider.minimumValue = 0;
    slider.maximumValue = 1.4;
    slider.value = 0.7;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

- (void)drawPoint:(CGPoint)point
{
    CALayer * pointLayer = [CALayer layer];
    pointLayer.bounds = CGRectMake(0, 0, 10, 10);
    pointLayer.cornerRadius = 5;
    pointLayer.position = point;
    pointLayer.backgroundColor = [UIColor magentaColor].CGColor;
    pointLayer.opaque = YES;
    [self.view.layer addSublayer:pointLayer];
}

- (void)sliderValueChanged:(UISlider *)slider
{
    [_curve removeAllPoints];
    _curve.contractionFactor = slider.value;
    [_curve addCurvesThroughPoints:_pointArray];
    
    _shapeLayer.path = _curve.CGPath;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
