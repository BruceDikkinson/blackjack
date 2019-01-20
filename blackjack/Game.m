//
//  Game.m
//  blackjack
//
//  Created by Paul Punke on 09.06.15.
//  Copyright (c) 2015 paul. All rights reserved.
//

#import "Game.h"


@implementation Game

@synthesize playerHand = _playerHand;
@synthesize dealerHand = _dealerHand;
@synthesize deck = _deck;
@synthesize pwins = _pwins;
@synthesize dwins = _dwins;

static Game* game = nil;

-(id) init {
    if ((self = [super init])){
        _deck = [[Deck alloc] init];
        _playerHand = [[Hand alloc] init];
        _dealerHand = [[Hand alloc] init];
        _dealerHand.handClosed = YES;
    }
    return (self);
}

-(void)setup
{
    //deal cards
    [self playerHandDraws];
    [self dealerHandDraws];
    [self playerHandDraws];
    [self dealerHandDraws];
    
    //NSLog ([NSString stringWithFormat:@"Player:%@", _playerHand.description] );
    NSLog ([NSString stringWithFormat:@"Dealer:%@", _dealerHand.description] );
    
}

-(void) dealersturn
{
    [self willChangeValueForKey:@"dealerHand"];
    [_dealerHand setHandClosed:NO];
    [self didChangeValueForKey:@"dealerHand"];

    while ([_dealerHand getPipValue] <17)
        {
        
        [self dealerHandDraws];
        }
    
    
    if (_dealerHand.getPipValue>21)
    {
        _pwins += 1;
    }
    else if (_dealerHand.getPipValue>_playerHand.getPipValue)
    {
        _dwins += 1;
        
    }
    else if (_dealerHand.getPipValue<_playerHand.getPipValue)
    {
        _pwins += 1;
        
    }
    else if (_dealerHand.getPipValue==_playerHand.getPipValue)
    {

        
    }

    
}



-(void)dealerHandDraws
{
    [self willChangeValueForKey:@"dealerHand"];
    [_dealerHand addCard:[_deck drawCard]];
    [self didChangeValueForKey:@"dealerHand"];

}

-(void)playerHandDraws
{
    [self willChangeValueForKey:@"playerHand"];
    [_playerHand addCard:[_deck drawCard]];
    [self didChangeValueForKey:@"playerHand"];
    if (_playerHand.getPipValue> 21) {
        _dwins +=1;
    }
}
-(void) checkplayer
{
    if ([_playerHand getPipValue] >21) {
        
    }
    
}

-(void) newgame
{
    _deck = nil;
    
    
    _playerHand = nil;
    
    _dealerHand = nil;
    
    [self willChangeValueForKey:@"playerHand"];
    [self didChangeValueForKey:@"playerHand"];
    [self init];
    [self willChangeValueForKey:@"dealerHand"];
    [self didChangeValueForKey:@"dealerHand"];
    [self setup];
    
}

-(void) reset
{
    _pwins=0;
    _dwins=0;
}

+(Game *) getgame{
    if (game == nil){
        game = [[Game alloc] init];
    }
    return game;
}

-(void)dealerStartsTurn{
    [self willChangeValueForKey:@"dealerHand"];
    [_dealerHand setHandClosed:NO];
    [self didChangeValueForKey:@"dealerHand"];
}

@end