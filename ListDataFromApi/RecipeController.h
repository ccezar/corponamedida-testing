//
//  RecipeController.h
//  ListDataFromApi
//
//  Created by Caio Cezar Lopes dos Santos on 28/04/15.
//  Copyright (c) 2015 Caio Cezar Lopes dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webViewFullRecipe;

@property (weak, nonatomic) NSString *recipeID;

@end

