//
//  MovementState.h
//  Goomba Jump
//
//  Created by Peter Golden on 3/7/19.
//  Copyright © 2019 Peter Golden. All rights reserved.
//

#ifndef MovementState_h
#define MovementState_h

#import <UIKit/UIKit.h>

@interface MovementState: NSObject

//false for left, true for right
@property (nonatomic) BOOL walkDirection;
@property (nonatomic) BOOL isWalking;
@property (nonatomic) BOOL isJumping;
@property (nonatomic) int walkMagnitude;
@property (nonatomic) double vertMagnitude;
@property (nonatomic) double counter;
@property (nonatomic) int walkState;
@property (nonatomic) float currentX;
@property (nonatomic) float currentY;
@property (nonatomic) float maxX;
@property (nonatomic) float maxY;

@property (weak, nonatomic) NSArray* walkingImages;

@property (weak, nonatomic) UIImage* marioWalkR1;
@property (weak, nonatomic) UIImage* marioWalkR2;
@property (weak, nonatomic) UIImage* marioWalkL1;
@property (weak, nonatomic) UIImage* marioWalkL2;
@property (weak, nonatomic) UIImage* marioJumpR;
@property (weak, nonatomic) UIImage* marioJumpL;
@property (weak, nonatomic) UIImage* marioStandR;
@property (weak, nonatomic) UIImage* marioStandL;



+ (void) initialize;
-(id) init;
-(void) pressWalkLeft;
-(void) releaseWalkLeft;
-(void) pressWalkRight;
-(void) releaseWalkRight;
-(void) pressjump;
-(bool) isWalkng;
-(bool) isJumpng;
-(void) setX: (float) newX;
-(void) setY: (float) newY;
-(bool) isOnFloor;
-(UIImage*) getCurrentMS;
-(CGPoint) getCurrentPos;

@end

#endif /* MovementState_h */
