//
//  ViewController.m
//  Goomba Jump
//
//  Created by Peter Golden on 3/6/19.
//  Copyright © 2019 Peter Golden. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _sky.image = [UIImage imageNamed: @"sky"];
    
    _floor.image = [UIImage imageNamed: @"floor20"];
    
    _logo.image = [UIImage imageNamed: @"logo"];
    
    _pipeLeft.image = [UIImage imageNamed: @"pipeleft"];
    
    _pipeRight.image = [UIImage imageNamed: @"piperight"];
    
    _mario.image = [UIImage imageNamed: @"mario"];
    
    UIImage* buttonLeftIMG = [UIImage imageNamed: @"walkleft"];
    UIImage* buttonCenterIMG = [UIImage imageNamed: @"jump"];
    UIImage* buttonRightIMG = [UIImage imageNamed: @"walkright"];
    
    [_buttonLeft setBackgroundImage: buttonLeftIMG forState:UIControlStateNormal];
    
    [_buttonCenter setBackgroundImage: buttonCenterIMG forState:UIControlStateNormal];
    
    [_buttonRight setBackgroundImage: buttonRightIMG forState:UIControlStateNormal];

}





@end
