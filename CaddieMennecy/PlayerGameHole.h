//
//  PlayerGameHole.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 15/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hole, PlayerGame;

@interface PlayerGameHole : NSManagedObject

@property (nonatomic, retain) NSNumber * fairway;
@property (nonatomic, retain) NSNumber * game_hcp;
@property (nonatomic, retain) NSNumber * gir;
@property (nonatomic, retain) NSNumber * hole_score;
@property (nonatomic, retain) NSNumber * nb_putts;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) Hole *forHole;
@property (nonatomic, retain) PlayerGame *inPlayerGame;

@end
