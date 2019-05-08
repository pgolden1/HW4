//
//  GameScene.m
//  test2
//
//  Created by Peter Golden on 5/7/19.
//  Copyright © 2019 Peter Golden. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    
    NSLog(@"scene didMoveToView");
    
    //spawn mario
    SKTexture *marioTexture = [SKTexture textureWithImageNamed:@"mario.png"];
    _mario = [[SKSpriteNode alloc] initWithTexture: marioTexture];
    _mario.anchorPoint = CGPointMake(0.0f, 0.0f);
    _mario.size = CGSizeMake(100.0f, 100.0f );
    [self addChild: _mario];
    
}




@end
