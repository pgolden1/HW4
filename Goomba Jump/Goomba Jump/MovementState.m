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
        _isJumping = false;
        
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
    _currentY--;
}

-(bool) isWalkng{
    return _isWalking;
}

-(void) setRight{
    _walkDirection = true;
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
    if(_walkDirection){
        if(_currentY < 189){
            if(_currentX < 620){
                _currentX += _walkMagnitude;
                if(_walkMagnitude < 15) _walkMagnitude += 2;
            }
        }
        else{
            if(_currentX < 540){
                _currentX += _walkMagnitude;
                if(_walkMagnitude < 15) _walkMagnitude += 2;
            }
        }
    }
     else{
         if(_currentY > 188){
             if(_currentX > 12){
                 _currentX += _walkMagnitude;
                 if(_walkMagnitude > -15) _walkMagnitude -= 2;
             }
         }
         else{
             if(_currentX > 92){
                 _currentX += _walkMagnitude;
                 if(_walkMagnitude > -15) _walkMagnitude -= 2;
             }
         }
     }
    
    
    return CGPointMake(_currentX, _currentY);
}


@end
