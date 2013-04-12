//
//  ViewController.m
//  IrregularImages
//
//  Created by OranWu on 13-4-10.
//  Copyright (c) 2013年 Oran Wu. All rights reserved.
//

#import "ViewController.h"
#import "IrregularView.h"
#import "PointsView.h"

@interface ViewController (){
    IrregularView *irregular;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    irregular = [[IrregularView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    irregular.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:irregular];
//    irregular.image = [UIImage imageNamed:@"2013011.jpg"];
    irregular.font = [UIFont fontWithName:@"Cochin-Bold" size:170];
    irregular.textColor = [UIColor redColor];
    irregular.text = @" VS";
    irregular.trackPoints = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(40+10, 80)],
                             [NSValue valueWithCGPoint:CGPointMake(160+10, 250)],
                             [NSValue valueWithCGPoint:CGPointMake(280+10, 80)],
                             [NSValue valueWithCGPoint:CGPointMake(240+10, 30)],
                             [NSValue valueWithCGPoint:CGPointMake(80+10, 30)],
                             nil];
    irregular.cornerRadius = 3;
    irregular.borderWidth  = 10;
    irregular.borderColor  = [UIColor redColor];
    [irregular setMask];
    
    CGPoint center =self.view.center;
    center.x = center.x-10;
    irregular.center = center;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    [irregular addGestureRecognizer:tap];
    
//    PointsView *pointView = [[PointsView alloc] initWithFrame:CGRectMake(10, 200, 300, 200)];
//    pointView.trackPoints = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(40, 120)],
//                             [NSValue valueWithCGPoint:CGPointMake(150, 190)],
//                             [NSValue valueWithCGPoint:CGPointMake(280, 100)],
//                             [NSValue valueWithCGPoint:CGPointMake(280, 50)],
//                             [NSValue valueWithCGPoint:CGPointMake(150, 50)],
//                             nil];
//    [self.view addSubview:pointView];
}

- (void)tapImage:(UITapGestureRecognizer *)tapGestrue{
    CGPoint tapPoint = [tapGestrue locationInView:tapGestrue.view];
    if ([irregular.tempPath containsPoint:tapPoint]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"點到勒"
                                                       delegate:self
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

//点击时判断 点击的点在不在 UIBezierPath 这个不规则图形内
- (BOOL)point:(CGPoint)point Inside:(UIBezierPath *)path{
    return [path containsPoint:point];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
