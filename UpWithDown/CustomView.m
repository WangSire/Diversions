//
//  CustomView.m
//  UpWithDown
//
//  Created by Siri on 2019/3/9.
//  Copyright © 2019年 Siri. All rights reserved.
//

#import "CustomView.h"



@interface CustomView(){
    CGRect          _topRect; //上层坐标
    CGRect          _middleRect; //中间坐标
    CGRect          _btmRect; //底部坐标
    NSInteger       _indexNow; //索引
}


@property (nonatomic ,strong)UILabel *animationView1;
@property (nonatomic ,strong)UILabel *animationView2;

@property (nonatomic ,strong)UILabel *tmpTopView;
@property (nonatomic ,strong)UILabel *tmpBtmView;
@property (nonatomic ,strong)UILabel *tmpMiddleView;

@property (nonatomic ,strong)UIButton *button;
@property (nonatomic ,copy)NSArray *dataArray;
@property (nonatomic ,strong)NSTimer *timer;


@end

@implementation CustomView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = @[@"0",@"1",@"2",@"3",@"4"];
        self.state = RollingStateDown;
        [self setupUI];
        
    }
    return self;
}
-(void)setupUI{
    [UILabel appearance].textAlignment = NSTextAlignmentCenter;
    _middleRect = self.bounds;
    _topRect = CGRectMake(0, -self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
    _btmRect = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
    
    self.animationView1 = [[UILabel alloc] initWithFrame:_middleRect];
    self.animationView1.backgroundColor = [UIColor lightGrayColor];
    self.animationView1.text = _dataArray.firstObject;
    [self addSubview:self.animationView1];
    
    self.animationView2 = [[UILabel alloc] init];
    self.animationView2.backgroundColor = [UIColor redColor];
    self.animationView2.frame = self.state == RollingStateUp?_btmRect:_topRect;
    [self addSubview:self.animationView2];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.backgroundColor = [UIColor clearColor];
    _button.frame = _middleRect;
    [_button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
    
//    超出裁剪
    self.clipsToBounds = YES;
//    开始动画
    [self startAnimation];
}
- (void)startAnimation{
     _timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self  selector:@selector(executeAnimation) userInfo:nil repeats:YES];
     [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
-(void)executeAnimation{
    [self setViewInfo];
    [UIView animateWithDuration:1 animations:^{
        [self showViewFrameUpdataLayout];
        NSLog(@"执行中");
    } completion:^(BOOL finished) {
        if (finished) {
            // label改变坐标动画完成后,把超出显示区域的label移动到相应的位置,用于下次使用
            self.tmpMiddleView.frame = self.state == RollingStateUp?self->_btmRect:self->_topRect;
        }
    }];
}
- (void)setViewInfo{
    
    if (self.state == RollingStateUp) {
        
        if (self.animationView1.frame.origin.y == 0) {
            self.tmpMiddleView = self.animationView1;
            self.tmpBtmView = self.animationView2;
        }else{
            self.tmpMiddleView = self.animationView2;
            self.tmpBtmView = self.animationView1;
        }
        
    }else{
        if (self.animationView1.frame.origin.y == 0) {
            self.tmpMiddleView = self.animationView1;
            self.tmpTopView = self.animationView2;
        }else{
            self.tmpMiddleView = self.animationView2;
            self.tmpTopView = self.animationView1;
        }
    }
    
    _tmpMiddleView.text = _dataArray[_indexNow%5];
    if (self.state == RollingStateUp) {
         _tmpBtmView.text = _dataArray[(_indexNow+1)%5];
    }else{
         _tmpTopView.text = _dataArray[(_indexNow+1)%5];
    }
   
    _indexNow++;
}

// MARK:两个label的坐标整体上下移动
-(void)showViewFrameUpdataLayout{
     if (self.state == RollingStateUp) {
         self.tmpMiddleView.frame = _topRect;
         self.tmpBtmView.frame = _middleRect;
     }else{
         self.tmpMiddleView.frame = _btmRect;
         self.tmpTopView.frame = _middleRect;
     }
}

-(void)btnClick{
    NSLog(@"%@",_dataArray[_indexNow % 5]);
}

-(void)endAnimation{
    [self.timer invalidate];
    self.timer = nil;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
