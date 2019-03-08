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
        _isJumping = false;
        _isWalking = false;
        _walkDirection = true;
        
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


-(void) startWalking{
    _isWalking = true;
}

-(void) stopWalking{
    _isWalking = false;
}

-(void) jump{
    _isJumping = true;
}

-(void) setLeft{
    _walkDirection = false;
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


@end
