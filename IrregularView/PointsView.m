//
//  PointsView.m
//  IrregularView
//
//  Created by OranWu on 13-4-10.
//  Copyright (c) 2013年 Oran Wu. All rights reserved.
//

#import "PointsView.h"

@implementation PointsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);

    NSMutableArray *muaarray = [NSMutableArray array];
    float cornerRadius = 2;
    for (int i=0; i < [self.trackPoints count]; i++) {
        CGPoint pointStart, pointEnd;
        if (i<[self.trackPoints count]-1) {
            pointStart = [[self.trackPoints objectAtIndex:i] CGPointValue];
            pointEnd = [[self.trackPoints objectAtIndex:i+1] CGPointValue];
        }else if (i==[self.trackPoints count]-1) {
            pointStart = [[self.trackPoints objectAtIndex:i] CGPointValue];
            pointEnd = [[self.trackPoints objectAtIndex:0] CGPointValue];
        }
        [muaarray addObject:[NSValue valueWithCGPoint:pointStart]];

        if (pointStart.x == pointEnd.x) {
            BOOL boolY = pointEnd.y-pointStart.y>0;
            pointStart.y = pointStart.y + cornerRadius*(boolY? 1 : -1);
            pointEnd.y = pointEnd.y - cornerRadius*(boolY? 1 : -1);

        }else if (pointStart.y == pointEnd.y){
            BOOL boolX = pointEnd.x-pointStart.x>0;
            pointStart.x = pointStart.x + cornerRadius*(boolX? 1 : -1);
            pointEnd.x = pointEnd.x - cornerRadius*(boolX? 1 : -1);
        }else{
            float tempL = (pointEnd.y-pointStart.y)/(pointEnd.x-pointStart.x);
            float cutX = sqrtf(cornerRadius*cornerRadius/(1+tempL*tempL));
            float cutY = fabsf(cutX*tempL);
            
            BOOL boolX = pointEnd.x-pointStart.x>0;
            BOOL boolY = pointEnd.y-pointStart.y>0;
            
            pointStart.x = pointStart.x + cutX*(boolX? 1 : -1);
            pointStart.y = pointStart.y + cutY*(boolY? 1 : -1);
            pointEnd.x = pointEnd.x - cutX*(boolX? 1 : -1);
            pointEnd.y = pointEnd.y - cutY*(boolY? 1 : -1);
        }
        [muaarray addObject:[NSValue valueWithCGPoint:pointStart]];
        [muaarray addObject:[NSValue valueWithCGPoint:pointEnd]];
    }
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 1; i<[muaarray count]; i=i+3) {
        CGPoint firstP;
        CGPoint nextP;
        CGPoint middle;
        CGPoint pointP;
        if (i<[muaarray count]-3) {
            firstP = [[muaarray objectAtIndex:i+1] CGPointValue];
            nextP  = [[muaarray objectAtIndex:i+3] CGPointValue];
            pointP  = [[muaarray objectAtIndex:i+2] CGPointValue];
            middle = CGPointMake((firstP.x+nextP.x)/2, (firstP.y+nextP.y)/2);
            //CGContextFillRect (context, CGRectMake(middle.x, middle.y, 1, 1));
        }else if (i==[muaarray count]-2){
            firstP = [[muaarray objectAtIndex:i+1] CGPointValue];
            nextP  = [[muaarray objectAtIndex:1] CGPointValue];
            pointP  = [[muaarray objectAtIndex:0] CGPointValue];
            middle = CGPointMake((firstP.x+nextP.x)/2, (firstP.y+nextP.y)/2);
        }
        //CGContextFillRect (context, CGRectMake(middle.x, middle.y, 1, 1));
        
        
        float PP = sqrtf((pointP.x-nextP.x)*(pointP.x-nextP.x) + (pointP.y-nextP.y)*(pointP.y-nextP.y));
        float PM = sqrtf((pointP.x-middle.x)*(pointP.x-middle.x) + (pointP.y-middle.y)*(pointP.y-middle.y));
        float P1M = sqrtf((firstP.x-middle.x)*(firstP.x-middle.x) + (firstP.y-middle.y)*(firstP.y-middle.y));
        
        float R = PP*P1M/PM;
        float OM = P1M*P1M/PM;
        float MN = R-OM;
        float PN = PM-MN;
        
        float offX = (middle.x-pointP.x)*PN/PM;
        float offY = (middle.y-pointP.y)*PN/PM;
        
        CGPoint finalP;
        finalP.x = pointP.x+offX;
        finalP.y = pointP.y+offY;
        
        //CGContextFillRect (context, CGRectMake(finalP.x, finalP.y, 1, 1));
        
        [arrayM addObject:[NSValue valueWithCGPoint:firstP]];
        [arrayM addObject:[NSValue valueWithCGPoint:finalP]];
        [arrayM addObject:[NSValue valueWithCGPoint:nextP]];
   
    }
    
    for (int i=0; i <[arrayM count]; i=i+3) {
        CGPoint pathPoint = [[arrayM objectAtIndex:i] CGPointValue];
        if (i==0) {
            CGContextMoveToPoint(context, pathPoint.x, pathPoint.y);
        }else{
            CGContextAddLineToPoint(context, pathPoint.x, pathPoint.y);
        }
        
        CGPoint cPoint = [[arrayM objectAtIndex:i+1] CGPointValue];
        CGPoint endPoint = [[arrayM objectAtIndex:i+2] CGPointValue];

        CGContextAddQuadCurveToPoint(context, cPoint.x, cPoint.y, endPoint.x, endPoint.y);
        if (i==[arrayM count]-3){
            pathPoint = [[arrayM objectAtIndex:0] CGPointValue];
            CGContextAddLineToPoint(context, pathPoint.x, pathPoint.y);
        }
    }
    CGContextDrawPath(context, kCGPathStroke);
}


@end















