//
//  AboutViewController.h
//  BullsEyeGame
//
//  Created by Segun Konibire on 03/02/2014.
//  Copyright (c) 2014 Segun Konibire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

-(IBAction)close:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
