//
//  MainScreenViewController.m
//  F45 Playoffs
//
//  Created by TED Solutions on 27/08/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import "MainScreenViewController.h"

@interface MainScreenViewController ()

@end

@implementation MainScreenViewController
@synthesize playerLbl, playerText, stationLbl, stationText, resultLbl, resultText, submitBtn, counterLbl ,logBtn;

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"station" object:nil];//
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectStation:) name:@"station" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"player" object:nil];//player
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedPlayer:) name:@"player" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"F45 Judge";
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UIBarButtonItem *logoutBtn=[[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    self.navigationItem.leftBarButtonItem=logoutBtn;
    
    UIBarButtonItem *helpBtn=[[UIBarButtonItem alloc]initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(help)];
    self.navigationItem.rightBarButtonItem=helpBtn;
    
    playerLbl.frame=CGRectMake(10, 15, self.view.frame.size.width, 20);
    playerText.frame=CGRectMake(10, playerLbl.frame.origin.y+playerLbl.frame.size.height, self.view.frame.size.width-20, 50);
    stationLbl.frame=CGRectMake(10, playerText.frame.origin.y+playerText.frame.size.height+15, self.view.frame.size.width, 20);
    stationText.frame=CGRectMake(10, stationLbl.frame.origin.y+stationLbl.frame.size.height, self.view.frame.size.width-20, 50);
    resultLbl.frame=CGRectMake(10, stationText.frame.origin.y+stationText.frame.size.height+15, self.view.frame.size.width, 20);
    resultText.frame=CGRectMake(10, resultLbl.frame.origin.y+resultLbl.frame.size.height, self.view.frame.size.width-20, 50);
    submitBtn.frame=CGRectMake(10, resultText.frame.origin.y+resultText.frame.size.height+15, self.view.frame.size.width-20, 55);
    counterLbl.frame=CGRectMake(0, self.view.frame.size.height-50-64, self.view.frame.size.width, 50);
    
    UIButton *searchBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setBackgroundColor:[UIColor colorWithRed:60/255.0 green:111/255.0 blue:218/255.0 alpha:1]];
    [searchBtn setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    
    playerText.rightView=searchBtn;
    playerText.rightViewMode=UITextFieldViewModeAlways;
    
    playerLbl.font=[UIFont fontWithName:PROXIMA_NOVA_BOLD size:15];
    stationLbl.font=[UIFont fontWithName:PROXIMA_NOVA_BOLD size:15];
    resultLbl.font=[UIFont fontWithName:PROXIMA_NOVA_BOLD size:15];
    
    playerLbl.textColor=APP_COLOR;
    stationLbl.textColor=APP_COLOR;
    resultLbl.textColor=APP_COLOR;
    
    [submitBtn setBackgroundColor:[UIColor colorWithRed:60/255.0 green:111/255.0 blue:218/255.0 alpha:1]];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn.titleLabel setFont:[UIFont fontWithName:PROXIMA_NOVA_BOLD size:20]];
    
    //    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(hideKeyboard)];
    //    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    //    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    //    toolbar.barTintColor=APP_COLOR;
    //    [toolbar setTranslucent:NO];
    //    toolbar.items = [NSArray arrayWithObjects:cancelButton,flexibleSpace,doneButton, nil];
    //    [toolbar setTintColor:[UIColor whiteColor]];
    //    resultText.inputAccessoryView = toolbar;
    //    playerText.inputAccessoryView = toolbar;
    
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    [self performSelector:@selector(updateTime) withObject:nil afterDelay:1];
    
    if(self.view.frame.size.height >= 667)
    {
        submitBtn.titleLabel.font  = [UIFont fontWithName:@"ProximaNova-Bold" size:30];
        
        counterLbl.font = [UIFont fontWithName:@"ProximaNova-Bold" size:120];
        playerLbl.font=[UIFont fontWithName:PROXIMA_NOVA_BOLD size:25];
        stationLbl.font=[UIFont fontWithName:PROXIMA_NOVA_BOLD size:25];
        resultLbl.font=[UIFont fontWithName:PROXIMA_NOVA_BOLD size:25];
        
        playerLbl.frame=CGRectMake(10, 15, self.view.frame.size.width, 30);
        playerText.frame=CGRectMake(10, playerLbl.frame.origin.y+playerLbl.frame.size.height+5, self.view.frame.size.width-20, 60);
        stationLbl.frame=CGRectMake(10, playerText.frame.origin.y+playerText.frame.size.height+15, self.view.frame.size.width, 30);
        stationText.frame=CGRectMake(10, stationLbl.frame.origin.y+stationLbl.frame.size.height+5, self.view.frame.size.width-20, 60);
        resultLbl.frame=CGRectMake(10, stationText.frame.origin.y+stationText.frame.size.height+15, self.view.frame.size.width, 30);
        resultText.frame=CGRectMake(10, resultLbl.frame.origin.y+resultLbl.frame.size.height+5, self.view.frame.size.width-20, 60);
        submitBtn.frame=CGRectMake(10, resultText.frame.origin.y+resultText.frame.size.height+15, self.view.frame.size.width-20, 70);
        counterLbl.frame = CGRectMake(0, counterLbl.frame.origin.y-80, counterLbl.frame.size.width, counterLbl.frame.size.height+80);
        
        playerText.font=[UIFont fontWithName:PROXIMA_NOVA_BOLD size:25];
        stationText.font=[UIFont fontWithName:PROXIMA_NOVA_BOLD size:25];
        resultText.font=[UIFont fontWithName:PROXIMA_NOVA_BOLD size:25];
        
    }
    vibrateCount = 0;
    
    searchBtn.frame = CGRectMake(0, 0, playerText.frame.size.height, playerText.frame.size.height);
    api=[[WebAPI alloc]init];
    api.delegate=self;
    playerList = [[NSArray alloc] init];
    [self callActivePlayerIDAPI];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
    
    logBtn.frame = CGRectMake(resultText.frame.origin.x, counterLbl.frame.origin.y-40, logBtn.frame.size.width, logBtn.frame.size.height);
}

#pragma mark -- Helper Method

-(void) callActivePlayerIDAPI
{
    if ([Helper isInternetConnected]==YES)
    {
        [api getAllActivePlayerList];
    }
    else
    {
        [[[UIAlertView alloc]initWithTitle:ALERT message:INTERNET_ERROR delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
    [self performSelector:@selector(callActivePlayerIDAPI) withObject:nil afterDelay:30];
}

-(void) vibrateDevice
{
    vibrateCount++;
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    
    if (vibrateCount == 1)
    {
        [self performSelector:@selector(vibrateDevice) withObject:nil afterDelay:0.3];
    }
    else
    {
        vibrateCount = 0;
    }
}

-(void)updateTime
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:[NSDate date]];
    
    long second = 60 - components.second;
    long secondToShow;
    if (second>15)
    {
        
        counterLbl.backgroundColor=[UIColor colorWithRed:17/255.0 green:122/255.0 blue:0/255.0 alpha:1];
        secondToShow=second-15;
    }
    else
    {
        switch (second)
        {
            case 15:
                //[self vibrateDevice];
                break;
                
            case 1:
                //[self performSelector:@selector(vibrateDevice) withObject:nil afterDelay:1.0f];
                break;
                
            default:
                break;
        }
        counterLbl.backgroundColor=[UIColor redColor];
        secondToShow=second;
    }
    if (secondToShow<10)
    {
        counterLbl.text=[NSString stringWithFormat:@"0%ld", secondToShow];
    }
    else
    {
        counterLbl.text=[NSString stringWithFormat:@"%ld", secondToShow];
    }
    
    [self performSelector:@selector(updateTime) withObject:nil afterDelay:1];
}

#pragma mark -- Button Action

- (IBAction)openLog:(id)sender
{
    LogViewController *logController = [self.storyboard instantiateViewControllerWithIdentifier:@"log"];
    [self presentViewController:logController animated:YES completion:nil];
}

- (IBAction)submit:(id)sender
{
    if (playerText.text.length==0)
    {
        [[[UIAlertView alloc]initWithTitle:@"Booking ID" message:@"Please enter booking id." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
    else if (stationText.text.length==0 || stationId == nil)
    {
        [[[UIAlertView alloc]initWithTitle:@"Station ID" message:@"Please select station id." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
    else if (resultText.text.length==0)
    {
        [[[UIAlertView alloc]initWithTitle:@"Result" message:@"Please enter result." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
    else
    {
        [self hideKeyboard];
        double time = [[NSDate date] timeIntervalSince1970];
        NSString *stamp=[NSString stringWithFormat:@"%.0f", time];
        
        NSDictionary *resultsDictionary = [[NSDictionary alloc]initWithObjects:@[playerText.text, stationId, resultText.text, stamp,@"1"] forKeys:@[@"player_id", @"station_id", @"result", @"timestamp",@"judge_id"]];
        
        [DBHandler saveData:resultsDictionary];
        
        resultText.text = @"";
        
        if ([Helper isInternetConnected] == YES)
        {
            [self postCachedData];
        }
    }
}

-(void) postCachedData
{
    NSManagedObjectContext *managedObjectContext = [DBHandler managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Submit"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"status = 0"];
    [fetchRequest setPredicate:predicate];
    
    NSArray *fetchedObjects = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES];
    
    NSArray *sortedResults = [fetchedObjects sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    for (NSManagedObject *obj in sortedResults)
    {
        NSDictionary *dictionary = [[NSDictionary alloc] initWithObjects:@[[obj valueForKey:@"player_id"],[obj valueForKey:@"station_id"],[obj valueForKey:@"result"],[obj valueForKey:@"time"],[obj valueForKey:@"judge_id"],[obj valueForKey:@"status"]] forKeys:@[@"player_id", @"station_id", @"result", @"timestamp",@"judge_id",@"status"]];
        
        NSLog(@"dictionary stored in database %@", dictionary);
        
        [self submitData:dictionary];
    }
}

-(void) submitData:(NSDictionary *) dic
{
    @try {
        NSString *data=[NSString stringWithFormat:@"judge_id=1&results=[{\"player_id\":%@, \"station_id\":%@, \"result\":%@, \"timestamp\":%@}]",[dic objectForKey:@"player_id"], [dic objectForKey:@"station_id"], [dic objectForKey:@"result"], [dic objectForKey:@"timestamp"]];
        NSData *sendingdata = [data dataUsingEncoding:NSASCIIStringEncoding];
        NSInteger length = sendingdata.length;
        
        NSURL *aUrl = [NSURL URLWithString:@"http://f45playoffs.herokuapp.com/v1/results/add"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:60.0];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:[NSString stringWithFormat:@"%d",length] forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:sendingdata];
        
        NSLog(@"Posting Data: %@",data);
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            if (data != nil)
            {
                NSDictionary *recObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"response is %@",recObj);
                
                if ([[recObj objectForKey:@"success"] integerValue] == 1)
                {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSPredicate *pred =  [NSPredicate predicateWithFormat:@"time = %@", [dic objectForKey:@"timestamp"]];
                        
                        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Submit"];
                        [fetchRequest setPredicate:pred];
                        NSArray *results = [[[DBHandler managedObjectContext] executeFetchRequest:fetchRequest error:nil] mutableCopy];
                        
                        if (results.count > 0)
                        {
                            NSManagedObject *objToUpdate = [results objectAtIndex:0];
                            [objToUpdate setValue:@"1" forKey:@"status"];
                            [[DBHandler managedObjectContext] save:nil];
                        }
                    });
                }
            }
        }];
        
    }
    @catch (NSException *exception) {
        NSLog(@"Exception Came: %@",exception);
    }
}

-(void)logout
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"email"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"name"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"franchisee_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    LoginViewController *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self.navigationController setViewControllers:@[controller] animated:YES];
}

-(void)hideKeyboard
{
    //    resultText.text=@"";
    //    playerText.text=@"";
    [resultText resignFirstResponder];
    [playerText resignFirstResponder];
}

-(void)done
{
    [resultText resignFirstResponder];
    [playerText resignFirstResponder];
}

-(void)search
{
    [playerText resignFirstResponder];
    PlayersViewController *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"player"];
    controller.playerList = playerList;
    if (playerList.count == 0)
    {
        shouldPushNotification = YES;
    }
    UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:controller];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

-(void)help
{
    [[Mobihelp sharedInstance] presentSupport:self];
    [[Mobihelp sharedInstance] addCustomDataForKey:@"Name" withValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"name"]];
    [[Mobihelp sharedInstance] addCustomDataForKey:@"Franchisee_id" withValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"franchisee_id"]];
    [[Mobihelp sharedInstance] setUserName:[[NSUserDefaults standardUserDefaults]objectForKey:@"name"]];
    [[Mobihelp sharedInstance] setEmailAddress:[[NSUserDefaults standardUserDefaults]objectForKey:@"email"]];
}

#pragma mark Keyboard Movements

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    if ([resultText isFirstResponder])
    {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = -keyboardSize.height+190;
            self.view.frame = f;
        }];
    }
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView transitionWithView:self.view duration:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
        if ([resultText isFirstResponder])
        {
        CGRect f = self.view.frame;
        f.origin.y = [UIApplication sharedApplication].statusBarFrame.size.height+self.navigationController.navigationBar.frame.size.height;
        self.view.frame = f;
        }
    } completion:nil];
}

#pragma mark -- APIs Delegate

-(void)callbackFromAPI:(id)response
{
    [Helper hideIndicatorFromView:self.view];
}

-(void)callBackActivePlayerListSuccess:(NSArray *)list
{
    playerList=list;
    if (shouldPushNotification == YES)
    {
        shouldPushNotification = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerList" object:playerList];
    }
}

#pragma mark -- NSNotification Method

-(void)selectStation:(NSNotification *)notification
{
    NSDictionary *station=notification.object;
    stationText.text=[station objectForKey:@"name"];
    stationId=[station objectForKey:@"id"];
}

-(void)selectedPlayer:(NSNotification *)notification
{
    NSDictionary *dic = notification.object;
    playerText.text=[NSString stringWithFormat:@"%ld", (long)[[dic objectForKey:@"id"] integerValue]];
}

#pragma mark -- UITextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag==2)
    {
        ListViewController *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"list"];
        UINavigationController *navcontroller=[[UINavigationController alloc]initWithRootViewController:controller];
        [self.navigationController presentViewController:navcontroller animated:YES completion:nil];
        return NO;
    }
    else
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        if (self.view.frame.size.height==480-64)
        {
            [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-80, self.view.frame.size.width, self.view.frame.size.height)];
        }
        [UIView commitAnimations];
        return YES;
    }
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    if (self.view.frame.size.height==480)
    {
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+80, self.view.frame.size.width, self.view.frame.size.height)];
    }
    [UIView commitAnimations];
    return YES;
}

#pragma mark -- Memory Warning

- (void)didReceiveMemoryWarning {
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
