//
//  URLSessionViewController.m
//  PraNSURLSession
//
//  Created by daisuke on 2014/02/13.
//  Copyright (c) 2014年 daisuke. All rights reserved.
//



#import "URLSessionViewController.h"
#import "DKNetworking.h"



static NSString *const kURLString = @"http://rss.dailynews.yahoo.co.jp/fc/computer/rss.xml";



@interface URLSessionViewController ()

@property (weak, nonatomic) IBOutlet UILabel *_label;

@end



@implementation URLSessionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = nil;
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(back:)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidAppear:(BOOL)animated
{
    self._label.text = @"";
    
    /**
     
     NSURLSession
     
     通信をタスク管理できる
     
     NSURLSessionはURLのみで実行できるためシングルトン化に向いている
     ので、リクエスト毎に1インスタンスではなくて1アプリで1インスタンスとすると使いやすい
     
     デフォルトセッション: URLからダウンロードするためのセッション、通常
     エフェメラルセッション: デスクに保存されずメモリにキャッシュするためのセッション
     バックグラウンドセッション: バックグラウンド通信をする際にはこのセッション
     
     データタスク: データの送受信、バックグラウンドセッションではサポートされない
     ダウンロードタスク: アプリが実行されていないときのダウンロードをサポート
     アップロードタスク: アプリが実行されていないときのアップロードをサポート
     
     */
    
    // デフォルトセッション
//    [self useDefaultSession];
    // エフェメラルセッション
//    [self useEphemeralSession];
    // バックグラウンドセッション
//    [self useBackgroundSession];
    // シングルトンマネージャー
    [self useDKNetworking];
}



/*!
 
 @NSURLSession
 
 defaultSessionConfiguration
 
 */
- (void)useDefaultSession
{
    // デフォルトセッション
    // URLからダウンロードするためのセッション
    NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // timeout 20sec
    defaultConfiguration.timeoutIntervalForRequest = 20.f;
    // allow 3g access.
    defaultConfiguration.allowsCellularAccess = YES;
    
    // delegateをセットしない場合はcompletionHandlerのtaskを作る
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfiguration
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    
    // taskの生成にはURLとBlockを指定
    void (^completionHandler)() = ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            return ;
        }
        
        self._label.text = [[NSString alloc] initWithData:data
                                                 encoding:NSUTF8StringEncoding];
    };
    NSURLSessionTask *task = [defaultSession dataTaskWithURL:[NSURL URLWithString:kURLString]
                                           completionHandler:completionHandler];
    // task実行
    [task resume];
}



/*!
 
 @NSURLSession
 
 backgroundSessionConfiguration:
 
 */
- (void)useBackgroundSession
{
    // バックグラウンドセッション
    NSURLSessionConfiguration *backgroundConfiguration = nil;
    backgroundConfiguration = [NSURLSessionConfiguration backgroundSessionConfiguration:@"BackgroundSession"];
}



/*!
 
 @NSURLSession
 
 ephemeralSessionConfiguration
 
 */
- (void)useEphemeralSession
{
}



/*!
 
 @DKNetworking
 
 use singleton manager
 
 */
- (void)useDKNetworking
{
    void (^completionHandler)() = ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            return ;
        }
        
        self._label.text = [[NSString alloc] initWithData:data
                                                 encoding:NSUTF8StringEncoding];
    };
    
    [DKNetworking doTaskWithURL:[NSURL URLWithString:kURLString]
                     completion:completionHandler];
}



- (void)back:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

@end
