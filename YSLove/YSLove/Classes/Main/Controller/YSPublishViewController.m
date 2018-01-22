//
//  YSPublishViewController.m
//  YSLove
//
//  Created by zhangxin on 2017/2/22.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSPublishViewController.h"
#import "YSEssayCategoryViewController.h"
#import "YSBaseNavController.h"
#import "YSHealthDataViewController.h"
#import "YSLifeViewController.h"

#import "YSWeatherCollectionViewCell.h"
#import "WeatherGetParam.h"
#import "WeatherGetResult.h"
#import "WeatherModel.h"
#import "FutureModel.h"
#import "WeatherTool.h"

#define BtnWidth   (MainScreenW - 140)/3
@interface YSPublishViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UIDynamicAnimator *animator;

@property(nonatomic, weak) UIButton *forumButton;
@property(nonatomic, weak) UIButton *healthButton;
@property(nonatomic, weak) UIButton *lifeButton;

@property (weak, nonatomic) IBOutlet UICollectionView *weatherCollectionView;
@property (nonatomic, strong) NSMutableArray *weathers;
@end

@implementation YSPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.weatherCollectionView registerNib:[UINib nibWithNibName:@"YSWeatherCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"WeatherCell"];
    self.weatherCollectionView.delegate = self;
    self.weatherCollectionView.dataSource = self;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSelfOnTap:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self loadData];
    [self setupButtons];
    [self bounceMenu];
}

#pragma mark - Handle Tap Genture Reconizer

- (void)dismissSelfOnTap:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma method
-(void)setupButtons{
    UIButton *forumButton = [UIButton circleButtonWithBackgroundCoolor:YSColor(255, 66, 112, 1) title:@"更多文章" titleColor:[UIColor whiteColor] target:self action:@selector(moreEssayButtonClicked)];
    forumButton.frame = CGRectMake(100, 100, 100, 100);
    [forumButton.titleLabel setFont:[UIFont systemFontOfSize:20 weight:3]];
    [forumButton circleView];
    [self.view addSubview:forumButton];
    self.forumButton = forumButton;
    
    UIButton *healthButton = [UIButton circleButtonWithBackgroundCoolor:YSColor(0, 141, 220, 1) title:@"健康数据" titleColor:[UIColor whiteColor] target:self action:@selector(healthButtonClicked)];
    healthButton.frame = CGRectMake(100, 100, 110, 110);
    [healthButton.titleLabel setFont:[UIFont systemFontOfSize:22 weight:3]];
    [healthButton circleView];
    [self.view addSubview:healthButton];
    self.healthButton = healthButton;
    
    UIButton *lifeButton = [UIButton circleButtonWithBackgroundCoolor:[UIColor orangeColor] title:@"生活服务" titleColor:[UIColor whiteColor] target:self action:@selector(lifeButtonClicked)];
    lifeButton.frame = CGRectMake(100, 100, 90, 90);
    [lifeButton.titleLabel setFont:[UIFont systemFontOfSize:18 weight:3]];
    [lifeButton circleView];
    [self.view addSubview:lifeButton];
    self.lifeButton = lifeButton;
    
}

-(void)loadData{
    
    WeatherGetParam *param = [[WeatherGetParam alloc] init];
    param.cityname = @"长春";
    param.dtype = @"json";
    param.format = 2;
    
    [WeatherTool getWeatherWithparameter:param success:^(WeatherGetResult *result) {
        if (result.resultcode == [NSString stringWithFormat:@"200"]) {
            NSMutableArray *futures = [NSMutableArray array];
            for (FutureModel *future in result.result.future) {
                [futures addObject:future];
            }
            self.weathers = futures;
            [self.weatherCollectionView reloadData];
        }
        
        NSLog(@"%@",result.resultcode);
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)bounceMenu{
    CGPoint point1 =  CGPointMake(MainScreenW/4, MainScreenH/5);
    CGPoint point2 =  CGPointMake(MainScreenW/4*3, MainScreenH/3.3);
    CGPoint point3 =  CGPointMake(MainScreenW/4*2-20, MainScreenH/2-10);
    
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    
    UISnapBehavior *snap1 = [[UISnapBehavior alloc]initWithItem:self.forumButton snapToPoint:point1];
    [animator addBehavior:snap1];
    UISnapBehavior *snap2 = [[UISnapBehavior alloc]initWithItem:self.lifeButton snapToPoint:point2];
    [animator addBehavior:snap2];
    UISnapBehavior *snap3 = [[UISnapBehavior alloc]initWithItem:self.healthButton snapToPoint:point3];
    [animator addBehavior:snap3];
    
    self.animator = animator;
}

-(void)moreEssayButtonClicked{
    
    YSEssayCategoryViewController *essayCategoryVc = [YSEssayCategoryViewController new];
    YSBaseNavController *navVc = [[YSBaseNavController alloc] initWithRootViewController:essayCategoryVc];
    [self presentViewController:navVc animated:YES completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)healthButtonClicked{
    YSHealthDataViewController *healthVc = [YSHealthDataViewController new];
    YSBaseNavController *navVc = [[YSBaseNavController alloc] initWithRootViewController:healthVc];
    [self presentViewController:navVc animated:YES completion:nil];
}

-(void)lifeButtonClicked{
    YSLifeViewController *lifeVc = [YSLifeViewController new];
    YSBaseNavController *navVc = [[YSBaseNavController alloc] initWithRootViewController:lifeVc];
    [self presentViewController:navVc animated:YES completion:nil];
}


//-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.weathers.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YSWeatherCollectionViewCell *cell = [self.weatherCollectionView dequeueReusableCellWithReuseIdentifier:@"WeatherCell" forIndexPath:indexPath];
    
    cell.future = self.weathers[indexPath.row];
    return cell;
}

#pragma 懒加载
-(NSArray *)weathers{
    if (!_weathers) {
        self.weathers = [NSMutableArray array];
    }
    return _weathers;
}

@end
