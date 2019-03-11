//
//  TestView.m
//  EntertainingDiversions
//
//  Created by Siri on 2019/3/8.
//  Copyright © 2019年 Siri. All rights reserved.
//

#import "TestView.h"

@implementation TestView

-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    NSLog(@"%@",newSuperview);
    if (newSuperview) {
        newSuperview.backgroundColor = [UIColor redColor];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
