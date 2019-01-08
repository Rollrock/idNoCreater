//
//  RSheetPicker.m
//  aaaaa
//
//  Created by fzbx on 16/3/31.
//  Copyright © 2016年 1. All rights reserved.
//

#import "RSheetPicker.h"


#define PICKER_H  250.0f

#define BG  ([UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1])

@interface RSheetPicker()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(strong,nonatomic) UIPickerView * picker;
@property(strong,nonatomic) UIButton * okBtn;
@property(strong,nonatomic) UIButton * cancelBtn;
@property(strong,nonatomic) UIView * btnBgView;
@end

@implementation RSheetPicker


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if( self )
    {
        [self addSubview:self.picker];
        [self addSubview:self.btnBgView];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * t = [touches anyObject];
    CGPoint pt;
    
    pt = [t locationInView:self];
    CGRect frame = CGRectMake(0, 0, self.frame.size.height - PICKER_H - 20, self.frame.size.width);
    
    if( CGRectContainsPoint(frame, pt))
    {
        [self cancelClicked];
    }
}

#pragma UIPickerView
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
         if( [self.pickerDelegate respondsToSelector:@selector(pickerDefault:)] )
         {
         [self.picker selectRow:[self.pickerDelegate pickerDefault:self] inComponent:0 animated:0];
         }
        
    });
    if( [self.pickerDelegate respondsToSelector:@selector(pickerDataSource:)] )
    {
        return [self.pickerDelegate pickerDataSource:self].count;
    }
    
    return 0;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if( [self.pickerDelegate respondsToSelector:@selector(pickerDataSource:)] )
    {
        NSString * title = [self.pickerDelegate pickerDataSource:self][row];
        
        return title;
    }
    
    return nil;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:18]];
        //[pickerLabel setTextColor:HEXTOCOLOR(0x484848)];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma event respond
-(void)cancelClicked
{
   [UIView animateWithDuration:0.5 animations:^{
       
       self.center = CGPointMake(self.center.x, self.center.y + self.frame.size.height);
       
   } completion:^(BOOL finished) {
       [self removeFromSuperview];
   }];
}

-(void)okClicked
{
    [self cancelClicked];
    //
    
    if( [self.pickerDelegate respondsToSelector:@selector(pickerOKClicked:picker:)] )
    {
        [self.pickerDelegate pickerOKClicked:[self.picker selectedRowInComponent:0] picker:self];
    }
}

#pragma setter & getter 

-(UIPickerView*)picker
{
    if( !_picker )
    {
        _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - PICKER_H, self.frame.size.width, PICKER_H)];
        _picker.dataSource = self;
        _picker.delegate = self;
        _picker.backgroundColor = BG;
    }
    
    return _picker;
}

-(UIButton*)cancelBtn
{
    if( !_cancelBtn )
    {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 50,30)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        //[_cancelBtn setTitleColor:NAV_BG_COLOR forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cancelBtn;
}

-(UIButton*)okBtn
{
    if( !_okBtn )
    {
        _okBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.btnBgView.frame.size.width - 10 - 50, 5, 50,30)];
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        //[_okBtn setTitleColor:NAV_BG_COLOR forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(okClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _okBtn;
}

-(UIView*)btnBgView
{
    if( !_btnBgView )
    {
        _btnBgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.picker.frame.origin.y, self.frame.size.width, 40)];
        _btnBgView.backgroundColor = BG;
        
        [_btnBgView addSubview:self.cancelBtn];
        [_btnBgView addSubview:self.okBtn];
    }
    
    return _btnBgView;
}

@end
