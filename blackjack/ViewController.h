//
//  ViewController.h
//  blackjack
//
//  Created by Paul Punke on 27.05.15.
//  Copyright (c) 2015 paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAlertView.h"

@interface ViewController : UIViewController


@property NSMutableArray *allImageViews;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *hitbutton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *standbutton;
@property (weak, nonatomic) IBOutlet UIButton *newgamebutton;
@property (weak, nonatomic) IBOutlet UILabel *score;

- (IBAction)hit:(id)sender;
- (IBAction)stand:(id)sender;
- (IBAction)newgame:(id)sender;


@end

