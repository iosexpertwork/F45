//
//  Constants.h
//  canoe
//
//  Created by HashBrown Systems on 27/11/14.
//  Copyright (c) 2014 Hashbrown Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

// http://192.168.2.9/CanoeLocal/

/*********************** FRESHDESK KEYS ****************************/

#define FRESHDESK_APP_KEY @"f45qa-2-62dc674b3b680c922c990836fad70cd5"
#define FRESHDESK_APP_SECRET @"acbefeefa1acde41cc17c87354653eee40f573a0"

//#define FRESHDESK_APP_KEY @"f45test-2-98989d74f888e49cbdffbeffc06305b5"
//#define FRESHDESK_APP_SECRET @"738faf322c94e28e54f07a95141b6fc8b01e1af8"

/*********************** BASE URL ****************************/

#define BASE_URL @"http://f45.info/v1/"
#define BASE_API_URL @"http://oncanoe.com/api/"

/*********************** FONTS ****************************/

#define PROXIMA_NOVA_REGULAR @"ProximaNova-Regular"
#define PROXIMA_NOVA_SEMI_BOLD @"ProximaNova-SemiBold"
#define PROXIMA_NOVA_BOLD @"ProximaNova-Bold"

/*********************** COMMON DATA ****************************/

//colors
#define APP_COLOR [UIColor colorWithRed:60/255.0 green:59/255.0 blue:119/255.0 alpha:1]

//AlertView Titles
#define ALERT @"Alert"
#define OOPS @"Oops"

// AlertView Error Messages
#define SERVER_ERROR @"Server not responding. Please try again!"
#define INTERNET_ERROR @"Please Check Your Internet Connection!"


@interface Constants : NSObject

@end
