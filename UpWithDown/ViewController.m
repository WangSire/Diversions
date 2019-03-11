//
//  ViewController.m
//  UpWithDown
//
//  Created by Siri on 2019/3/9.
//  Copyright © 2019年 Siri. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
#import "MainViewController.h"

@interface ViewController ()
{
    NSArray *dataArray;
    NSInteger index;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CustomView *custView = [[CustomView alloc]initWithFrame:CGRectMake(50, 100, 250, 50)];
    custView.tag = 10086;
    [self.view addSubview:custView];
    
    dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self presentViewController:[MainViewController new] animated:YES completion:^{
        CustomView *cView = [self.view viewWithTag:10086];
        [cView endAnimation];
    }];
    
//    从dataArr中循环获取四个数
//    [self getFourAtTime];
}
-(void)getFourAtTime{
    NSString *str = @"";
    for (int i = 0; i<4; i++) {
        str = [str stringByAppendingString:dataArray[index % dataArray.count]];
        index++;
    }
    NSLog(@"%@",str);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
