//
//  TipsController.m
//  ListDataFromApi
//
//  Created by Caio Cezar Lopes dos Santos on 25/04/15.
//  Copyright (c) 2015 Caio Cezar Lopes dos Santos. All rights reserved.
//

#import "TipsController.h"
#import "TipController.h"
#import <AFNetworking.h>
#import <MBProgressHUD.h>

@interface TipsController ()


@end

@implementation TipsController

NSMutableArray *tips;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fillTableWithTips];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fillTableWithTips
{
    [self fillTableWithData:@"http://corponamedida.com.br/apimobile/listardicas"];
}

- (void)fillTableWithData: (NSString *) url
{
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        tips = [NSMutableArray arrayWithArray:responseObject];
        [self.tipsTableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:true];
        [self.tipsTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        NSLog(@"Error: %@", error);
        [MBProgressHUD hideHUDForView:self.view animated:true];
        [self.tipsTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        
    }];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tips count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[tips objectAtIndex:indexPath.row] objectForKey: @"Titulo"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier: @"FullTipSegue"
                              sender: [tips objectAtIndex: indexPath.row]];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *tipID = [sender objectForKey: @"ID"];
    
    TipController *controller = [segue destinationViewController];
    controller.tipID = tipID;
}

@end
