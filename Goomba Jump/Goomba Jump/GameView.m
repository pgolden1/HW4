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
        _marioCoordsX = [[NSMutableArray alloc] init];
        _marioCoordsY = [[NSMutableArray alloc] init];
        _numEntitiesToSpawn = 1;
        _chance = 10;
        _newInit = true;
        _initCounter = 100;
        
        
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
            [_marioCoordsX addObject:[NSNumber numberWithInt:marioPos.origin.y + j]];
            [_marioCoordsX addObject:[NSNumber numberWithInt:marioPos.origin.y + j]];
            [_marioCoordsY addObject:[NSNumber numberWithInt:marioPos.origin.x]];
            [_marioCoordsY addObject:[NSNumber numberWithInt:marioPos.origin.x  + marioPos.size.width]];
        }
        _newInit = false;
    }
    if(_isPlaying){
        
        //mario's movement
        if([_ms isWalkng] || [_ms isJumpng] || ![_ms isOnFloor]){
            
            CGRect marioCurrent = _mario.frame;
            CGFloat originx = marioCurrent.origin.x;
            CGFloat originy = marioCurrent.origin.y;
            
            marioCurrent.origin = [_ms getCurrentPos];
            _mario.frame = marioCurrent;
            
            CGFloat diffx = marioCurrent.origin.x - originx;
            CGFloat diffy = marioCurrent.origin.y - originy;
            
            for(int i = 0; i < [_marioCoordsX count]; i++){
                NSNumber* temp1 = (NSNumber*) _marioCoordsX[i];
                NSNumber* newx = [NSNumber numberWithInt: [temp1 intValue] + diffx];
                [_marioCoordsX replaceObjectAtIndex: i withObject:[NSNumber numberWithInt:[newx intValue]]];
                
                NSNumber* temp2 = (NSNumber*) _marioCoordsY[i];
                NSNumber* newy = [NSNumber numberWithInt: [temp2 intValue] + diffy];
                [_marioCoordsX replaceObjectAtIndex: i withObject:[NSNumber numberWithInt:[newy intValue]]];
            }
        }
        
        //goombas
        
        if(_initCounter == 0){
            
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
        } else {_initCounter--;}
        
        
        
        
        for(int i = 0; i < [_entities count]; i++){
            //move goomba
            Goomba* currentGoomba = _entitiesClasses[i];
            UIImageView* currentEnt = _entities[i];
            CGRect currentEntPos = currentEnt.frame;
            currentEntPos.origin = [currentGoomba getCurrentPos];
            currentEnt.frame = currentEntPos;
            
            //check collision with mario
            //TODO: DEBUG THIS
            for(int i = 0; i < [_marioCoordsX count]; i++){
                NSNumber* marioX = (NSNumber*) _marioCoordsX[i];
                NSNumber* marioY = (NSNumber*) _marioCoordsY[i];
                
                
                for(int x = 0; x < currentEntPos.size.width; x++){
                    if((int) (currentEntPos.origin.x + x) == [marioX intValue]){
                        for(int y = 0; y < currentEntPos.size.height; y++){
                            if((int) (currentEntPos.origin.y + y) == [marioY intValue]){
                                //NSLog(@"intersect");
                                //NSLog(@"%d %d %f %f", [marioX intValue], [marioY intValue], currentEntPos.origin.x + x, currentEntPos.origin.y + y);
                            }
                        }
                    }
                }
            }
            
        }
        
        
        
    }
    
}

@end
