//
//  Tabbar.m
//  f45Challenging
//
//  Created by Paras on 9/28/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import "Tabbar.h"

@interface Tabbar ()

@end

@implementation Tabbar

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }
//                                             forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }
//                                             forState:UIControlStateSelected];
    
//    [yourTabBarItem setSelectedImage:[[UIImage imageNamed:@"more.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    [[self tabBar] setTintColor:[UIColor whiteColor]];
    _tabbar.tabBar.layer.borderWidth=1.0;
    _tabbar.tabBar.layer.borderColor=(__bridge CGColorRef)([UIColor grayColor]);
    _tabbar.tabBar.backgroundColor=[UIColor whiteColor];
    for(UITabBarItem *tbItem in [[self tabBar] items])
    {
        //[_tabbar.tabBar addObject:tbItem];
        [tbItem setFinishedSelectedImage:[self imageForTabBarItem:0 selected:YES]
             withFinishedUnselectedImage:[self imageForTabBarItem:0 selected:YES]];
    }
    
    
    // Do any additional setup after loading the view.
}
- (UIImage *)imageForTabBarItem:(int)tab selected:(BOOL)selected
{
    NSString *imageName;
    switch(tab)
    {
        case 0:
            imageName = [NSString stringWithFormat:@"btn_bg_2-1.png"];
            break;
        case 1:
            imageName = [NSString stringWithFormat:@"nav_two_%@.png", selected ? @"on":@"off"];
            break;
        case 2:
            imageName = [NSString stringWithFormat:@"nav_three_%@.png", selected ? @"on":@"off"];
            break;
        case 3:
            imageName = [NSString stringWithFormat:@"nav_three_%@.png", selected ? @"on":@"off"];
            break;
    }
    return [UIImage imageNamed:imageName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
