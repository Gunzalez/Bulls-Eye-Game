//
//  OBKViewController.m
//  BullsEyeGame
//
//  Created by Segun Konibire on 28/01/2014.
//  Copyright (c) 2014 Segun Konibire. All rights reserved.
//

#import "OBKViewController.h"

@interface OBKViewController ()

@end

@implementation OBKViewController
{
    int _target;
    int _currentValue;
    int _score;
    int _round;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self newRound];
    [self updateLabels];
    
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.bullsEyeSlider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.bullsEyeSlider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    
    UIImage *trackLeft = [[UIImage imageNamed:@"SliderTrackLeft"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
    [self.bullsEyeSlider setMinimumTrackImage:trackLeft forState:UIControlStateNormal];
    
    UIImage *trackRight = [[UIImage imageNamed:@"SliderTrackRight"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
    [self.bullsEyeSlider setMaximumTrackImage:trackRight forState:UIControlStateNormal];
    
}

-(void)updateLabels
{
    
    if(_round > 5){
        _round = 5;
    }
    
    _lblTarget.text = [[NSString alloc] initWithFormat:@"%d", _target];
    _lblScore.text = [[NSString alloc] initWithFormat:@"%d",_score];
    _lblRound.text = [[NSString alloc] initWithFormat:@"%d",_round];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)btnPressed:(id)sender
{
    int difference = abs(_target - _currentValue);
    NSInteger points = 100 - difference;
    NSString *title;
    if (difference == 0) {
        title = @"Nice one, a perfect score!";
        points = 200;
    } else if (difference < 5){
        title = @"Ouch, so close!";
        points = 150;
    } else if (difference < 10){
        title = @"Pretty Good";
        points = 100;
    } else if (difference < 20) {
        title = @"Meh...";
        points = 50;
    } else {
        title = @"That was terrible!";
        points = 0;
    }
    
    _score += points;
    

    NSString *message = [[NSString alloc] initWithFormat:@"The target was %d, you picked %d.\nYour score is %li!", _target, _currentValue, (long)points];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:message
                          delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil];
    
    alert.tag = 1;
    [alert show];

}


-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1){
    
        [self newRound];
        [self updateLabels];
    
    } else if(alertView.tag == 2){
        
        [self btnRestartPressed:nil];
    }
    
}

- (IBAction)sliderMoved:(id)sender {
    _currentValue = (int)lround(self.bullsEyeSlider.value);
}

-(void)newRound
{
    _target = 1 + arc4random_uniform(100);
    _currentValue = 50;
    self.bullsEyeSlider.value = _currentValue;
    _round++;
    
    if (_round > 5) {
        
        NSString *endMsg = [[NSString alloc] initWithFormat:@"That's 5 rounds up.\nTotal score %d, out of %d.", _score, 5*200];
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Game Over"
                              message:endMsg
                              delegate:self
                              cancelButtonTitle:@"RESTART"
                              otherButtonTitles: nil];
        
        alert.tag = 2;
        [alert show];
    }
}

-(void)btnRestartPressed:(id)sender
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    _score = 0;
    _round = 0;
    
    [self newRound];
    [self updateLabels];
    
    [self.view.layer addAnimation:transition forKey:nil];
    
    
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
