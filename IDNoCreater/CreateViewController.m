//
//  CreateViewController.m
//  IDNoCreater
//
//  Created by zhuang chaoxiao on 2019/1/4.
//  Copyright © 2019年 zhuang chaoxiao. All rights reserved.
//

#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]

#import "CreateViewController.h"
#import "CreateTableViewCell.h"
#import "RSheetPicker.h"
#import "KTSelectDatePicker.h"
#import "NSDate+Helper.h"
#import "JSONKit.h"
#import "CreateModel.h"

@import GoogleMobileAds;

@interface CreateViewController ()<UITableViewDelegate,UITableViewDataSource,RSheetPickerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *provLab;
@property (strong, nonatomic) IBOutlet UILabel *birLab;
@property (strong, nonatomic) IBOutlet UILabel *sexLab;
@property (strong, nonatomic) IBOutlet UILabel *countLab;
@property (strong, nonatomic) IBOutlet UIView *advBanner;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) KTSelectDatePicker * birPicker;
@property (strong,nonatomic) RSheetPicker * sexSheet;
@property (strong,nonatomic) RSheetPicker * countSheet;
@property (strong,nonatomic) RSheetPicker * provSheet;
@property (strong,nonatomic) NSMutableArray * generArray;
@property (strong,nonatomic) NSMutableDictionary * provDict;

@property(nonatomic, strong) GADInterstitial *interstitial;

@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"身份证生成";
    
    self.provLab.text = @"浙江省";
    self.birLab.text = @"1987-04-25";
    
    self.tableView.rowHeight = 50;
    [self.tableView setTableFooterView:[UIView new]];
    
    [self addGesture];
    [self getProvData];
    [self layoutAdv];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self generateClicked];
        
    });
}

#pragma private


-(void)layoutAdv
{
    GADBannerView * banner = [[GADBannerView alloc]initWithAdSize:kGADAdSizeSmartBannerPortrait];
    banner.rootViewController = self;
    banner.adUnitID = @"ca-app-pub-3058205099381432/2530891856";
    
    GADRequest * req = [GADRequest request];
    req.testDevices = @[ @"02257fbde9fc053b183b97056fe93ff4" ];
    [banner loadRequest:req];
    
    [self.advBanner addSubview:banner];
    
    
    //
    {
        //
        self.interstitial = [[GADInterstitial alloc]
                             initWithAdUnitID:@"ca-app-pub-3058205099381432/6086993486"];
        
        
        GADRequest * request = [GADRequest request];
        request.testDevices = @[ @"02257fbde9fc053b183b97056fe93ff4" ];
        [self.interstitial loadRequest:request];
    }
    
    //
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.interstitial.isReady)
        {
            [self.interstitial presentFromRootViewController:self];
        }
    });
}


-(void)addGesture
{
    UITapGestureRecognizer * g = nil;
    
    g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(porvClicked)];
    self.provLab.userInteractionEnabled = YES;
    [self.provLab addGestureRecognizer:g];
    
    //
    g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(birClicked)];
    self.birLab.userInteractionEnabled = YES;
    [self.birLab addGestureRecognizer:g];
    
    //
    g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sexClicked)];
    [self.sexLab.superview addGestureRecognizer:g];
    
    //
    g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(countClicked)];
    [self.countLab.superview addGestureRecognizer:g];
}

-(void)getProvData
{
    /*
    self.provArray = nil;
    self.provArray = [NSMutableArray new];
    
    NSString * filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"area.txt"];
    
    NSString * str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary * dict = [data objectFromJSONData];
    NSArray * array  = [dict objectForKey:@"data"];
    
    for(NSDictionary * subDict in array )
    {
        CreateProvModel * provModel = [CreateProvModel modelWithDict:subDict];
        [self.provArray addObject:provModel];
    }
    */
}

//生成1-6位地区码
-(NSString*)createAddrNo
{
    NSString * str = [self.provDict objectForKey:self.provLab.text];
    
    return str;
}

-(NSString*)createBirNo
{
    NSString * str = self.birLab.text;
    str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return str;
}

//可以固定或者随机数
-(NSString*)createPoliceNo
{
    int rand = arc4random() % 100;
    
    return [NSString stringWithFormat:@"%02d",rand];
}

//男 基数 ； 女 偶数
-(NSString*)createSexNo
{
    if( [self.sexLab.text isEqualToString:@"男"] )
    {
        return @"1";
    }

    return @"2";
}

//直接生成身份证号码
-(NSString*)createIdNo
{
    NSString * str = [NSString stringWithFormat:@"%@%@%@%@",[self createAddrNo],[self createBirNo],[self createPoliceNo],[self createSexNo]];
    
    int sum = 0;
    NSArray * sumRand = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    for( int i =0; i < str.length; ++ i )
    {
        NSString * temStr = [str substringWithRange:NSMakeRange(i, 1)];
        int tempI = temStr.intValue;
        tempI *= ((NSString*)sumRand[i]).intValue;
        sum += tempI;
    }
    
    NSString * checkNo = nil;
    int ret = sum%11;
    if( ret == 0 )
    {
        checkNo = @"1";
    }
    else if( ret == 1 )
    {
        checkNo =  @"0";
    }
    else if( ret == 2 )
    {
        checkNo =  @"X";
    }
    else if( ret == 3 )
    {
        checkNo =  @"9";
    }
    else if( ret == 4 )
    {
        checkNo =  @"8";
    }
    else if( ret == 5 )
    {
        checkNo =  @"7";
    }
    else if( ret == 6 )
    {
        checkNo =  @"6";
    }
    else if( ret == 7 )
    {
        checkNo =  @"5";
    }
    else if( ret == 8 )
    {
        checkNo =  @"4";
    }
    else if( ret == 9 )
    {
        checkNo =  @"3";
    }
    else if( ret == 10 )
    {
        checkNo =  @"2";
    }
    
    return [NSString stringWithFormat:@"%@%@",str,checkNo];
}

#pragma RSheetPicker
-(NSArray*)pickerDataSource:(RSheetPicker*)picker
{
    if( picker == self.sexSheet )
        return @[@"男",@"女"];
    
    if( picker == self.countSheet )
        return @[@"1",@"2",@"3",@"4",@"5"];
    
    if( picker == self.provSheet )
    {
        return self.provDict.allKeys;
    }
    
    return nil;
}

-(void)pickerOKClicked:(NSInteger)row picker:(RSheetPicker *)picker
{
    if( picker == self.sexSheet )
    {
        if( row == 0 )
            self.sexLab.text = @"男";
        else
            self.sexLab.text = @"女";
    }
    
    if( picker == self.countSheet )
    {
        self.countLab.text = [NSString stringWithFormat:@"%d",row+1];
    }
    
    if( picker == self.provSheet )
    {
      self.provLab.text = [self.provDict.allKeys objectAtIndex:row];
    }
}

#pragma event

- (IBAction)generateClicked {
    
    self.generArray = nil;
    
    for( int i = 0; i < [self.countLab.text intValue]; ++ i )
    {
        NSString * str = [self createIdNo];
        [self.generArray addObject:str];
    }
    
    [self.tableView reloadData];
}

-(void)porvClicked
{
    if( !self.provSheet.superview )
    {
        [self.view addSubview:self.provSheet];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.provSheet.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2.0, [UIScreen mainScreen].bounds.size.height/2.0);
    }];
}

-(void)birClicked
{
    [self.birPicker didFinishSelectedDate:^(NSDate *selectDataTime) {
        
        self.birLab.text = [NSDate stringFromDate:selectDataTime withFormat:@"yyyy-MM-dd"];
    }];
}

-(void)countClicked
{
    if( !self.countSheet.superview )
    {
        [self.view addSubview:self.countSheet];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.countSheet.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2.0, [UIScreen mainScreen].bounds.size.height/2.0);
    }];
}

-(void)sexClicked
{
    if( !self.sexSheet.superview )
    {
        [self.view addSubview:self.sexSheet];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
       
        self.sexSheet.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2.0, [UIScreen mainScreen].bounds.size.height/2.0);
    }];
}

#pragma UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.generArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CreateTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CreateTableViewCell"];
    if( !cell )
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CreateTableViewCell" owner:self
                                           options:    nil] lastObject];
    }
    
    [cell refreshCell:self.generArray[indexPath.row]];
    
    return cell;
}


#pragma setter & getter
-(RSheetPicker*)sexSheet
{
    if(!_sexSheet )
    {
        _sexSheet = [[RSheetPicker alloc]initWithFrame:SCREEN_BOUNDS];
        _sexSheet.center = CGPointMake(_sexSheet.center.x, _sexSheet.center.y + SCREEN_BOUNDS.size.height);
        
        _sexSheet.pickerDelegate = self;
    }
    return _sexSheet;
}

-(RSheetPicker*)countSheet
{
    if(!_countSheet )
    {
        _countSheet = [[RSheetPicker alloc]initWithFrame:SCREEN_BOUNDS];
        _countSheet.center = CGPointMake(_countSheet.center.x, _countSheet.center.y + SCREEN_BOUNDS.size.height);
        
        _countSheet.pickerDelegate = self;
    }
    return _countSheet;
}


-(RSheetPicker*)provSheet
{
    if(!_provSheet )
    {
        _provSheet = [[RSheetPicker alloc]initWithFrame:SCREEN_BOUNDS];
        _provSheet.center = CGPointMake(_provSheet.center.x, _provSheet.center.y + SCREEN_BOUNDS.size.height);
        
        _provSheet.pickerDelegate = self;
    }
    return _provSheet;
}

-(KTSelectDatePicker*)birPicker
{
    if( !_birPicker )
    {
        _birPicker = [[KTSelectDatePicker alloc]init];
        _birPicker.datePickerMode = UIDatePickerModeDate;
        _birPicker.minDate = [[NSDate date] dateByAddingTimeInterval:(0-3600*24*365*50)];
        _birPicker.maxDate = [NSDate date];
        
        NSDateFormatter*formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate*date=[formatter dateFromString:_birLab.text];
        _birPicker.selectDate = date;
    }
    
    return _birPicker;
}

-(NSMutableArray *)generArray
{
    if( !_generArray )
    {
        _generArray = [NSMutableArray new];
    }
    
    return _generArray;
}

-(NSMutableDictionary*)provDict
{
    if(!_provDict )
    {
        _provDict = [NSMutableDictionary new];
        
        
        [_provDict setObject:@"110100" forKey:@"北京市"];
        [_provDict setObject:@"330000" forKey:@"浙江省"];
        [_provDict setObject:@"350200" forKey:@"福建省"];
        [_provDict setObject:@"410100" forKey:@"河南省"];
        [_provDict setObject:@"130100" forKey:@"河北省"];
        [_provDict setObject:@"230100" forKey:@"黑龙江省"];
        [_provDict setObject:@"430100" forKey:@"湖南省"];
        [_provDict setObject:@"420100" forKey:@"湖北省"];
        [_provDict setObject:@"650100" forKey:@"新疆省"];
        [_provDict setObject:@"510100" forKey:@"四川省"];
        [_provDict setObject:@"370100" forKey:@"山东省"];
        [_provDict setObject:@"530100" forKey:@"云南省"];
        [_provDict setObject:@"610100" forKey:@"陕西省"];
        [_provDict setObject:@"140100" forKey:@"山西省"];
        [_provDict setObject:@"210100" forKey:@"辽宁省"];
        [_provDict setObject:@"360100" forKey:@"江西省"];
        [_provDict setObject:@"340100" forKey:@"安徽省"];
        [_provDict setObject:@"520100" forKey:@"贵州省"];
    }
    
    return _provDict;
}

@end
