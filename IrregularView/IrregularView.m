//
//  IrregularView.m
//  IrregularImages
//
//  Created by OranWu on 13-4-10.
//  Copyright (c) 2013年 Oran Wu. All rights reserved.
//

#import "IrregularView.h"
@interface IrregularView ()
@end

@implementation IrregularView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setMask{
    self.tempPath = [[UIBezierPath alloc] init];
    
    
    //bellow is the way to get a UIBezierPath with self.trackPoints
#warning But how to make round corner, I'm thinking, if you have good idea, pls tell me, thank you.
//    //=========================================================================
//    //save CGPoint
//    //[self.trackPoints addObject:[NSValue valueWithCGPoint:point]];
//    for (int i=0; i<[self.trackPoints count]; i++) {
//        //get CGPoint
//        CGPoint point = [[self.trackPoints objectAtIndex:i] CGPointValue];
//        if (i==0) {
//            [self.tempPath moveToPoint:point];
//        }else{
//            [self.tempPath addLineToPoint:point];
//        }
//        if (i==[self.trackPoints count]-1) {
//            [self.tempPath closePath];
//        }
//    }
//    //=========================================================================

    [self.tempPath moveToPoint:CGPointMake(160, 260)];
    [self.tempPath addLineToPoint:CGPointMake(160, 260)];
    //=========================================================================
    //不加圆角
    /*[self.tempPath addLineToPoint:CGPointMake(240-80*(4-16/5)/4, 200-60*(3-12/5)/3)];*/
    //加圆角
    [self.tempPath addLineToPoint:CGPointMake(240-80*(4-16/5)/4, 200+60*(3-12/5)/3)];
    [self.tempPath addQuadCurveToPoint:CGPointMake(240-80*(4-16/5)/4, 200-60*(3-12/5)/3) controlPoint:CGPointMake(250, 200)];
    //[self.tempPath addLineToPoint:CGPointMake(240-80*(4-16/5)/4, 200-60*(3-12/5)/3)];
    //=========================================================================
    [self.tempPath addLineToPoint:CGPointMake(160, 140)];
    [self.tempPath closePath];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [self.tempPath CGPath];
    maskLayer.fillColor = [[UIColor whiteColor] CGColor];
    maskLayer.frame = self.frame;
    
    self.layer.mask = maskLayer;
    
    CAShapeLayer *maskBorderLayer = [CAShapeLayer layer];
    maskBorderLayer.path = [self.tempPath CGPath];
    maskBorderLayer.fillColor = [[UIColor clearColor] CGColor];
    maskBorderLayer.strokeColor = [[UIColor blueColor] CGColor];
    maskBorderLayer.lineWidth = 5;
    [self.layer addSublayer:maskBorderLayer];

}

@end
