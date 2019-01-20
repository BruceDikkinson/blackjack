//
//  ViewController.m
//  blackjack
//
//  Created by Paul Punke on 27.05.15.
//  Copyright (c) 2015 paul. All rights reserved.
//

#import "ViewController.h"
#import "Game.h"
#import "Hand.h"
#import "Card.h"

@interface ViewController ()


@end

@implementation ViewController

@synthesize score=_score;
@synthesize allImageViews = _allImageViews;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self  setNeedsStatusBarAppearanceUpdate];
    
    _allImageViews = [[NSMutableArray alloc] initWithCapacity:5];

    // Do any additional setup after loading the view, typically from a nib.
    
    [[Game getgame]  addObserver:self forKeyPath:@"dealerHand"
                                             options:NSKeyValueObservingOptionNew context:NULL];
    [[Game getgame]  addObserver:self forKeyPath:@"playerHand"
                                             options:NSKeyValueObservingOptionNew context:NULL];
    
    [[Game getgame] setup];
    [self showDealerHand:[Game getgame].dealerHand];
    [self showPlayerHand:[Game getgame].playerHand];
    _score.text = [NSString stringWithFormat:@"score: %d:%d",[[Game getgame] pwins],[[Game getgame] dwins]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) showHand:(Hand *)hand atYPos:(NSInteger) yPos;
{
    
    for (int i=0; i< [hand countCards] ; i++) {
        Card *card = [hand getCardAtIndex:i];
        
        UIImage  *cardImage = [ UIImage imageNamed:[card filename]];
        
        UIImageView *imageView=[[UIImageView alloc] initWithImage:cardImage];
        CGRect arect = CGRectMake( (i*40)+20, yPos, 71, 96);
        imageView.frame = arect;
        
        [self.view addSubview:imageView];
        [_allImageViews addObject:imageView];
    }
    
}

-(void) showDealerHand:(Hand *)hand;
{
    [self showHand:hand atYPos:165];
}



-(void) showPlayerHand:(Hand *)hand;
{
    [self showHand:hand atYPos:305];
}



-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}




- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"dealerHand"])
    {
        [self showDealerHand: (Hand *)[object dealerHand]];
    } else
        if ([keyPath isEqualToString:@"playerHand"])
        {
            [self showPlayerHand: (Hand *)[object playerHand]];
        }
    
}


- (IBAction)hit:(id)sender {
    [[Game getgame] playerHandDraws];
    if ([[Game getgame].playerHand getPipValue]>21)
    {
        [[[TAlertView alloc] initWithTitle:@"you bust!"
                                   message:nil
                                   buttons:nil
                               andCallBack:^(TAlertView *alertView) {
                                   //Your action
                                   self.reset;
                               }]
         show];

        _score.text = [NSString stringWithFormat:@"score: %d:%d",[[Game getgame] pwins],[[Game getgame] dwins]];
        
    }
    
}


- (IBAction)stand:(id)sender {
    [_hitbutton setEnabled:NO];
    [_standbutton setEnabled:NO];
    // [_newgamebutton setEnabled:NO];
    [[Game getgame] dealersturn];
    self.endgame;
}

- (IBAction)newgame:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"sure?"
                                                    message:@"are you a sore loser?"
                                                   delegate:self
                                          cancelButtonTitle:@"no"
                                          otherButtonTitles:nil];
    [alert addButtonWithTitle:@"yes"];
    [alert show];
    
    [[Game getgame] reset];
    _score.text = [NSString stringWithFormat:@"score: %d:%d",[[Game getgame] pwins],[[Game getgame] dwins]];
    self.reset;
    }

- (void) reset
{
    for (UIView *view in _allImageViews)
    {
        [view removeFromSuperview];
    }
    [_allImageViews removeAllObjects];
    
    [[Game getgame] newgame];
    [_hitbutton setEnabled:YES];
    [_standbutton setEnabled:YES];

}

-(void) endgame
{

    if ([[Game getgame].dealerHand getPipValue]>21)
    {
        [[[TAlertView alloc] initWithTitle:@"you win!"
                                   message:@"the dealer busts."
                                   buttons:nil
                               andCallBack:^(TAlertView *alertView) {
                                   //Your action
                                   self.reset;
                               }]
         show];
    }
    else if ([[Game getgame].dealerHand getPipValue]>[[Game getgame].playerHand getPipValue])
    {
        [[[TAlertView alloc] initWithTitle:@"you lose!"
                                   message:@"the dealer has a better hand."
                                   buttons:nil
                               andCallBack:^(TAlertView *alertView) {
                                   //Your action
                                   self.reset;
                               }]
         show];

    }
    else if ([[Game getgame].dealerHand getPipValue]<[[Game getgame].playerHand getPipValue])
    {
        [[[TAlertView alloc] initWithTitle:@"you win!"
                                   message:@"your hand is better."
                                   buttons:nil
                               andCallBack:^(TAlertView *alertView) {
                                   //Your action
                                   self.reset;
                               }]
         show];
        
    }
    else if ([[Game getgame].dealerHand getPipValue]==[[Game getgame].playerHand getPipValue])
    {
        [[[TAlertView alloc] initWithTitle:@"it's a tie!"
                                   message:nil
                                   buttons:nil
                               andCallBack:^(TAlertView *alertView) {
                                   //Your action
                                   self.reset;
                               }]
         show];
        
    }
    _score.text = [NSString stringWithFormat:@"score: %d:%d",[[Game getgame] pwins],[[Game getgame] dwins]];

}

@end



