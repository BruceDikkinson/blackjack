//
//  Deck.h
//  blackjack
//
//  Created by Paul Punke on 28.05.15.
//  Copyright (c) 2015 paul. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Card;

@interface Deck : NSObject {
    NSMutableArray *cards;
}

-(Card *) drawCard;
-(void) shuffle;


@end