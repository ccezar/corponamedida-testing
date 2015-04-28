//
//  ArticleController.h
//  ListDataFromApi
//
//  Created by Caio Cezar Lopes dos Santos on 27/04/15.
//  Copyright (c) 2015 Caio Cezar Lopes dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webViewFullArticle;

@property (weak, nonatomic) NSString *articleID; 

@end

