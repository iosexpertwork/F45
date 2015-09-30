//
//  MainViewController.m
//  F45Feedback
//
//  Created by Paras on 9/4/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController
@synthesize topBar,questionLabel, awfulBtn, badBtn, okBtn, goodBtn, greatBtn;

-(void)viewDidAppear:(BOOL)animated
{
    //[[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NSLog(@"Reachability changed: %@", AFStringFromNetworkReachabilityStatus(status));
        
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                // -- Reachable -- //
                NSLog(@"Reachable");
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                // -- Not reachable -- //
                NSLog(@"Not Reachable");
                awfulBtn.userInteractionEnabled = YES;
                badBtn.userInteractionEnabled = YES;
                okBtn.userInteractionEnabled = YES;
                goodBtn.userInteractionEnabled = YES;
                greatBtn.userInteractionEnabled = YES;
                break;
        }
        
        if([Helper isInternetWorking] == YES)
        {
            [self getQuestionsFromServer];
        }
        
        if ([Helper isInternetWorking] == YES)
        {
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"answers"] != nil)
            {
                cachedAnswers = [[NSUserDefaults standardUserDefaults] objectForKey:@"answers"];
                awfulBtn.userInteractionEnabled = NO;
                badBtn.userInteractionEnabled = NO;
                okBtn.userInteractionEnabled = NO;
                goodBtn.userInteractionEnabled = NO;
                greatBtn.userInteractionEnabled = NO;
                
                [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                [SVProgressHUD showWithStatus:@"Sending Cached Answers..."];
                
                totalCachedAnswers = cachedAnswers.count;
                
                for (NSDictionary *answer in cachedAnswers)
                {
                    [self sendRating:answer];
                }
                
            }
        }
        
    }];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    currentIndex = 0;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.navigationController.navigationBarHidden = YES;
    topBar.layer.shadowColor = [[Helper colorFromHexString:@"2e3265"] CGColor];
    topBar.layer.shadowOffset = CGSizeMake(0, 2);
    topBar.layer.shadowOpacity = 0.3;
    topBar.layer.shadowRadius = 2;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"latestQuestions"] != nil)
    {
        questions = [[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"latestQuestions"]] objectForKey:@"data"];
    }
    else
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"questions.json"];
        
        
        NSError *deserializingError;
        NSURL *localFileURL = [NSURL fileURLWithPath:path];
        NSData *contentOfLocalFile = [NSData dataWithContentsOfURL:localFileURL];
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:contentOfLocalFile
                                                             options:0
                                                               error:&deserializingError];
        questions = [data objectForKey:@"data"];
    }
    
    totalCountOfQuestions = questions.count;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"weightage" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    weightedQuestons = [questions sortedArrayUsingDescriptors:sortDescriptors];
    questionLabel.text = [[weightedQuestons objectAtIndex:currentIndex] objectForKey:@"question"];
    manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 5;
    
}

#pragma mark button actions

-(IBAction) ratingBtnTapped:(id)sender
{
    UIButton *ratingBtn = (UIButton *) sender;
    NSLog(@"%@",[ratingBtn titleForState:UIControlStateNormal]);
    
    if ([Helper isInternetWorking] == YES)
    {
        long long milliseconds = (long long)([[NSDate date] timeIntervalSince1970] * 1000.0);
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithLongLong:milliseconds],@"timestamp",[[NSUserDefaults standardUserDefaults] objectForKey:@"franchisee_id"],@"franchisee_id",@"",@"reviewer",[NSArray arrayWithObject:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:ratingBtn.tag],@"value",[NSNumber numberWithInt:[[[weightedQuestons objectAtIndex:currentIndex] objectForKey:@"id"] integerValue]],@"key", nil]],@"skill_answers", nil];
        value = ratingBtn.tag;
        key = [[[weightedQuestons objectAtIndex:currentIndex] objectForKey:@"id"] integerValue];
        [self blackoutButtons:ratingBtn];
        [self sendRating:dict];
        [self showThanksToast];
    }
    else
    {
        [self showThanksToast];
        [self cacheQuestion:[[[weightedQuestons objectAtIndex:currentIndex] objectForKey:@"id"] integerValue] withRating:ratingBtn.tag];
        [self blackoutButtons:ratingBtn];
        [self performSelector:@selector(resetButtons) withObject:nil afterDelay:0.3];
    }
}

- (IBAction)showLogoutView:(id)sender
{
    UIButton *button = (UIButton *) sender;
    PopoverViewController *PopoverView =[self.storyboard instantiateViewControllerWithIdentifier:@"popoverView"];
    popOver =[[UIPopoverController alloc] initWithContentViewController:PopoverView];
    NSLog(@"%f", button.frame.origin.x);
    [popOver presentPopoverFromRect:CGRectMake(30, 65, 50, 0) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark Helper Methods

-(void)viewWillLayoutSubviews
{
    CGFloat spacing = 100;
    
    // lower the text and push it left so it appears centered
    //  below the image
    CGSize imageSize = awfulBtn.imageView.image.size;
    awfulBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    badBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    okBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    goodBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    greatBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    
    // raise the image and push it right so it appears centered
    //  above the text
    CGSize awfulTitleSize = [awfulBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: awfulBtn.titleLabel.font}];
    awfulBtn.imageEdgeInsets = UIEdgeInsetsMake(- (awfulTitleSize.height), 0.0, 0.0, - awfulTitleSize.width);
    
    CGSize badTitleSize = [badBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: badBtn.titleLabel.font}];
    badBtn.imageEdgeInsets = UIEdgeInsetsMake(- (badTitleSize.height), 0.0, 0.0, - badTitleSize.width);
    
    CGSize okTitleSize = [okBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: okBtn.titleLabel.font}];
    okBtn.imageEdgeInsets = UIEdgeInsetsMake(- (okTitleSize.height), 0.0, 0.0, - okTitleSize.width);

    CGSize goodTitleSize = [goodBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: goodBtn.titleLabel.font}];
    goodBtn.imageEdgeInsets = UIEdgeInsetsMake(- (goodTitleSize.height), 0.0, 0.0, - goodTitleSize.width);

    CGSize greatTitleSize = [greatBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: greatBtn.titleLabel.font}];
    greatBtn.imageEdgeInsets = UIEdgeInsetsMake(- (greatTitleSize.height), 0.0, 0.0, - greatTitleSize.width);
    
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait)
    {
        _questionTopConstraint.constant = 300;
        _awfulConstraint.constant = 236;
        _badConstraint.constant = 236;
        _okConstraint.constant = 236;
        _goodConstraint.constant = 236;
        _greatConstraint.constant = 236;
    }
    else
    {
        _questionTopConstraint.constant = 0;
        _awfulConstraint.constant = 0;
        _badConstraint.constant = 0;
        _okConstraint.constant = 0;
        _goodConstraint.constant = 0;
        _greatConstraint.constant = 0;
    }
}

-(void) getQuestionsFromServer
{
    @try {
        
        [manager GET:@"http://f45.info/v1/feedback-questions" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:responseObject];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"latestQuestions"];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"latestQuestionsFromServer"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self sortLatestQuestions];
            NSLog(@"New Questions Loaded");
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Questions loading error: %@",[error localizedDescription]);
        }];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

-(void) sendRating:(NSDictionary *) answer
{
    NSLog(@"answer is %@",answer);
    
    [manager POST:@"http://f45.info/v1/feedback/add" parameters:answer success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @try {
            NSLog(@"%@",responseObject);
            
            if ([[responseObject objectForKey:@"success"] integerValue] == 1)
            {
                if (totalCachedAnswers > 0)
                {
                    totalCachedAnswers = totalCachedAnswers - 1;
                    
                    if (totalCachedAnswers == 0)
                    {
                        awfulBtn.userInteractionEnabled = YES;
                        badBtn.userInteractionEnabled = YES;
                        okBtn.userInteractionEnabled = YES;
                        goodBtn.userInteractionEnabled = YES;
                        greatBtn.userInteractionEnabled = YES;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [SVProgressHUD dismiss];
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"answers"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                        });
                    }
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self resetButtons];
                    });
                }
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self cacheQuestion:key withRating:value];
            [self blackoutButtons:currentRatingButton];
            [self performSelector:@selector(resetButtons) withObject:nil afterDelay:0.3];
        });
    }];
}

-(void) cacheQuestion:(int ) questionID withRating:(int ) rating
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"answers"])
    {
        NSMutableArray *savedArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"answers"] mutableCopy];
        long long milliseconds = (long long)([[NSDate date] timeIntervalSince1970] * 1000.0);
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithLongLong:milliseconds],@"timestamp",[[NSUserDefaults standardUserDefaults] objectForKey:@"franchisee_id"],@"franchisee_id",@"",@"reviewer",[NSArray arrayWithObject:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:rating],@"value",[NSNumber numberWithInt:questionID],@"key", nil]],@"skill_answers", nil];
        [savedArray addObject:dict];
        [self writeJSONData:savedArray];
    }
    else
    {
        long long milliseconds = (long long)([[NSDate date] timeIntervalSince1970] * 1000.0);
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithLongLong:milliseconds],@"timestamp",[[NSUserDefaults standardUserDefaults] objectForKey:@"franchisee_id"],@"franchisee_id",@"",@"reviewer",[NSArray arrayWithObject:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:rating],@"value",[NSNumber numberWithInt:questionID],@"key", nil]],@"skill_answers", nil];
        NSArray *answersData = [[NSArray alloc] initWithObjects:dict, nil];
        [self writeJSONData:answersData];
    }
}

-(void) writeJSONData:(NSArray *) data
{
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"answers"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) blackoutButtons:(UIButton*) ratingBtn
{
    awfulBtn.userInteractionEnabled = NO;
    badBtn.userInteractionEnabled = NO;
    okBtn.userInteractionEnabled = NO;
    goodBtn.userInteractionEnabled = NO;
    greatBtn.userInteractionEnabled = NO;
    
    for (int i = ratingBtn.tag ; i >= 1 ; i--)
    {
        UIButton *btn = (UIButton *) [self.view viewWithTag:i];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.2;
        transition.type = kCATransitionFade;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [btn.layer addAnimation:transition forKey:nil];
        [btn setBackgroundImage:[UIImage imageNamed:@"star_bg_clicked.png"] forState:UIControlStateNormal];
    }
}

-(void) resetButtons
{
    for (int i = 1 ; i <= 5 ; i++)
    {
        UIButton *btn = (UIButton *) [self.view viewWithTag:i];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.2;
        transition.type = kCATransitionFade;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [btn.layer addAnimation:transition forKey:nil];
        [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    currentIndex++;
 
    if (currentIndex < totalCountOfQuestions)
    {
        if (sortedLatestQuestionArray.count == 0)
        {
            questionLabel.text = [[weightedQuestons objectAtIndex:currentIndex] objectForKey:@"question"];
        }
        else
        {
            totalCountOfQuestions = sortedLatestQuestionArray.count;
            if (currentIndex > totalCountOfQuestions)
            {
                currentIndex = 0;
            }
            questionLabel.text = [[sortedLatestQuestionArray objectAtIndex:currentIndex] objectForKey:@"question"];
        }
    }
    else
    {
        currentIndex = 0;
        questionLabel.text = [[weightedQuestons objectAtIndex:currentIndex] objectForKey:@"question"];
    }
    
    awfulBtn.userInteractionEnabled = YES;
    badBtn.userInteractionEnabled = YES;
    okBtn.userInteractionEnabled = YES;
    goodBtn.userInteractionEnabled = YES;
    greatBtn.userInteractionEnabled = YES;
}

-(void) sortLatestQuestions
{
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"latestQuestionsFromServer"]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"weightage" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    sortedLatestQuestionArray = [[dict objectForKey:@"data"] sortedArrayUsingDescriptors:sortDescriptors];
}

-(void) showThanksToast
{
    [self.view makeToast:@"Thanks" duration:1.5 position:CSToastPositionBottom];
}

@end
