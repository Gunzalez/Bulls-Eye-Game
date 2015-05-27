//
//  OBKViewController.h
//  BullsEyeGame
//
//  Created by Segun Konibire on 28/01/2014.
//  Copyright (c) 2014 Segun Konibire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OBKViewController : UIViewController<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UISlider *bullsEyeSlider;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet UILabel *lblTarget;
@property (weak, nonatomic) IBOutlet UILabel *lblRound;

- (IBAction)sliderMoved:(id)sender;
- (IBAction)btnPressed:(id)sender;
- (IBAction)btnRestartPressed:(id)sender;

@end
