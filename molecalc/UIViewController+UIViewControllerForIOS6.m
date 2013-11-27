//
//  UIViewController+UIViewControllerForIOS6.m
//  MoleCalc
//
//  Created by 田中 武則2 on 2013/10/29.
//  Copyright (c) 2013年 takenori tanaka. All rights reserved.
//

#import "UIViewController+UIViewControllerForIOS6.h"

@implementation UIViewController (UIViewControllerForIOS6)
// iOS 6 以降で有効. iOS 5 以前では実行されない
- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        // iPhone がサポートする向き
        return UIInterfaceOrientationMaskPortrait;
    }
    
    // iPad がサポートする向き
    return UIInterfaceOrientationMaskAll;
}
- (BOOL)shouldAutorotate
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        // iPhone
        return NO;
    }
    
    return YES;
}

@end
