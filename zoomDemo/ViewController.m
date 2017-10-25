//
//  ViewController.m
//  zoomDemo
//
//  Created by hanfeng on 2017/10/25.
//  Copyright © 2017年 hanfeng. All rights reserved.
//

#import "ViewController.h"
#import <MobileRTC/MobileRTC.h>

#define kSDKUserID      @""
#define kSDKUserName    @"xxxx"
#define kSDKUserToken   @""
#define kSDKMeetNumber  @"4627990174"

@interface ViewController ()<MobileRTCMeetingServiceDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn_join;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}


#pragma mark-
- (void)joinMeeting:(NSString*)meetingNo{
    if (![meetingNo length])
        return;
    
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms){
        
        NSString *title = [NSString stringWithFormat:@"房间号：%@",kSDKMeetNumber];
        [ms customizeMeetingTitle:title];
        ms.delegate = self;
        
        NSDictionary *paramDict = @{
                                    kMeetingParam_Username:kSDKUserName,
                                    kMeetingParam_MeetingNumber:meetingNo,
                                    
                                    };
        
        MobileRTCMeetError ret = [ms joinMeetingWithDictionary:paramDict];
        NSLog(@"onJoinaMeeting ret:%d", ret);

    }
}

#pragma mark-
- (IBAction)click_btn_join {
    
    [self joinMeeting:kSDKMeetNumber];
    
}

@end
