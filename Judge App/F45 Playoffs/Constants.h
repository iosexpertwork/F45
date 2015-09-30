//
//  Constants.h
//  canoe
//
//  Created by HashBrown Systems on 27/11/14.
//  Copyright (c) 2014 Hashbrown Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

// http://192.168.2.9/CanoeLocal/

/*********************** BASE URL ****************************/

#define BASE_URL @"http://f45.info/v1/"  //
#define BASE_F45_URL @"http://f45playoffs.herokuapp.com/v1/"
#define BASE_API_URL @"http://oncanoe.com/api/"

/*********************** FRESHDESK KEYS ****************************/

#define FRESHDESK_APP_KEY @"f45judge-2-9f7aaf4f0e3e6be9a1e1c87594853a99"
#define FRESHDESK_APP_SECRET @"5d8ccae48bc0d445d58a7a958ab9cd1fc165588b"

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
