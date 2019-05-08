//
//  GameScene.h
//  test2
//
//  Created by Peter Golden on 5/7/19.
//  Copyright © 2019 Peter Golden. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameView.h"

@class GameView;

NS_ASSUME_NONNULL_BEGIN

@interface GameScene : SKScene

@property GameView* ControllingView;

@property (strong, nonatomic) SKSpriteNode *mario;

- (void)didMoveToView:(SKView *)view;


@end



NS_ASSUME_NONNULL_END
