//
//  Goomba.m
//  Goomba Jump
//
//  Created by Peter Golden on 5/11/19.
//  Copyright © 2019 Peter Golden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Goomba.h"

@implementation Goomba

-(id) init{
    
    if(self = [super init]){
        _currentX = 65;
        _currentY = 249;
        _walkDirection = true;
        _currentImage = (UIImage*) [UIImage imageNamed: @"goomba"];
        
    }
    
    return self;
}

-(UIImage*) getCurrentImg{
    return _currentImage;
}

-(CGPoint) getCurrentPos{
    
    if(_walkDirection){
        _currentX += 3;
        if(_currentX > 560){
            _currentX = 560;
            _walkDirection = false;
        }
    }
    else{
        _currentX-= 3;
        if(_currentX < 65){
            _currentX = 65;
            _walkDirection = true;
        }
    }
    
    return CGPointMake(_currentX, _currentY);
}

@end
