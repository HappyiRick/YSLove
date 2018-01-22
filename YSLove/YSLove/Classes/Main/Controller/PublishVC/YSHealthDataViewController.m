//
//  YSHealthDataViewController.m
//  YSLove
//
//  Created by zhangxin on 2017/3/23.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSHealthDataViewController.h"
#import "YSHealthKitManager.h"
#import "CXCountDownLabel.h"

@interface YSHealthDataViewController ()
@property(nonatomic, strong) HKHealthStore *healthStore;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

@property (nonatomic, strong) CXCountDownLabel *cdLabel;
@end

@implementation YSHealthDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"健康数据";
    
    CXCountDownLabel *cxLabel = [[CXCountDownLabel alloc] init];
    cxLabel.countInterval = 0;
    [cxLabel setStartNumber:0 endNumber:1000 countDownHandeler:^(CXCountDownLabel *label, NSInteger currentNumber, BOOL stopped) {
        if (stopped) {
            NSLog(@"Stopped");
        }
    }];
    
    cxLabel.text = @"0";
    cxLabel.frame = CGRectMake( 0, 20, MainScreenW, 100);
    cxLabel.font = [UIFont systemFontOfSize:50];
    cxLabel.textColor = [UIColor colorWithRed:0.075 green:0.608 blue:0.914 alpha:1.000];
    [self.view addSubview:cxLabel];
    self.cdLabel = cxLabel;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"nav_back" highlightIcon:@"nav_back_press" target:self action:@selector(leftItemClick)];
    
    
    [self checkStepCount];
    [self start];
    
}
- (IBAction)updateStep {
    [self checkStepCount];
    [self start];
}

-(void)start{
    [self.cdLabel start];
    self.cdLabel.countDownTimer.frameInterval = 1;
}


-(void)checkStepCount{
    [[YSHealthKitManager shareInstance] getRealTimeStepCountCompletionHandler:^(double value, NSError *error) {
        int stepCount = [[NSString stringWithFormat:@"%f",value] intValue];
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(stepCount < 1000){
                _tipsLabel.text = [NSString stringWithFormat:@"今天走了%d步,您的运动状态有点欠佳哦,请多多努力！" ,stepCount];
            }else if(stepCount <2500){
                _tipsLabel.text = [NSString stringWithFormat:@"今天走了%d步,您的运动状态不错呢,可以做的更好哦~！" ,stepCount];
            }else if(stepCount<4000){
                _tipsLabel.text = [NSString stringWithFormat:@"今天走了%d步,您的运动状态很合理哦,继续保持哦" ,stepCount];
            }else if(stepCount< 6000){
                _tipsLabel.text = [NSString stringWithFormat:@"今天走了%d步,您的运动状态非常棒！注意保持合理休息哦~" ,stepCount];
            }else{
                _tipsLabel.text = [NSString stringWithFormat:@"今天走了%d步,您的运动状态已经爆表了,小爱已经无法形容了~" ,stepCount];
            }
        });

        self.cdLabel.endNumber = stepCount;
    }];
}

-(void)leftItemClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
