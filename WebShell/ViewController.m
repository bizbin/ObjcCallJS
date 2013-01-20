//
//  ViewController.m
//  WebShell
//
//  Created by binwong on 12-11-23.
//  Copyright (c) 2012年 binwong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //加载配置
    NSString *path = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
    configData = [NSDictionary dictionaryWithContentsOfFile:path];
    [configData retain];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *resPath = [bundle resourcePath];
    NSString *filePath = [resPath stringByAppendingPathComponent:[configData objectForKey:@"home"]];

    myWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [myWebView loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initFileURLWithPath:filePath]]];
    myWebView.delegate = self;
    
    [self.view addSubview:myWebView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *jsCode = [NSString stringWithFormat:@"alert(1);"];
    [myWebView stringByEvaluatingJavaScriptFromString:jsCode];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    NSLog(@"shouldStartLoadWithRequest:%@", [url host]);
    if ([[url scheme] isEqualToString:@"feeyar"]) {
        if ([[url host] isEqualToString:@"alert"]) {
            [self showAlert];
        } else {
            NSLog(@"[WARNING]: Received unknown command %@://%@", @"feeyar", [url host]);
        }
        return NO;
    }
    return YES;
}

- (void)showAlert
{
    NSString *params = [myWebView stringByEvaluatingJavaScriptFromString:@"JSPlugin.getJSData();"];
    UIAlertView* alertView = [[[UIAlertView alloc] initWithTitle:@"Message from javascript"
                                                         message:params
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil]
                              autorelease];
    [alertView show];

}


@end
