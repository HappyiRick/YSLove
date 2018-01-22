//
//  YSUserViewController.m
//  YSLove
//
//  Created by zhangxin on 2017/3/17.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSUserViewController.h"
#import "YSUserOperationViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>

#import "YSSettingGroup.h"
#import "IRickSettingArrowItem.h"
#import "IRickSettingLabelItem.h"
#import "YSSettingCell.h"

#import "YSAccountTool.h"
#import "YSLoginResult.h"
#import "YSUserHttpTool.h"
#import "YSBaseParam.h"
#import "YSHeaderImageData.h"
#import "YSUpdateHeaderResult.h"


@interface YSUserViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate>
@property(nonatomic, strong) YSLoginResult *result;
@property (nonatomic, strong) UIImagePickerController *picker;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property(nonatomic, weak) UIImageView *headerImageView;
@property(nonatomic, weak) UIImage *headerImage;
@property(nonatomic, strong) NSMutableArray *groups;
@end

@implementation YSUserViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setViewTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setViewTitle];
    
    [self addGroup0];
    [self addGroup1];
    [self addGroup2];
    [self addGroup3];
    
    [self setupTableViewHeader];
    [self setupTableViewFooter];
}

-(void)setViewTitle{
    YSLoginResult *result = [YSAccountTool account];
    self.result = result;
    
    if (kObj_isNIl(_result.usernickname)) {
        self.title = @"操作界面";
    }else{
        self.title = _result.usernickname;
    }
    
    if(!kObj_isNIl(result.userheader)){
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:result.userheader] placeholderImage:[UIImage imageNamed:@"user_defaultheader"]];
    }else{
        [self.headerImageView setImage:[UIImage imageNamed:@"user_defaultheader"]];
    }
    
    
    
}

-(void)addGroup0{
    YSSettingGroup *group = [self addGroup];
    IRickSettingArrowItem *nickname = [IRickSettingArrowItem itemWithTitle:@"更改昵称" destVcClass:[YSUserOperationViewController class]];
    if (kObj_isNIl(_result.usernickname)) {
        nickname.subtitle = @"还没有昵称哦,快来设置吧";
    }
    group.items = @[nickname];
}

-(void)addGroup1{
    YSSettingGroup *group = [self addGroup];
    IRickSettingArrowItem *updateEmail = [IRickSettingArrowItem itemWithTitle:@"绑定邮箱" destVcClass:[YSUserOperationViewController class]];
    group.items = @[updateEmail];
}
-(void)addGroup2{
    YSSettingGroup *group = [self addGroup];
    IRickSettingArrowItem *updatePhone = [IRickSettingArrowItem itemWithTitle:@"绑定手机" destVcClass:[YSUserOperationViewController class]];
    group.items = @[updatePhone];
}
-(void)addGroup3{
    YSSettingGroup *group = [self addGroup];
    IRickSettingArrowItem *checkPassword = [IRickSettingArrowItem itemWithTitle:@"验证密码" destVcClass:[YSUserOperationViewController class]];
    group.items = @[checkPassword];
}


-(void)setupTableViewHeader{
    UIView *vc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenW, MainScreenH/4)];
    vc.backgroundColor = [UIColor whiteColor];
    UIImageView *headerImageView = [[UIImageView alloc] init];
    headerImageView.center = CGPointMake(CGRectGetWidth(vc.frame)/2,CGRectGetHeight(vc.frame)/2);
    headerImageView.bounds = CGRectMake(0, 0, vc.Height/3 * 2, vc.Height / 3 *2);
    headerImageView.userInteractionEnabled = YES;
    [headerImageView circleView];
    [vc addSubview:headerImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImageClicked)];
    [headerImageView addGestureRecognizer:tap];
    
    self.headerImageView = headerImageView;
    self.userTableView.tableHeaderView = vc;
}

-(void)headerImageClicked{
    [self setHeadImage];
}

-(void)setupTableViewFooter{
    UIView *vc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenW, MainScreenH/4)];
    vc.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton new];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    [button setTitle:@"退出登录" forState:UIControlStateHighlighted];
    [button setTitleColor:YSColor(254, 0, 0, 1) forState:UIControlStateNormal];
    [button setTitleColor:YSColor(234, 66, 55, 1) forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor clearColor]];
    button.layer.masksToBounds = YES;
    button.frame = CGRectMake(15, 20, MainScreenW-30, 40);
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = YSColor(254, 0, 0, 1).CGColor;
    button.layer.cornerRadius = 5;
    [vc addSubview:button];
    self.userTableView.tableFooterView = vc;
}

-(void)exitBtnClick{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要注销吗" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [YSAccountTool exit];
        [SVProgressHUD showSuccessWithStatus:@"注销完成"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:delete];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YSSettingGroup *group = self.groups[section];
    return group.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YSSettingCell *cell = [YSSettingCell cellWithTableView:tableView];
    YSSettingGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    cell.indexPath = indexPath;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 1. 取出模型
    YSSettingGroup *group = self.groups[indexPath.section];
    IRickSettingItem *item = group.items[indexPath.row];
    
    // 2. 操作
    if (item.operation){
        item.operation();
    }
    
    //     3. 跳转
    if ([item isKindOfClass:[IRickSettingArrowItem class]]) {
        IRickSettingArrowItem *arrowItem = (IRickSettingArrowItem *)item;
        if (arrowItem.destVcClass) {
            UIViewController *destVc = [[arrowItem.destVcClass alloc] init];
            destVc.title = arrowItem.title;
            [self.navigationController pushViewController:destVc animated:YES];
        }
    }
}


#pragma mark 懒加载
-(NSMutableArray *)groups{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

-(YSSettingGroup *)addGroup{
    YSSettingGroup *group = [YSSettingGroup group];
    [self.groups addObject:group];
    return group;
}

#pragma mark 头像相关
-(void)setHeadImage{
    __block typeof (self) weak_self = self;
    
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.delegate=self;
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"设置新头像" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takeNewPhoto = [UIAlertAction actionWithTitle:@"拍摄新照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCameraAvailable]){
            // 初始化图片选择控制器
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            [controller setSourceType:UIImagePickerControllerSourceTypeCamera];// 设置类型
            
            
            // 设置所支持的类型，设置只能拍照，或则只能录像，或者两者都可以
            NSString *requiredMediaType = (NSString *)kUTTypeImage;
            //            NSString *requiredMediaType1 = ( NSString *)kUTTypeMovie;
            NSArray *arrMediaTypes=[NSArray arrayWithObjects:requiredMediaType, nil];
            [controller setMediaTypes:arrMediaTypes];
            
            // 设置录制视频的质量
            [controller setVideoQuality:UIImagePickerControllerQualityTypeHigh];
            //设置最长摄像时间
            [controller setVideoMaximumDuration:10.f];
            
            
            [controller setAllowsEditing:YES];// 设置是否可以管理已经存在的图片或者视频
            [controller setDelegate:weak_self];// 设置代理
            [self presentViewController:controller animated:YES completion:^{
            }];
            //            [self.navigationController presentModalViewController:controller animated:YES];
            
        }else{
            
        }
        if (![self getCameraRecordPermisson]) {
            NSString *tips = @"请在iPhone的“设置-隐私-相机”中允许访问相机";
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:tips preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"取消");
                
            }];
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSLog(@"确定");
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:otherAction];
            [self presentViewController:alertController animated:YES completion:nil];
            self.navigationController.navigationBar.alpha = 0.f;
        }
        
    }];
    
    
    UIAlertAction *getFromPicture = [UIAlertAction actionWithTitle:@"从图库中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePicker.view.backgroundColor = [UIColor blackColor];
        UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.sourceType = sourcheType;
        
        imagePicker.allowsEditing = YES;
        
        imagePicker.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
        
    }];
    
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:takeNewPhoto];
    [alert addAction:getFromPicture];
    [alert addAction:cancelBtn];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

//取消时调用
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }];
}

//完成时调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    UIImage *bigImage= [YSUserViewController imageWithImageSimple:image scaledToSize:CGSizeMake(150.0, 150.0)];
    self.headerImage = bigImage;
    //
    
    // 拍照后保存原图片到相册中
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera && image) {
        UIImageWriteToSavedPhotosAlbum(image, self, nil, NULL);
    }
    [self postHeadImageWithImage:bigImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        if (bigImage) {
            //上传到服务器
            
            [self setViewTitle];
            //            [self.tableView reloadData];
            
        }
    }];
}



// 判断设备是否有摄像头
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}


//获得设备是否有访问相机权限
-(BOOL)getCameraRecordPermisson
{
    NSString * mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied)
    {
        return NO;
    }
    return YES;
}
#pragma mark- 压缩图片
//压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}



#pragma mark- 上传头像
-(void)postHeadImageWithImage:(UIImage *)img{
    
//
    
    NSData *imageData = UIImagePNGRepresentation(img);
    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
    // 要解决此问题，
    // 可以在上传时使用当前的系统事件作为文件名
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
    
    YSBaseParam *param = [YSBaseParam new];
    param.uid = _result.uid;
    
    YSHeaderImageData *formData = [YSHeaderImageData new];
    formData.data = imageData;
    formData.name = @"upload";
    formData.fileName = fileName;
    formData.mimeType = @"image/png";

    [YSUserHttpTool updateUserHeaderWithParameter:param formData:formData success:^(YSUpdateHeaderResult *result) {
        debuglog(@"%@",result.headerImage);
        if (result.code ==200) {
            YSLoginResult *account = [YSAccountTool account];
            account.userheader = result.headerImage;
            [YSAccountTool savaAccount:account];
            [SVProgressHUD showSuccessWithStatus:result.msg];
        }else{
            [SVProgressHUD showErrorWithStatus:@"修改失败！"];
        }
    } failure:^(NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"服务器出现故障~"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        };
    }];
    
}


@end
