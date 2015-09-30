//
//  Helper.h
//  F45Sales
//
//  Created by Paras on 9/2/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"

@interface Helper : UIViewController
{
    AFHTTPRequestOperationManager *manager;
}
+ (UIColor *) colorFromHexString:(NSString *)hexString;
+(BOOL) isInternetWorking;
+(BOOL)validateEmailWithString:(NSString*)emailmatch;
+(void)showIndicatorWithText:(NSString *)text inView:(UIView *)view;
+(void)hideIndicatorFromView:(UIView *)view;
@end
