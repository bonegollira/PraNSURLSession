//
//  URLConnectionViewController.m
//  PraNSURLSession
//
//  Created by daisuke on 2014/02/13.
//  Copyright (c) 2014年 daisuke. All rights reserved.
//

#import "URLConnectionViewController.h"



@interface URLConnectionViewController ()

@property (weak, nonatomic) IBOutlet UILabel *_label;

@end



@implementation URLConnectionViewController



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
    
    NSString *URLString = [NSString stringWithFormat:@"http://rss.dailynews.yahoo.co.jp/fc/computer/rss.xml?%d", arc4random()%100];
    
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError) {
                                   NSLog(@"%@", connectionError);
                                   return;
                               }
                               
                               self._label.text = [[NSString alloc] initWithData:data
                                                                        encoding:NSUTF8StringEncoding];
                           }];
}


- (void)back:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

@end
