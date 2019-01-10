//
//  CheckViewController.m
//  IDNoCreater
//
//  Created by zhuang chaoxiao on 2019/1/5.
//  Copyright © 2019年 zhuang chaoxiao. All rights reserved.
//


/*
 {"code":0,"data":{"ip":"180.165.159.87","country":"中国","area":"","region":"上海","city":"上海","county":"XX","isp":"电信","country_id":"CN","area_id":"","region_id":"310000","city_id":"310100","county_id":"xx","isp_id":"100017"}}
 */

#import "IPCheckViewController.h"
#import "NetWorkUikits.h"

@interface IPCheckViewController ()

@property (strong, nonatomic) IBOutlet UILabel *resultLab;
@property (strong, nonatomic) IBOutlet UILabel *birLab;
@property (strong, nonatomic) IBOutlet UILabel *sexLab;
@property (strong, nonatomic) IBOutlet UITextField *ipNoField;

- (IBAction)checkClicked;

@end

@implementation IPCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)checkClicked {
    
    NSString *urlstring = [NSString stringWithFormat:@"%@%@",@"http://ip.taobao.com/service/getIpInfo.php?ip=",self.ipNoField.text];
    
    [NetWorkUikits requestWithUrl:urlstring param:nil completionHandle:^(id data) {
        
        NSLog(@"数据收到:%@",data);
    
    } failureHandle:^(NSError *error) {
        
        NSLog(@"error:%@",error);
        
    
    }];
}
@end
