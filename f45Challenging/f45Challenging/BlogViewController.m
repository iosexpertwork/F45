//
//  BlogViewController.m
//  f45Challenging
//
//  Created by Paras on 9/28/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import "BlogViewController.h"
#import "BlogTableViewCell.h"
@interface BlogViewController ()

@end

@implementation BlogViewController

- (void)viewDidLoad {
    
    
    BottomBar *bar=[[BottomBar alloc]init];
    [bar showBottomBar:self.tabBarController];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableVieww cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _cellObj = (BlogTableViewCell *)[tableVieww dequeueReusableCellWithIdentifier:@"Cell"];
    
    
    if (_cellObj == nil) {
        {
            
            [[NSBundle mainBundle]loadNibNamed:@"BlogTableViewCell" owner:self options:nil];
            
            //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        _cellObj.backgroundColor=[UIColor clearColor];
        
        tableVieww.separatorColor=[UIColor colorWithRed:73.0/255.0 green:66.0/255.0 blue:76.0/255.0 alpha:1.0];
        
        // Configure the cell...
        
        
        
        // cell.imageView.image=[UIImage imageNamed:[listOfArrayImages objectAtIndex:indexPath.row]];
        // cell.textLabel.text=[[arSelectedRows objectAtIndex:indexPath.row]valueForKey:@"cat_name"];
    }
    //    _userImage.clipsToBounds = YES;
    //    [self setRoundedView:_userImage toDiameter:55.0];
    //    [_userImage.layer setBorderColor: [[UIColor colorWithRed:233.0/255.0 green:98.0/255.0 blue:98/255.0 alpha:1.0]CGColor]];
    //    rating.text= [[array objectAtIndex:indexPath.row]valueForKey:@"rating"];
    //    NSLog(@"%@",_name.text);
    //    NSLog(@"%@",_userImage);
    //    float theFloat = [[[array objectAtIndex:indexPath.row]valueForKey:@"rating"] floatValue];
    //    int rounded = lroundf(theFloat);
    //    NSLog(@"%d",rounded);
    //    self.imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",rounded]];
    //    UIView *bgColorView = [[UIView alloc] init];
    //    [bgColorView setBackgroundColor:[UIColor clearColor]];
    //    [_cellObj setSelectedBackgroundView:bgColorView];
    //
    //
    //    [_userImage.layer setBorderWidth: 2.0];
    return _cellObj;
    
    
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
