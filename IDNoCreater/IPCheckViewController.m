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
@property (strong, nonatomic) IBOutlet UILabel *areaLab;
@property (strong, nonatomic) IBOutlet UILabel *serviceLab;
@property (strong, nonatomic) IBOutlet UITextField *ipNoField;

- (IBAction)checkClicked;

@end

@implementation IPCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"IP地址校验";
}

- (IBAction)checkClicked {
    
    [self.ipNoField resignFirstResponder];
    
      NSString *urlstring = [NSString stringWithFormat:@"http://apis.juhe.cn/ip/ip2addr?ip=%@&key=00f0818ab4adaec82c83ee141f4a1d03",self.ipNoField.text];
    
    [NetWorkUikits requestWithUrl:urlstring param:nil completionHandle:^(id data) {
        
        NSLog(@"数据收到:%@",data);
        if( [data[@"resultcode"] intValue] == 200 )
        {
            self.resultLab.text = @"合法地址";
            self.areaLab.text = data[@"result"][@"area"];
            self.serviceLab.text = data[@"result"][@"location"];
        }
        else
        {
            self.resultLab.text = data[@"reason"];
            self.areaLab.text = @"";
            self.serviceLab.text = @"";
        }
        
        
    
    } failureHandle:^(NSError *error) {
        
        NSLog(@"error:%@",error);
        self.resultLab.text = error.description;
        self.areaLab.text = @"";
        self.serviceLab.text = @"";
    
    }];
}
@end
