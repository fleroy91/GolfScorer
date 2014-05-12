//
//  Game+init.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 02/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "Game.h"

@interface Game (init)

+(Game *)create;
-(NSUInteger)nbPlayers;
-(void)findOrCreateHolesForPlayers;
-(void)setIsOver:(BOOL)over;
-(void)setIsStarted:(BOOL)started;

@end
