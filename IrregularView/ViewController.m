//
//  ViewController.m
//  IrregularImages
//
//  Created by OranWu on 13-4-10.
//  Copyright (c) 2013年 Oran Wu. All rights reserved.
//

#import "ViewController.h"
#import "IrregularView.h"

@interface ViewController (){
    IrregularView *irregular;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    irregular = [[IrregularView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    [self.view addSubview:irregular];
    irregular.image = [UIImage imageNamed:@"2013011.jpg"];
    
    [irregular setMask];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    [irregular addGestureRecognizer:tap];
}

- (void)tapImage:(UITapGestureRecognizer *)tapGestrue{
    CGPoint tapPoint = [tapGestrue locationInView:tapGestrue.view];
    NSLog(@"%@",irregular.tempPath);
    if ([irregular.tempPath containsPoint:tapPoint]) {
        NSLog(@"点击图片：");
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
