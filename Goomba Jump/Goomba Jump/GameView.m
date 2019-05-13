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
        _currLevel = 0;
        _entities = [[NSMutableArray alloc] init];
        _entitiesClasses = [[NSMutableArray alloc] init];
        _marioCoordsX = [[NSMutableArray alloc] init];
        _marioCoordsY = [[NSMutableArray alloc] init];
        _numEntitiesToSpawn = 1;
        _chance = 10;
        _newInit = true;
        _initCounter = 25;
        
        
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
    
    
    [UIView animateWithDuration:0.4f animations:^{
        
        [self->_buttonTop setAlpha: 1.0f];
        [self->_logo setAlpha: 0.0f];
        [self->_titleLabel setAlpha: 0.0f];
        [self->_buttonPlay setAlpha: 0.0f];
        [self->_levelLabel setAlpha: 1.0f];
    }];
     
    
}

-(IBAction) pressMenu: (UIButton*) sender{
    _isPlaying = false;
    [_buttonTop setEnabled: NO];
    [_buttonPlay setEnabled: YES];
    
    
    for(int i = 0; i < [_entities count]; i++){
    
        ((UIImageView*) _entities[i]).image = nil;
        [((UIImageView*) _entities[i]) removeFromSuperview];
        [_entities removeObject: _entities[i]];
        [_entitiesClasses removeObject: _entitiesClasses[i]];
    }
    
    [self initialize];
    
    [UIView animateWithDuration:0.4f animations:^{
        
        [self->_buttonTop setAlpha: 0.0f];
        [self->_logo setAlpha: 1.0f];
        [self->_titleLabel setAlpha: 1.0f];
        [self->_buttonPlay setAlpha: 1.0f];
        [self->_levelLabel setAlpha: 0.0f];
    }];
}

-(void) initialize{
    _isPlaying = false;
    _walkDirection = false;
    _isWalking = false;
    _walkMagnitude = 0;
    _isJumping = false;
    _currLevel = 1;
    _numEntitiesToSpawn = 1;
    _chance = 10;
    _newInit = true;
    _waitCounter = 20;
    
    self.levelLabel.text = [NSString stringWithFormat:@"Level: 0"];
    
    CGRect marioCurrent = _mario.frame;
    marioCurrent.origin.x = 310;
    marioCurrent.origin.y = 249;
    _mario.frame = marioCurrent;
    
    [_ms setX: 310];
    [_ms setY: 249];
}

-(void) tick: (id) sender{

    if(_newInit){
        CGRect marioPos = _mario.frame;
        for(int i = 0; i < marioPos.size.width; i++){
            [_marioCoordsX addObject:[NSNumber numberWithInt:marioPos.origin.x + i]];
            [_marioCoordsX addObject:[NSNumber numberWithInt:marioPos.origin.x + i]];
            [_marioCoordsY addObject:[NSNumber numberWithInt:marioPos.origin.y]];
            [_marioCoordsY addObject:[NSNumber numberWithInt:marioPos.origin.y  + marioPos.size.height]];
        }
        for(int j = 0; j < marioPos.size.height; j++){
            [_marioCoordsY addObject:[NSNumber numberWithInt:marioPos.origin.y + j]];
            [_marioCoordsY addObject:[NSNumber numberWithInt:marioPos.origin.y + j]];
            [_marioCoordsX addObject:[NSNumber numberWithInt:marioPos.origin.x]];
            [_marioCoordsX addObject:[NSNumber numberWithInt:marioPos.origin.x  + marioPos.size.width-1]];
        }
        
        [_marioCoordsX addObject:[NSNumber numberWithInt:310]];
        [_marioCoordsX addObject:[NSNumber numberWithInt:357]];
        [_marioCoordsY addObject:[NSNumber numberWithInt:304]];
        [_marioCoordsY addObject:[NSNumber numberWithInt:304]];
        
        
        _newInit = false;
        
    }
    
    if(_isPlaying){
        
        self.levelLabel.text = [NSString stringWithFormat:@"Level: %d", self.currLevel];
        
        //mario's movement
        if([_ms isWalkng] || [_ms isJumpng] || ![_ms isOnFloor]){
            
            CGRect marioCurrent = _mario.frame;
            CGFloat originx = marioCurrent.origin.x; //grab old coordinates to update corners after with differential
            CGFloat originy = marioCurrent.origin.y;
            
            marioCurrent.origin = [_ms getCurrentPos]; //update position
            _mario.frame = marioCurrent; //update mario
            
            CGFloat diffx = marioCurrent.origin.x - originx;
            CGFloat diffy = marioCurrent.origin.y - originy;
            
            
            //move right = +x
            //move up = -y
            
            for(int i = 0; i < [_marioCoordsX count]; i++){
                NSNumber* temp1 = (NSNumber*) _marioCoordsX[i];
                NSNumber* newx = [NSNumber numberWithInt: [temp1 intValue] + diffx];
                
                [_marioCoordsX replaceObjectAtIndex: i withObject:[NSNumber numberWithInt:[newx intValue]]];
                
                NSNumber* temp2 = (NSNumber*) _marioCoordsY[i];
                NSNumber* newy = [NSNumber numberWithInt: [temp2 intValue] + diffy];
                [_marioCoordsY replaceObjectAtIndex: i withObject:[NSNumber numberWithInt:[newy intValue]]];
                
            }
            
        }
        
        //goombas
        
        if(_initCounter == 0){
            if(_numEntitiesToSpawn > 0){
                int chanceSucceed = arc4random() % _chance; //every tick possibility of spawning
                if(chanceSucceed == 0 && _numEntitiesToSpawn != 0){
                    Goomba* newGoomba = [[Goomba alloc] init];
                    CGRect newEnt = CGRectMake(55, 265, 43, 46);
                    
                    
                    int randInt = arc4random() % 2;
            
                    if(randInt == 0){
                        newEnt.origin.x += 520;
                        [newGoomba setCurrentX:575];
                        [newGoomba setWalkDirection: false];
                    }
            
                   
                    UIImageView *newIV = [[UIImageView alloc] initWithFrame:newEnt];
                    newIV.image = [newGoomba getCurrentImg];
                    [self.superview addSubview:newIV];
                    [_entities addObject:newIV];
            
                    [_entitiesClasses addObject:newGoomba];
                    _numEntitiesToSpawn--;
                }
            }
        } else {_initCounter--;}
        
        
        
        
        for(int i = 0; i < [_entities count]; i++){
            //move goomba
            Goomba* currentGoomba = _entitiesClasses[i];
            UIImageView* currentEnt = _entities[i];
            CGRect currentEntPos = currentEnt.frame;
            currentEntPos.origin = [currentGoomba getCurrentPos];
            currentEnt.frame = currentEntPos;
            
            int GoombaOriginX = currentEntPos.origin.x  - 45;
            
            NSNumber* GoombaKZ = [NSNumber numberWithInt:currentEntPos.origin.y + 20];
            bool killGoomba = false; //false for no collision at all, true for kill goomba
            //if killing mario happens, will happen in for loop and break from it
            
            //check collision with mario
            for(int i = 0; i < [_marioCoordsX count]; i++){
                NSNumber* marioX = (NSNumber*) _marioCoordsX[i];
                NSNumber* marioY = (NSNumber*) _marioCoordsY[i];
                
                if(GoombaOriginX <= [marioX intValue] && [marioX intValue] <= GoombaOriginX + currentEntPos.size.width){
                    
                    if(currentEntPos.origin.y <= [marioY intValue] && [marioY intValue] <= [GoombaKZ intValue]){
                        killGoomba = true;
                        NSLog(@"Goomba dies");
                    }
                    
                    if([GoombaKZ intValue] < [marioY intValue] && [marioY intValue] <= currentEntPos.origin.y + currentEntPos.size.height){
                        NSLog(@"Mario dies, game over");
                        
                    }
                }
                
            }
            
            if(killGoomba){
                ((UIImageView*) _entities[i]).image = nil;
                [((UIImageView*) _entities[i]) removeFromSuperview];
                [_entities removeObject: _entities[i]];
                [_entitiesClasses removeObject: _entitiesClasses[i]];
                
                [_ms pressjump];
            }
            
        }
        
        if([_entities count] == 0 && _initCounter == 0){
            if(_waitCounter == 0){
                _initCounter = 55;
                _waitCounter = 20;
                _currLevel++;
                _numEntitiesToSpawn = 5 * _currLevel;
            } else _waitCounter--;
        }
        
        
        
    }
    
}

@end
