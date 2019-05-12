//
//  MovementState.m
//  Goomba Jump
//
//  Created by Peter Golden on 3/7/19.
//  Copyright © 2019 Peter Golden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovementState.h"

@implementation MovementState

+ (void) initialize{}

- (id) init{
    
    self = [super init];
    
    if(self){
        _walkDirection = false;
        _isWalking = false;
        _walkMagnitude = 0;
        _vertMagnitude = 0;
        _isJumping = false;
        _counter = 2;
        
        _currentX = 310;
        _currentY = 249;
        
        
        _marioWalkR1 = [UIImage imageNamed: @"walkingmario1"];
        _marioWalkR2 = [UIImage imageNamed: @"walkingmario2"];
        _marioWalkL1 = [UIImage imageNamed: @"walkingmarioleft1"];
        _marioWalkL2 = [UIImage imageNamed: @"walkingmarioleft2"];
        _marioJumpR = [UIImage imageNamed: @"jumpingmario"];
        _marioJumpL = [UIImage imageNamed: @"jumpingmarioleft"];
        _marioStandR = [UIImage imageNamed: @"mario"];
        _marioStandL = [UIImage imageNamed: @"marioleft"];
        
        _walkingImages = [NSArray arrayWithObjects: _marioWalkL1, _marioWalkL2, _marioWalkR1, _marioWalkR2, nil];
        
    }
    
    return self;
}


-(void) pressWalkLeft{
    _isWalking = true;
    _walkDirection = false;
    if(_walkMagnitude > 0) _walkMagnitude = 0;
    if(_walkMagnitude < -5) _walkMagnitude--;
}

-(void) releaseWalkLeft{
    _isWalking = false;
    _walkDirection = false;
    _walkMagnitude = 0;
}

-(void) pressWalkRight{
    _isWalking = true;
    _walkDirection = true;
    if(_walkMagnitude < 0) _walkMagnitude = 0;
    
}

-(void) releaseWalkRight{
    _isWalking = false;
    _walkDirection = true;
    _walkMagnitude = 0;
}

-(void) pressjump{
    if(_vertMagnitude == 0){
        _vertMagnitude = 30;
        _isJumping = true;
    }
}

-(bool) isWalkng{
    return _isWalking;
}
-(bool) isJumpng{
    return _isJumping;
}

-(void) setX: (float) newX{
    _currentX = newX;
}

-(void) setY: (float) newY{
    _currentX = newY;
}

-(bool) isOnFloor{
    if(_currentX > 64 && _currentX < 561) return (_currentY > 245);
    else return (_currentY > 185);
}

-(UIImage*) getCurrentMS{
    UIImage* retImg;
    if(_isJumping){
        if(_walkDirection) retImg = _marioJumpR;
        else retImg = _marioJumpL;
    } else{
        if(_isWalking){
            if(_walkDirection){
                retImg = (UIImage*) _walkingImages[_walkState + 2];
                _walkState = (_walkState + 1) % 2;
            }else{
                retImg = (UIImage*) _walkingImages[_walkState];
                _walkState = (_walkState + 1) % 2;
            }
        } else{
            if(_walkDirection){
                retImg = _marioStandR;
            }else{
                retImg = _marioStandL;
            }
        }
    }
    return retImg;
}

-(CGPoint) getCurrentPos{
    if(_isWalking){
        if(_walkDirection){
            if(_currentY < 189){ //if on top of pipes
            
                _currentX += _walkMagnitude;
                if(_walkMagnitude < 15) _walkMagnitude += 2;
                
                if(_currentX > 623) _currentX = 623;
                if(_currentX < 0) _currentX = 0;
            
            }
            else{ //if between pipes
                _currentX += _walkMagnitude;
                if(_walkMagnitude < 15) _walkMagnitude += 2;
                
                if(_currentX > 560) _currentX = 560;
                if(_currentX < 55) _currentX = 55;
            }
        }
         else{
             if(_currentY < 189){ //if on top of pipes
                 
                 _currentX -= _walkMagnitude;
                 if(_walkMagnitude < 15) _walkMagnitude += 2;
                 
                 if(_currentX > 623) _currentX = 623;
                 if(_currentX < 0) _currentX = 0;
                 
             }
             else{ //if between pipes
                 _currentX -= _walkMagnitude;
                 if(_walkMagnitude < 15) _walkMagnitude += 2;
                 
                 if(_currentX > 560) _currentX = 560;
                 if(_currentX < 65) _currentX = 65;
             }
         }
    }
    
    //gravity
    {
        
        if(_currentX > 64 && _currentX < 561){ //if next to pipes
            if(_currentY < 249 + _vertMagnitude){
                _currentY -= (_vertMagnitude - 15);
                _vertMagnitude -= pow(_counter, 1/2);
            }
            if(_currentY >= 249) _currentY = 248;
        }
        else{ //if on top of pipes
            if(_currentY < 189 + _vertMagnitude){
                _currentY -= (_vertMagnitude - 15);
                _vertMagnitude -= pow(_counter, 1/2);
            }
            
            if(_currentY >= 189) _currentY = 188;
        }
        
        
        if(_vertMagnitude < 0){
            _vertMagnitude = 0;
            _counter = 2;
            _isJumping = false;
            
        }
        else{
            _counter = _counter * _counter * _counter;
        }
        
        if(_currentY < 5) _currentY = 5;
        
        //NSLog(@"%f %f %f", _currentX, _currentY, _vertMagnitude);
        
    }

    
    return CGPointMake(_currentX, _currentY);
}


@end
