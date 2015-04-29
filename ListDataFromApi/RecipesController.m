//
//  RecipesController.m
//  ListDataFromApi
//
//  Created by Caio Cezar Lopes dos Santos on 25/04/15.
//  Copyright (c) 2015 Caio Cezar Lopes dos Santos. All rights reserved.
//

#import "RecipesController.h"
#import "RecipeController.h"
#import <AFNetworking.h>
#import <MBProgressHUD.h>

@interface RecipesController ()


@end

@implementation RecipesController

NSMutableArray *recipes;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fillTableWithRecipes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fillTableWithRecipes
{
    [self fillTableWithData:@"http://corponamedida.com.br/apimobile/listarreceitas"];
}

- (void)fillTableWithData: (NSString *) url
{
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        recipes = [NSMutableArray arrayWithArray:responseObject];
        [self.recipesTableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:true];
        [self.recipesTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        NSLog(@"Error: %@", error);
        [MBProgressHUD hideHUDForView:self.view animated:true];
        [self.recipesTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        
    }];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[recipes objectAtIndex:indexPath.row] objectForKey: @"Titulo"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier: @"FullRecipeSegue"
                              sender: [recipes objectAtIndex: indexPath.row]];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *recipeID = [sender objectForKey: @"ID"];
    
    RecipeController *controller = [segue destinationViewController];
    controller.recipeID = recipeID;
}


@end
