//
//  Game+init.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 02/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "Game.h"
#import <FXForms.h>
@class PlayerGame;
@class Player;

@interface Game (init) <FXForm>

+(Game *)create;

-(NSUInteger)nbPlayers;
-(void)findOrCreateHolesForPlayers;
-(void)setIsOver:(BOOL)over;
-(void)setIsStarted:(BOOL)started;
- (PlayerGame *)findPlayerGameForPlayer:(Player *)player;
- (BOOL)addPlayerInGame:(Player *)player;
- (BOOL)removePlayerFromGame:(Player *)player;
- (NSString *)getKindName;
- (NSString *)getPlayersNames;
- (NSUInteger)getStartingHoleNumber;
- (NSUInteger)getEndingHoleNumber;
- (NSUInteger)getNbHolesPlayed;
- (NSString *)getWhenDescription;


@end
