//
//  Game+init.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 02/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "Game+init.h"
#import "EXTGlobal.h"

@implementation Game (init)

+(Game *)create
{
    Game *game = [Game MR_createEntity];
    game.when = [NSDate date];
    game.kind = @"18 trous";
    return game;
}
@end
