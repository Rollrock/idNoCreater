//
//  CDPDatePicker.m
//  CDPDatePicker
//
//  Created by MAC on 15/3/30.
//  Copyright (c) 2015年 com.xuezi.CDP. All rights reserved.
//

#import "CDPDatePicker.h"

@implementation CDPDatePicker

-(id)initWithSelectTitle:(NSString *)title viewOfDelegate:(UIView *)view delegate:(id<CDPDatePickerDelegate>)delegate{
    if (self=[super init]) {
        
        _view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, (([UIScreen mainScreen].bounds.size.height - 64))*0.42243)];
        
        _delegate = delegate;
        _isBeforeTime =YES;
        _theTypeOfDatePicker=3;
        //生成日期选择器
        _datePickerView =[[UIView alloc] initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,(([UIScreen mainScreen].bounds.size.height - 64))*0.42243)];
        _datePickerView.backgroundColor=[UIColor whiteColor];
        [_view addSubview:_datePickerView];
        
        _datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,_datePickerView.bounds.size.height-(([UIScreen mainScreen].bounds.size.height - 64))*0.07042)];
        _datePicker.date =[NSDate date];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        [_datePickerView addSubview:_datePicker];
        
        _dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width/2,(([UIScreen mainScreen].bounds.size.height - 64))*0.07042)];
        if (title) {
            _dateLabel.text=title;
        }
        else{
            _dateLabel.text=@"选择时间";
        }
        _dateLabel.textAlignment=NSTextAlignmentCenter;
        _dateLabel.textColor=[UIColor darkGrayColor];
        _dateLabel.backgroundColor=[UIColor whiteColor];
        [_datePickerView addSubview:_dateLabel];
        
        _dateConfirmButton=[[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2,0,[UIScreen mainScreen].bounds.size.width/2,(([UIScreen mainScreen].bounds.size.height - 64))*0.07042)];
        [_dateConfirmButton setTitle:@"确定" forState:UIControlStateNormal];
        _dateConfirmButton.userInteractionEnabled=YES;
        [_dateConfirmButton addTarget:self action:@selector(dateConfirmClick) forControlEvents:UIControlEventTouchUpInside];
        [_dateConfirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _dateConfirmButton.backgroundColor=[UIColor grayColor];
        [_datePickerView addSubview:_dateConfirmButton];

    }
    
    return self;
}
//确定选择
-(void)dateConfirmClick{
    [self.delegate cancle];


    [self.delegate CDPDatePickerDidConfirm:_datePicker.date];
  
    _datePicker.date =[NSDate date];


}


-(void)cancle
{
    [self.view endEditing:YES];
}
-(void)sureOK
{
    [self.view endEditing:YES];
}




//是否可选择以前的时间
-(void)setIsBeforeTime:(BOOL)isBeforeTime{
    if (isBeforeTime==NO) {
        [_datePicker setMinimumDate:[NSDate date]];
    }
    else{
        [_datePicker setMinimumDate:[NSDate dateWithTimeIntervalSince1970:0]];
    }
}
//datePicker显示类别
-(void)setTheTypeOfDatePicker:(NSInteger)theTypeOfDatePicker{
    if (theTypeOfDatePicker==1) {
        //只显示时间
        _datePicker.datePickerMode = UIDatePickerModeTime;
    }
    else if(theTypeOfDatePicker==2){
        //只显示日期
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    else if(theTypeOfDatePicker==3){
        //时间与日期都显示
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    }
    else{
        
    }
}




-(void)dealloc{
    self.delegate=nil;
}



@end
