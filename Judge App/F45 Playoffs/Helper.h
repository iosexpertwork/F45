//
//  Helper.h
//  canoe
//
//  Created by HashBrown Systems on 26/03/15.
//  Copyright (c) 2015 Hashbrown Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "Constants.h"
#import "MBProgressHUD.h"

@interface Helper : NSObject<UIAlertViewDelegate>
{
    UIStoryboard *storyboard;
    UINavigationController *navController;
}

+(BOOL)validateEmailWithString:(NSString*)emailmatch;
+(NSNumber *)getNumberFromString:(NSString *)strValue;
+(CGRect)calculateHeightForText:(NSString *)text fontName:(NSString *)fontName fontSize:(float)fontSize maximumWidth:(float)width;
+ (UIColor *) colorFromHexString:(NSString *)hexString;

// internet connectivity
+(BOOL) isInternetConnected;

// indicator
+(void)showIndicatorWithText:(NSString *)text inView:(UIView *)view;
+(void)hideIndicatorFromView:(UIView *)view;

@end
