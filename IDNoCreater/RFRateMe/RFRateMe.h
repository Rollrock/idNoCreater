//
//  RFRateMe.h
//  RFRateMeDemo
//
//  Created by Ricardo Funk on 1/2/14.
//  Copyright (c) 2014 Ricardo Funk. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kAppStoreAddress @"itms-apps://itunes.apple.com/app/id1449220762?action=write-review"

/*
{
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", @"1332586238"];
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
}
 */

@interface RFRateMe : NSObject

+(void)showRateAlert;
+(void)showRateAlertAfterTimesOpened:(int)times;

@end
