//
//  VideosController.m
//  ListDataFromApi
//
//  Created by Caio Cezar Lopes dos Santos on 25/04/15.
//  Copyright (c) 2015 Caio Cezar Lopes dos Santos. All rights reserved.
//

#import "VideosController.h"
#import <AFNetworking.h>
#import <MBProgressHUD.h>

@interface VideosController ()


@end

@implementation VideosController

NSMutableArray *videos;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fillTableWithVideos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fillTableWithVideos
{
    [self fillTableWithData:@"http://corponamedida.com.br/apimobile/listarartigos"];
}

- (void)fillTableWithData: (NSString *) url
{
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        videos = [NSMutableArray arrayWithArray:responseObject];
        [self.videosTableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:true];
        [self.videosTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        NSLog(@"Error: %@", error);
        [MBProgressHUD hideHUDForView:self.view animated:true];
        [self.videosTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        
    }];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [videos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[videos objectAtIndex:indexPath.row] objectForKey: @"Titulo"];
    
    return cell;
}

@end
