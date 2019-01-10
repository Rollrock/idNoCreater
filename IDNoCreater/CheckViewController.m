//
//  CheckViewController.m
//  IDNoCreater
//
//  Created by zhuang chaoxiao on 2019/1/5.
//  Copyright © 2019年 zhuang chaoxiao. All rights reserved.
//

#import "CheckViewController.h"

@interface CheckViewController ()
@property (strong, nonatomic) IBOutlet UILabel *resultLab;
@property (strong, nonatomic) IBOutlet UILabel *birLab;
@property (strong, nonatomic) IBOutlet UILabel *sexLab;

@property (strong, nonatomic) IBOutlet UITextField *idNoField;

- (IBAction)checkClicked;

@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"身份证校验";
    
}

-(BOOL)judgeIdentityStringValid:(NSString *)identityString {
    
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}


-(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr
{
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    
    NSString *year = nil;
    NSString *month = nil;
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([numberStr length]<18)
        return result;

    //**从第6位开始 截取8个数
    
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(6, 8)];

    //**检测前12位否全都是数字;
    
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0') {
        if(!(*p>='0'&&*p<='9'))
            isAllNumber = NO;
        p++;
    }
    
    if(!isAllNumber)
        return result;

    year = [NSString stringWithFormat:@"19%@",[numberStr substringWithRange:NSMakeRange(8, 2)]];

    month = [numberStr substringWithRange:NSMakeRange(10, 2)];
    day = [numberStr substringWithRange:NSMakeRange(12,2)];
    
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    
    return result;
}

/**
 *  从身份证上获取性别
 */

-(NSString *)getIdentityCardSex:(NSString *)numberStr
{
    NSString *sex = @"";
    //获取18位 二代身份证  性别
    if (numberStr.length==18)
    {
        int sexInt=[[numberStr substringWithRange:NSMakeRange(16,1)] intValue];
        
        if(sexInt%2!=0)
        {
            NSLog(@"1");
            sex = @"男";
        }
        else
        {
            NSLog(@"2");
            sex = @"女";
        }
    }
    
    return sex;
}

- (IBAction)checkClicked {
    
    
    self.idNoField.text = [self.idNoField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if( [self judgeIdentityStringValid:self.idNoField.text] )
    {
        self.resultLab.text = @"身份证正确";
        
        self.birLab.text = [self birthdayStrFromIdentityCard:self.idNoField.text];
        self.sexLab.text = [self getIdentityCardSex:self.idNoField.text];
    }
    else
    {
        self.resultLab.text = @"身份证错误";
    }
}
@end
