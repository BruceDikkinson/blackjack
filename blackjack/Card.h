//
//  card.h
//  blackjack
//
//  Created by Paul Punke on 27.05.15.
//  Copyright (c) 2015 paul. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Hearts,
    Spades,
    Diamonds,
    Clubs
} Suit;

@interface Card : NSObject{
}

@property NSInteger cardNumber;
@property Suit suit;
@property BOOL cardclosed;

-(id) initWithCardNumber:(NSInteger) aCardNumber suit:(Suit) aSuit;
-(NSInteger) pipValue;
-(NSString *) filename;

@end