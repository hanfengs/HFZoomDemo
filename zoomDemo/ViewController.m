//
//  ViewController.m
//  zoomDemo
//
//  Created by hanfeng on 2017/10/25.
//  Copyright © 2017年 hanfeng. All rights reserved.
//6451004569 4627990174

#import "ViewController.h"
#import <MobileRTC/MobileRTC.h>

#define kSDKUserID      @""
#define kSDKUserName    @"趣学"
#define kSDKUserToken   @""
#define kSDKMeetNumber  @"6451004569"

#define kMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define KMainScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<MobileRTCMeetingServiceDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btn_join;

@property (nonatomic, strong) MobileRTCMeetingService *ms;
@property (nonatomic, strong) UIView *meetingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

#pragma mark-
- (IBAction)click_btn_join {
    
    [self joinMeeting:kSDKMeetNumber];
    
}

- (void)joinMeeting:(NSString*)meetingNo{
    if (![meetingNo length])
        return;
    
     _ms = [[MobileRTC sharedRTC] getMeetingService];
    if (_ms){
        
        NSString *title = [NSString stringWithFormat:@"房间号：%@",kSDKMeetNumber];
        [_ms customizeMeetingTitle:title];
        _ms.delegate = self;
        
        NSDictionary *paramDict = @{
                                    kMeetingParam_Username:kSDKUserName,
                                    kMeetingParam_MeetingNumber:meetingNo,
                                    
                                    };
        
        MobileRTCMeetError ret = [_ms joinMeetingWithDictionary:paramDict];
        NSLog(@"onJoinaMeeting ret:%d", ret);

    }
}

#pragma mark- MobileRTCMeetingServiceDelegate

- (void)onMeetingReturn:(MobileRTCMeetError)error internalError:(NSInteger)internalError{
    
    NSLog(@"%d", internalError);
}
- (void)onMeetingError:(NSInteger)error message:(NSString*)message{
    
    NSLog(@"%@", message);
}

- (void)onMeetingStateChange:(MobileRTCMeetingState)state{
    NSLog(@"%d", state);
}

- (void)onMeetingReady{
    
    _meetingView = [_ms meetingView];
    _meetingView.frame = CGRectMake(100, 50, kMainScreenWidth * 0.5, KMainScreenHeight * 0.5);
//    view.frame = CGRectMake(0, 0, kMainScreenWidth, KMainScreenHeight);
    
    [self.view addSubview:_meetingView];

    
//    UIButton *btn = [[UIButton alloc] init];
//    btn.frame = CGRectMake(kMainScreenWidth - 50, KMainScreenHeight - 40, 50, 40);
//    [btn setTitle:@"退出" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(click_dismiss) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
}

- (void)click_dismiss{
    
    [_meetingView removeFromSuperview];
}
- (IBAction)click_exit {
    
    [_meetingView removeFromSuperview];
}

//- (void)onJBHWaitingWithCmd:(JBHCmd)cmd{
//
//}
@end
