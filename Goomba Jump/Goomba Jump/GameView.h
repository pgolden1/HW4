//
//  GameView.h
//  Goomba Jump
//
//  Created by Peter Golden on 3/7/19.
//  Copyright © 2019 Peter Golden. All rights reserved.
//

#ifndef GameView_h
#define GameView_h

#import <UIKit/UIKit.h>
#import "MovementState.h"

@interface GameView: UIView

@property (weak, nonatomic) IBOutlet UIImageView *sky;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIImageView *floor;
@property (weak, nonatomic) IBOutlet UIImageView *pipeLeft;
@property (weak, nonatomic) IBOutlet UIImageView *pipeRight;
@property (weak, nonatomic) IBOutlet UIImageView *mario;

@property (weak, nonatomic) IBOutlet UIButton *buttonLeft;
@property (weak, nonatomic) IBOutlet UIButton *buttonCenter;
@property (weak, nonatomic) IBOutlet UIButton *buttonRight;
@property (weak, nonatomic) IBOutlet UIButton *buttonTop;
@property (weak, nonatomic) IBOutlet UIButton *buttonPlay;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

//false for left, true for right
@property (nonatomic) BOOL walkDirection;
@property (nonatomic) BOOL isWalking;
@property (nonatomic) BOOL isJumping;
@property (nonatomic) int walkMagnitude;

@property (nonatomic, strong) NSTimer *timer;
@property bool isPlaying;
@property (nonatomic, strong) MovementState* ms;


-(IBAction) pressWalkLeft: (UIButton*) sender;
-(IBAction) releaseWalkLeft: (UIButton*) sender;
-(IBAction) pressWalkRight: (UIButton*) sender;
-(IBAction) releaseWalkRight: (UIButton*) sender;
-(IBAction) pressjump: (UIButton*) sender;
-(IBAction) pressPlay: (UIButton*) sender;
-(IBAction) pressMenu: (UIButton*) sender;

@end
#endif /* GameView_h */
