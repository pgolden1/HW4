//
//  GameView.m
//  Goomba Jump
//
//  Created by Peter Golden on 3/7/19.
//  Copyright © 2019 Peter Golden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameView.h"

@implementation GameView


- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super initWithCoder:aDecoder])) {
        
        _ms = [[MovementState alloc] init];
        
        _isPlaying = false;
        _walkDirection = false;
        _isWalking = false;
        _walkMagnitude = 0;
        _isJumping = false;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self performSelectorOnMainThread:@selector(tick:) withObject:self.timer waitUntilDone:NO];
        }];
    }
    return self;
}

-(IBAction) pressWalkLeft: (UIButton*) sender{
    [_ms pressWalkLeft];
}

-(IBAction) releaseWalkLeft: (UIButton*) sender{
    [_ms releaseWalkLeft];
}

-(IBAction) pressWalkRight: (UIButton*) sender{
    [_ms pressWalkRight];

}

-(IBAction) releaseWalkRight: (UIButton*) sender{
    [_ms releaseWalkRight];
}

-(IBAction) pressjump: (UIButton*) sender{
    [_ms pressjump];
}

-(IBAction) pressPlay: (UIButton*) sender{
    
    _isPlaying = true;
    [_buttonTop setEnabled: YES];
    [_buttonPlay setEnabled: NO];
    
    [UIView animateWithDuration:0.4f animations:^{
        
        [self->_buttonTop setAlpha: 1.0f];
        [self->_logo setAlpha: 0.0f];
        [self->_titleLabel setAlpha: 0.0f];
        [self->_buttonPlay setAlpha: 0.0f];
    }];
     
    
}

-(IBAction) pressMenu: (UIButton*) sender{
    _isPlaying = false;
    [_buttonTop setEnabled: NO];
    [_buttonPlay setEnabled: YES];
    
    [UIView animateWithDuration:0.4f animations:^{
        
        [self->_buttonTop setAlpha: 0.0f];
        [self->_logo setAlpha: 1.0f];
        [self->_titleLabel setAlpha: 1.0f];
        [self->_buttonPlay setAlpha: 1.0f];
    }];
}

-(void) tick: (id) sender{
    if(_isPlaying){
        if([_ms isWalkng]){
            
            //height = 188
            
            
            
            NSLog(@"%d", _walkMagnitude);
            CGRect marioCurrent = _mario.frame;
            NSLog(@"%f %f", marioCurrent.origin.x, marioCurrent.origin.y);
            marioCurrent.origin = [_ms getCurrentPos];
            
            /*if(_walkDirection){
                if(marioCurrent.origin.y > 188)
                if(marioCurrent.origin.x < 620){
                    marioCurrent.origin.x += _walkMagnitude;
                    if(_walkMagnitude < 15) _walkMagnitude += 2;
                }
            }
            else{
                if(marioCurrent.origin.x > 12){
                    marioCurrent.origin.x += _walkMagnitude;
                    if(_walkMagnitude > -15) _walkMagnitude -= 2;
                }
            }*/

                
            _mario.frame = marioCurrent;
        }
    }
}

@end
