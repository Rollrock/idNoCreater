//
//  CDPDatePicker.h
//  CDPDatePicker
//
//  Created by MAC on 15/3/30.
//  Copyright (c) 2015年 com.xuezi.CDP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CDPDatePickerDelegate <NSObject>

-(void)CDPDatePickerDidConfirm:(NSDate *)confirmString;

-(void)cancle;
-(void)sureOK;

@end

@interface CDPDatePicker : NSObject{
    UIView *_datePickerView;//datePicker背景
    UIDatePicker *_datePicker;//datePicker
    UILabel *_dateLabel;//标题title
  
    UIButton *_dateConfirmButton;//确定Button
    
}

@property (nonatomic,weak) id   <CDPDatePickerDelegate> delegate;

//是否可选择今天以前的时间,默认为YES
@property (nonatomic,assign) BOOL isBeforeTime;

//datePicker显示类别,分别为1=只显示时间,2=只显示日期，3=显示日期和时间(默认为3)
@property (nonatomic,assign) NSInteger theTypeOfDatePicker;


@property (nonatomic, retain)  UIView *view;//delegateView

-(id)initWithSelectTitle:(NSString *)title viewOfDelegate:(UIView *)view delegate:(id<CDPDatePickerDelegate>)delegate;
@end
