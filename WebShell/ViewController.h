//
//  ViewController.h
//  WebShell
//
//  Created by binwong on 12-11-23.
//  Copyright (c) 2012年 binwong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate>
{
@private
    NSDictionary *configData;
    UIWebView *myWebView;
}

@end
