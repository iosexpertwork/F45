//
//  BottomBar.m
//  infoApp
//
//  Created by HashBrown Systems on 05/09/14.
//  Copyright (c) 2014 Hashbrown Systems Pvt Ltd. All rights reserved.
//

#import "BottomBar.h"

@implementation BottomBar

-(void)showBottomBar:(UITabBarController *)tabBarController
{
    tabBarController.view.backgroundColor=[UIColor whiteColor];
    
    
    
    UIImage *selectedImage0;
    UIImage *unselectedImage0;
    UIImage *selectedImage1;
    UIImage *unselectedImage1;
    UIImage *selectedImage2;
    UIImage *unselectedImage2;
    UIImage *selectedImage3;
    UIImage *unselectedImage3;
    selectedImage0   = [UIImage imageNamed:@"dashboard_Sel.png"];
    unselectedImage0 = [UIImage imageNamed:@"dashboard.png"];
    
    selectedImage1   = [UIImage imageNamed:@"meals_Select.png"];
    unselectedImage1 = [UIImage imageNamed:@"meals.png"];
    
    selectedImage2   = [UIImage imageNamed:@"blog_Sel.png"];
    unselectedImage2 = [UIImage imageNamed:@"blog.png"];
    
    selectedImage3   = [UIImage imageNamed:@"goals_Sel.png"];
    unselectedImage3 = [UIImage imageNamed:@"goals.png"];
    

    
    
    
    
    
    
//    UIImage *selectedImage0 = [UIImage imageNamed:@"dashboardBG.png"];
//    UIImage *unselectedImage0 = [UIImage imageNamed:@"dashboardS.png"];
//    
//    UIImage *selectedImage1 = [UIImage imageNamed:@"MealsSel.png"];
//    UIImage *unselectedImage1 = [UIImage imageNamed:@"MealsBG.png"];
//    
//    UIImage *selectedImage2 = [UIImage imageNamed:@"BlogS.png"];
//    UIImage *unselectedImage2 = [UIImage imageNamed:@"BlogBG.png"];
//    
//    UIImage *selectedImage3 = [UIImage imageNamed:@"Goalsel.png"];
//    UIImage *unselectedImage3 = [UIImage imageNamed:@"GoalsBG.png"];
    
    selectedImage0 = [selectedImage0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    unselectedImage0 = [unselectedImage0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedImage1 = [selectedImage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    unselectedImage1 = [unselectedImage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedImage2 = [selectedImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    unselectedImage2 = [unselectedImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedImage3 = [selectedImage3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    unselectedImage3 = [unselectedImage3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    UITabBarItem *item3 = [tabBar.items objectAtIndex:3];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7)
    {
        [item0 setFinishedSelectedImage:selectedImage0 withFinishedUnselectedImage:unselectedImage0];
        [item1 setFinishedSelectedImage:selectedImage1 withFinishedUnselectedImage:unselectedImage1];
        [item2 setFinishedSelectedImage:selectedImage2 withFinishedUnselectedImage:unselectedImage2];
        [item3 setFinishedSelectedImage:selectedImage3 withFinishedUnselectedImage:unselectedImage3];
    }
    else
    {
        item0.image=unselectedImage0;
        item1.image=unselectedImage1;
        item2.image=unselectedImage2;
        item3.image=unselectedImage3;
        
        item0.selectedImage=selectedImage0;
        item1.selectedImage=selectedImage1;
        item2.selectedImage=selectedImage2;
        item3.selectedImage=selectedImage3;
    }
    
    item0.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    item1.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    item2.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    item3.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
}

@end
