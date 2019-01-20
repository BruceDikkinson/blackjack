//
//  Game.h
//  blackjack
//
//  Created by Paul Punke on 09.06.15.
//  Copyright (c) 2015 paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Hand.h"


@interface Game: NSObject
{
    Hand *dealerHand;
    Hand *playerHand;
    Deck *deck;
}

@property Hand *dealerHand;
@property Hand *playerHand;
@property Deck *deck;
@property NSInteger pwins;
@property NSInteger dwins;

-(void) setup;
-(void) playerHandDraws;
-(void) dealerHandDraws;
-(void) dealersturn;
-(void) newgame;
-(void) reset;
+(Game *)getgame;

@end
