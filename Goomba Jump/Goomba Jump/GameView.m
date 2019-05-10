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
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self performSelectorOnMainThread:@selector(tick:) withObject:self.timer waitUntilDone:NO];
        }];
    }
    return self;
}

-(IBAction) pressWalkLeft: (UIButton*) sender{
    [_ms startWalking];
    [_ms setLeft];
}

-(IBAction) releaseWalkLeft: (UIButton*) sender{
    [_ms stopWalking];
    [_ms setLeft];
}

-(IBAction) pressWalkRight: (UIButton*) sender{
    [_ms startWalking];
}

-(IBAction) releaseWalkRight: (UIButton*) sender{
    [_ms stopWalking];
}

-(IBAction) pressjump: (UIButton*) sender{
    [_ms jump];
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
    //if(_isPlaying) _mario.image = [_ms getCurrentMS];
}

@end
