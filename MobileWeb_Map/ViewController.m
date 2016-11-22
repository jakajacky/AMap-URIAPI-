//
//  ViewController.m
//  MobileWeb_Map
//
//  Created by xqzh on 16/11/21.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import "ViewController.h"
#import "AMapView.h"

@interface ViewController () <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) UIButton *reloadBtn;
@property (strong, nonatomic) AMapView *map;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  _map = [[AMapView alloc] initWithFrame:self.view.frame];
  [self.view addSubview:_map];
  CLLocationCoordinate2D start;
  CLLocationCoordinate2D end;
  start.latitude  = 39.997361;
  start.longitude = 116.478346;
  end.latitude    = 39.966577;
  end.longitude   = 116.3246;
  [_map setStartCoordinate:start StartPlace:@"我的位置" EndCoordinate:end endPlace:@"目标医院"];
  
//  NSURL *url = [NSURL URLWithString:@"http://m.amap.com/?from=39.997361,116.478346(from)&to=39.966577,116.3246(to)"];
//  NSURLRequest *request = [NSURLRequest requestWithURL:url];
//  [_webView loadRequest:request];
  
  _reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  _reloadBtn.frame = CGRectMake(self.view.frame.size.width - 50, 145.0, 35, 35);
  [_reloadBtn setImage:[UIImage imageNamed:@"reload"] forState:UIControlStateNormal];
  //    [_reloadBtn setBackgroundImage: forState:UIControlStateNormal];
  [self.view addSubview:_reloadBtn];
  [_reloadBtn addTarget:self action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
}

- (void)reload {
  [_map updateMapView];
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
  
  BOOL isHaveMapAPP = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap//"]];
  
  if ([[[request.URL absoluteString] substringToIndex:23] isEqualToString:@"http://itunes.apple.com"]) {
    
    
    
    
    if (isHaveMapAPP) {
      NSURL *url = [NSURL URLWithString:@"http://m.amap.com/?from=39.997361,116.478346(from)&to=39.966577,116.3246(to)"];
      NSURLRequest *request = [NSURLRequest requestWithURL:url];
      [webView loadRequest:request];
      return NO;
    }
    else {
      static dispatch_once_t onceToken;
      dispatch_once(&onceToken, ^{
        [webView loadRequest:request];
      });
      
      
      return YES;
    }
  }
  return YES;
}

@end
