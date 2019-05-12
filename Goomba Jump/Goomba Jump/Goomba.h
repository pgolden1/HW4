//
//  Goomba.h
//  Goomba Jump
//
//  Created by Peter Golden on 5/11/19.
//  Copyright © 2019 Peter Golden. All rights reserved.
//

#ifndef Goomba_h
#define Goomba_h

#import <UIKit/UIKit.h>

@interface Goomba : NSObject


@property (nonatomic) float currentX;
@property (nonatomic) float currentY;
@property (nonatomic, strong) UIImage* currentImage;
@property (nonatomic) bool walkDirection; //true for right, false for left

-(CGPoint) getCurrentPos;
-(void) deleteCurrent;
-(UIImage*) getCurrentImg;



@end

#endif /* Goomba_h */
