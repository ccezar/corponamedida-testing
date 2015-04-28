//
//  ViewController.m
//  ListDataFromApi
//
//  Created by Caio Cezar Lopes dos Santos on 25/04/15.
//  Copyright (c) 2015 Caio Cezar Lopes dos Santos. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <MBProgressHUD.h>

@interface ViewController ()


@end

@implementation ViewController

NSMutableArray *tableData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBar setSelectedItem: [self.tabBar.items objectAtIndex: 0]];
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

- (void)fillTableWithArticles
{
    [self fillTableWithData:@"http://corponamedida.com.br/apimobile/listarartigos"];
}

- (void)fillTableWithRecipes
{
    [self fillTableWithData:@"http://corponamedida.com.br/apimobile/listarreceitas"];
}

- (void)fillTableWithVideos
{
    [self fillTableWithData:@"http://corponamedida.com.br/apimobile/listarvideos"];
}

- (void)fillTableWithData: (NSString *) url
{
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        tableData = [NSMutableArray arrayWithArray:responseObject];
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:true];
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        NSLog(@"Error: %@", error);
        [MBProgressHUD hideHUDForView:self.view animated:true];
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        
    }];
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[tableData objectAtIndex:indexPath.row] objectForKey: @"Titulo"];
    
    return cell;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    switch (item.tag) {
        case 0:
            [self fillTableWithTips];
            break;
        case 1:
            [self fillTableWithArticles];
            break;
        case 2:
            [self fillTableWithRecipes];
            break;
        case 3:
            //[self fillTableWithVideos];
            break;
    }
}

@end
