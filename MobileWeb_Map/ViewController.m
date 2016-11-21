//
//  ViewController.m
//  MobileWeb_Map
//
//  Created by xqzh on 16/11/21.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

  @property (strong, nonatomic) IBOutlet UIWebView *webView;
  
  
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  NSURL *url = [NSURL URLWithString:@"http://m.amap.com/?from=39.997361,116.478346(from)&to=39.966577,116.3246(to)"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [_webView loadRequest:request];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
  
- (void)webViewDidStartLoad:(UIWebView *)webView {
  
}
  
- (void)webViewDidFinishLoad:(UIWebView *)webView {
  NSLog(@"---%@---", webView.request.URL);
}
  
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  
}
  
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  if ([[[request.URL absoluteString] substringToIndex:23] isEqualToString:@"http://itunes.apple.com"]) {
    NSURL *url = [NSURL URLWithString:@"http://m.amap.com/?from=39.997361,116.478346(from)&to=39.966577,116.3246(to)"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    return NO;
  }
  return YES;
}

@end
