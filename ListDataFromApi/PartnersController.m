//
//  PartnersController.m
//  ListDataFromApi
//
//  Created by Caio Cezar Lopes dos Santos on 25/04/15.
//  Copyright (c) 2015 Caio Cezar Lopes dos Santos. All rights reserved.
//

#import "PartnersController.h"

@interface PartnersController ()


@end

@implementation PartnersController

NSMutableArray *partners;
NSMutableArray *partnersID;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    partners = [NSMutableArray arrayWithObjects: @"Academias", @"Personal Trainers", @"Lojas de Suplemento", @"Nutricionistas", @"Assessorias Esportivas", nil];
    partnersID = [NSMutableArray arrayWithObjects: @"Gym", @"PersonalTrainers", @"SupplementStore", @"Nutrcionists", @"Nutrcionists", @"SportsConsultants", nil];
    [self.partnersTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [partners count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [partners objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *segueIdentifier = [NSString stringWithFormat: @"%@Segue",
                                 [partnersID objectAtIndex: indexPath.row]];
    
    [self performSegueWithIdentifier: segueIdentifier
                              sender: [partners objectAtIndex: indexPath.row]];
}





























@end
