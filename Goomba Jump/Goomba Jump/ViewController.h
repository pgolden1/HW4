//
//  ViewController.h
//  Goomba Jump
//
//  Created by Peter Golden on 3/6/19.
//  Copyright © 2019 Peter Golden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *sky;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIImageView *floor;
@property (weak, nonatomic) IBOutlet UIImageView *pipeLeft;
@property (weak, nonatomic) IBOutlet UIImageView *pipeRight;

@property (weak, nonatomic) IBOutlet UIButton *buttonLeft;
@property (weak, nonatomic) IBOutlet UIButton *buttonCenter;
@property (weak, nonatomic) IBOutlet UIButton *buttonRight;
@property (weak, nonatomic) IBOutlet UIButton *buttonTop;
@property (weak, nonatomic) IBOutlet UIImageView *mario;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;




@end

