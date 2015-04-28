//
//  ArticlesController.m
//  ListDataFromApi
//
//  Created by Caio Cezar Lopes dos Santos on 25/04/15.
//  Copyright (c) 2015 Caio Cezar Lopes dos Santos. All rights reserved.
//

#import "ArticlesController.h"
#import "ArticleController.h"
#import <AFNetworking.h>
#import <MBProgressHUD.h>

@interface ArticlesController ()


@end

@implementation ArticlesController

NSMutableArray *articles;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fillTableWithArticles];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fillTableWithArticles
{
    [self fillTableWithData:@"http://corponamedida.com.br/apimobile/listarartigos"];
}

- (void)fillTableWithData: (NSString *) url
{
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        articles = [NSMutableArray arrayWithArray:responseObject];
        [self.articlesTableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:true];
        [self.articlesTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        NSLog(@"Error: %@", error);
        [MBProgressHUD hideHUDForView:self.view animated:true];
        [self.articlesTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        
    }];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[articles objectAtIndex:indexPath.row] objectForKey: @"Titulo"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier: @"FullArticleSegue"
                              sender: [articles objectAtIndex: indexPath.row]];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *articleID = [sender objectForKey: @"ID"];
    
    ArticleController *controller = [segue destinationViewController];
    controller.articleID = articleID;
    
    
    
    //
}

@end
