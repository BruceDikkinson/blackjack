//
//  Hand.h
//  blackjack
//
//  Created by Paul Punke on 28.05.15.
//  Copyright (c) 2015 paul. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Card;

@interface Hand : NSObject {
    
}

@property NSMutableArray *cardsInHand;
@property BOOL handClosed;

-(void) addCard:(Card *)card;
-(NSInteger) getPipValue;
-(NSInteger) countCards;
-(Card *) getCardAtIndex:(NSInteger) index;




@end
