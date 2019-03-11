//
//  CustomView.h
//  UpWithDown
//
//  Created by Siri on 2019/3/9.
//  Copyright © 2019年 Siri. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RollingState) {
    RollingStateUp,
    RollingStateDown,
};

@interface CustomView : UIView
@property (nonatomic ,assign)RollingState state; //!<滚动方向
- (void)startAnimation;
- (void)endAnimation;
@end
