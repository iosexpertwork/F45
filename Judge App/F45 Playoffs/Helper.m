//
//  Helper.m
//  canoe
//
//  Created by HashBrown Systems on 26/03/15.
//  Copyright (c) 2015 Hashbrown Systems. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+(BOOL)validateEmailWithString:(NSString*)emailmatch
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if ([emailmatch rangeOfString:@" "].location==NSNotFound && [emailTest evaluateWithObject:emailmatch])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(NSNumber *)getNumberFromString:(NSString *)strValue
{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterNoStyle;
    NSNumber *number = [f numberFromString:[NSString stringWithFormat:@"%@", strValue]];
    return number;
}

+(CGRect)calculateHeightForText:(NSString *)text fontName:(NSString *)fontName fontSize:(float)fontSize maximumWidth:(float)width
{
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    
    return rect;
}

+ (UIColor *) colorFromHexString:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

#pragma mark -- Internet Connectivity

+(BOOL) isInternetConnected
{
    // called after network status changes
    Reachability* internetReachable = [Reachability reachabilityForInternetConnection];;
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:
        {
            // NSLog(@"The internet is down.");
            return NO;
            
            break;
        }
        case ReachableViaWiFi:
        {
            // NSLog(@"The internet is working via WIFI.");
            return YES;
            
            break;
        }
        case ReachableViaWWAN:
        {
            // NSLog(@"The internet is working via WWAN.");
            return YES;
            
            break;
        }
    }
}

#pragma mark -- View Indicator

+(void)showIndicatorWithText:(NSString *)text inView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
}

+(void)hideIndicatorFromView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

@end
