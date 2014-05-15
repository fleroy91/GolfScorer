//
//  PlayerGame.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 15/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game, Player, PlayerGameHole;

@interface PlayerGame : NSManagedObject

@property (nonatomic, retain) NSNumber * brut_score;
@property (nonatomic, retain) NSNumber * game_total_hcp;
@property (nonatomic, retain) NSNumber * net_score;
@property (nonatomic, retain) NSNumber * row;
@property (nonatomic, retain) NSNumber * stbl_brut_score;
@property (nonatomic, retain) NSNumber * stbl_net_score;
@property (nonatomic, retain) Player *forPlayer;
@property (nonatomic, retain) Game *inGame;
@property (nonatomic, retain) NSSet *thePlayerGameHoles;
@end

@interface PlayerGame (CoreDataGeneratedAccessors)

- (void)addThePlayerGameHolesObject:(PlayerGameHole *)value;
- (void)removeThePlayerGameHolesObject:(PlayerGameHole *)value;
- (void)addThePlayerGameHoles:(NSSet *)values;
- (void)removeThePlayerGameHoles:(NSSet *)values;

@end
