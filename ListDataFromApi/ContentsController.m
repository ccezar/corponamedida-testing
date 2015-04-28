//
//  ContentsController.m
//  ListDataFromApi
//
//  Created by Caio Cezar Lopes dos Santos on 25/04/15.
//  Copyright (c) 2015 Caio Cezar Lopes dos Santos. All rights reserved.
//

#import "ContentsController.h"

@interface ContentsController ()


@end

@implementation ContentsController

NSMutableArray *contents;
NSMutableArray *contentsID;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    contents = [NSMutableArray arrayWithObjects: @"Dicas", @"Artigos", @"Receitas", @"Vídeos", nil];
    contentsID = [NSMutableArray arrayWithObjects: @"Tips", @"Articles", @"Recipes", @"Videos", nil];
    [self.contentsTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [contents objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *segueIdentifier = [NSString stringWithFormat: @"%@Segue",
                                 [contentsID objectAtIndex: indexPath.row]];
    
    [self performSegueWithIdentifier: segueIdentifier
                              sender: [contents objectAtIndex: indexPath.row]];
}





























@end
