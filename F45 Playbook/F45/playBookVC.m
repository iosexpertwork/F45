//
//  playBookVC.m
//  F45
//
//  Created by Paras on 9/21/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import "playBookVC.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "UIViewController+MMDrawerController.h"
#import "RightViewController.h"


@interface playBookVC ()

@end

@implementation playBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if([UIScreen mainScreen].bounds.size.height == 568.0)
    {
    
_scroll_View.contentSize=CGSizeMake(320, 1220);
    }
    else
    {
        _scroll_View.contentSize=CGSizeMake(320, 1300);
    }
    
 _GenerateScore.layer.cornerRadius = 5;
    
    _GenerateScore.clipsToBounds = YES;
           // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
     }
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_name resignFirstResponder];
    [_textField1 resignFirstResponder];
    
    [_textField2 resignFirstResponder];
    
    [_textField3 resignFirstResponder];
    
    [_textField4 resignFirstResponder];
    [_textField5 resignFirstResponder];
    
    [_textFiled6 resignFirstResponder];
    [_textField7 resignFirstResponder];
    
    [_textField8 resignFirstResponder];

    [_textField9 resignFirstResponder];
    
    [_textField10 resignFirstResponder];
    [_name resignFirstResponder];
    
    [_email resignFirstResponder];
    
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)RightMenu:(id)sender {
     [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (IBAction)GenerateAction:(id)sender
{
    if ([_textField1.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Values Required!" message:@"Please Enter Rowing" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([_textField2.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Values Required!" message:@"Enter Bench Hop" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([_textField3.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Values Required!" message:@" Enter Push Up Knee Tuck" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([_textField4.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Values Required!" message:@"Enter Lateral Hops" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([_textField5.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Values Required!" message:@" Enter Box jump +Burpee" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([_textFiled6.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Values Required!" message:@"Enter Chin Ups" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([_textField7.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Values Required!" message:@"Enter Squat +Press" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([_textField8.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Values Required!" message:@"Enter Russian Twist" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([_textField9.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Values Required!" message:@" Enter Deadball Over the Shoulder Throw" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if ([_textField10.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Values Required!" message:@" Enter Sprint and Lateral Hop" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([_name.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Values Required!" message:@" Enter the Name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

    else if ([_email.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Values Required!" message:@" Enter the Email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }


}

- (IBAction)logout:(id)sender
{
    
    UIActionSheet *actionSheet_popupQuery = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"logout", nil];
    actionSheet_popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet_popupQuery showInView:self.view];

}
#pragma Mark -Action sheet Delegate Method:-
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    
    if(buttonIndex == 0)
    {
        [self.mm_drawerController  setCenterViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"login"] withCloseAnimation:YES completion:nil];
        
    }
}
@end
