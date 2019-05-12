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
        _currLevel = 1;
        _entities = [[NSMutableArray alloc] init];
        _entitiesClasses = [[NSMutableArray alloc] init];
        _numEntitiesToSpawn = 10;
        _chance = 1000;
        _newInit = true;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:.05 repeats:YES block:^(NSTimer * _Nonnull timer) {
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
    
    _newInit = true;
    
    NSLog(@"%lu", (unsigned long)[_entities count]);
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
    
    CGRect marioCurrent = _mario.frame;
    marioCurrent.origin.x = 310;
    marioCurrent.origin.y = 249;
    _mario.frame = marioCurrent;
    
    [_ms setX: 310];
    [_ms setY: 249];
    
    for(int i = 0; i < [_entities count]; i++){
        ((UIImageView*) _entities[i]).image = nil;
        [((UIImageView*) _entities[i]) removeFromSuperview];
        [_entities removeObject: _entities[i]];
        [_entitiesClasses removeObject: _entitiesClasses[i]];
    }
    
    [UIView animateWithDuration:0.4f animations:^{
        
        [self->_buttonTop setAlpha: 0.0f];
        [self->_logo setAlpha: 1.0f];
        [self->_titleLabel setAlpha: 1.0f];
        [self->_buttonPlay setAlpha: 1.0f];
    }];
}

-(void) tick: (id) sender{
    if(_isPlaying){
        
        //mario's movement
        if([_ms isWalkng] || [_ms isJumpng] || ![_ms isOnFloor]){
            
            CGRect marioCurrent = _mario.frame;
            marioCurrent.origin = [_ms getCurrentPos];
            _mario.frame = marioCurrent;
        }
        
        //goombas
        
        if(_newInit){
            Goomba* newGoomba = [[Goomba alloc] init];
            CGRect newEnt = CGRectMake(65, 265, 43, 46);
            UIImageView *newIV = [[UIImageView alloc] initWithFrame:newEnt];
            newIV.image = [newGoomba getCurrentImg];
            [self.superview addSubview:newIV];
            [_entities addObject:newIV];
            [_entitiesClasses addObject:newGoomba];
            _newInit = false;
        }
        
        for(int i = 0; i < [_entities count]; i++){
            Goomba* currentGoomba = _entitiesClasses[i];
            UIImageView* currentEnt = _entities[i];
            CGRect currentEntPos = currentEnt.frame;
            currentEntPos.origin = [currentGoomba getCurrentPos];
            currentEnt.frame = currentEntPos;
            
        }
        //random chance, spawn one, check if deleted yet, 
        
        
        
        
        
    }
}

@end
