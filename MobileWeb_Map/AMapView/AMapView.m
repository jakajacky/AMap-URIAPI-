//
//  AMapView.m
//  MobileWeb_Map
//
//  Created by xqzh on 16/11/22.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import "AMapView.h"

@interface AMapView () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSString  *urlStr;
@end

@implementation AMapView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _webView = [[UIWebView alloc] initWithFrame:frame];
    [self addSubview:_webView];
    _webView.delegate = self;
    
  }
  return self;
}

- (void)setStartCoordinate:(CLLocationCoordinate2D)start
                StartPlace:(NSString *)startName
             EndCoordinate:(CLLocationCoordinate2D)end
                  endPlace:(NSString *)endName{
  
  NSString *mainURI = @"http://m.amap.com/?from=%lf,%lf(%@)&to=%lf,%lf(%@)";
  NSString *uri = [NSString stringWithFormat:
                   mainURI,
                   start.latitude,
                   start.longitude,
                   startName,
                   end.latitude,
                   end.longitude,
                   endName
                   ];
  
  _urlStr = [uri stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
  NSURL *url = [NSURL URLWithString: _urlStr];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [_webView loadRequest:request];
}

- (void)updateMapView {
  NSURL *url = [NSURL URLWithString: _urlStr];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [_webView loadRequest:request];
}

#pragma mark -
#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
  
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  NSLog(@"---%@---", webView.request.URL);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  
  BOOL isHaveMapAPP = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]];
  
  NSLog(@"---%@---", webView.request.URL);
  if ([[request.URL absoluteString] isEqualToString:@"http://wap.amap.com/?from=m&type=m"]) {
    
    if (!isHaveMapAPP) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"设备未安装”高德地图HD“，请先前往APP Store下载应用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往下载", nil];
      [alert show];
      
    }
    return NO;
  }
  return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 1) {
    NSString *urlStr = @"itms-apps://itunes.apple.com/us/app/gao-de-de-tuhd/id562136065?mt=8";
    NSURL *url = [NSURL URLWithString:urlStr];
    [[UIApplication sharedApplication] openURL:url];
  }
}


@end
