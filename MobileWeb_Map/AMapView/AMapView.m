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
  
  if ([[[request.URL absoluteString] substringToIndex:23] isEqualToString:@"http://itunes.apple.com"]) {
    
    
    
    
    if (isHaveMapAPP) {
      NSURL *url = [NSURL URLWithString:_urlStr];
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
