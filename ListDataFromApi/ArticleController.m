//
//  ArticleController.m
//  ListDataFromApi
//
//  Created by Caio Cezar Lopes dos Santos on 27/04/15.
//  Copyright (c) 2015 Caio Cezar Lopes dos Santos. All rights reserved.
//

#import "ArticleController.h"
#import <MBProgressHUD.h>

@interface ArticleController ()


@end

@implementation ArticleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webViewFullArticle.delegate = self;
    NSString *url = [NSString stringWithFormat: @"http://corponamedida.com.br/artigomobile/%@", self.articleID];
    [self.webViewFullArticle loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: url]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:true];
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

@end
