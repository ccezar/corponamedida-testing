//
//  PartnersController.h
//  ListDataFromApi
//
//  Created by Caio Cezar Lopes dos Santos on 25/04/15.
//  Copyright (c) 2015 Caio Cezar Lopes dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartnersController : UITableViewController <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *partnersTableView;

@end

