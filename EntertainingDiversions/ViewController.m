//
//  ViewController.m
//  EntertainingDiversions
//
//  Created by Siri on 2019/3/8.
//  Copyright © 2019年 Siri. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    dispatch_source_t _timer;
}
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray *dataArr;
@property (nonatomic ,assign)NSInteger index;
@property (nonatomic ,assign)BOOL isRefresh;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(50, 100, 250, 90)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 30;
    [self.view addSubview:self.tableView];
    self.index = 0;
    //[self openTimer];
    
    
}

-(void)openTimer{
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            if (self.index == self.dataArr.count - 3) {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                [self.dataArr addObjectsFromArray:self.dataArr];
                [self.tableView reloadData];
            }else{
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        
        self.index+=1;
    }];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
//    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
//    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
//    dispatch_source_set_event_handler(_timer, ^{
//        self.index+=1;
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            if (self.index == self.dataArr.count - 3) {
//
//                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//                [self.dataArr addObjectsFromArray:self.dataArr];
//                [self.tableView reloadData];
//            }else{
//                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//            }
//
//        });
//    });
//    dispatch_resume(_timer);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.textColor = [UIColor redColor];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [@[@"0",@"1",@"2",@"3",@"4",@"5",@"6"] mutableCopy];
    }
    return _dataArr;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    static int i = 0;
    i++;
    if (i == self.dataArr.count - 3) {
        [self.dataArr addObjectsFromArray:self.dataArr];
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }else{
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
