//
//  RSheetPicker.h
//  aaaaa
//
//  Created by fzbx on 16/3/31.
//  Copyright © 2016年 1. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSheetPicker;

@protocol RSheetPickerDelegate <NSObject>

-(NSArray*)pickerDataSource:(RSheetPicker*)picker;

-(void)pickerOKClicked:(NSInteger)row picker:(RSheetPicker*)picker;
-(NSInteger)pickerDefault:(RSheetPicker*)picker;

@end


@interface RSheetPicker : UIView

@property(weak,nonatomic) id<RSheetPickerDelegate> pickerDelegate;

@end
