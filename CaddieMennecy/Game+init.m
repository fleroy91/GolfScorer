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
    game.forCourse = [Course MR_findFirst];
    NSManagedObjectContext* context = game.managedObjectContext;
    [context MR_saveToPersistentStoreAndWait];
    return game;
}

-(NSUInteger)nbPlayers
{
    return [self.thePlayerGames count];
}
-(void)setIsOver:(BOOL)over
{
    self.is_over = [NSNumber numberWithBool:over];
    [self.managedObjectContext MR_saveToPersistentStoreAndWait];
}
-(void)setIsStarted:(BOOL)started
{
    self.is_started = [NSNumber numberWithBool:started];
    [self.managedObjectContext MR_saveToPersistentStoreAndWait];
}
- (float)getSSS:(PlayerGame *)pg
{
    float ret = 0;
    if(pg.forPlayer.gender.unsignedIntegerValue == 1)
    {
        // Male
        switch(pg.forPlayer.start_color.unsignedIntegerValue) {
            case 1:
                ret = self.forCourse.sss1M.floatValue;
                break;
            case 2:
                ret = self.forCourse.sss2M.floatValue;
                break;
            case 3:
                ret = self.forCourse.sss3M.floatValue;
                break;
            case 4:
                ret = self.forCourse.sss4M.floatValue;
                break;
            case 5:
                ret = self.forCourse.sss5M.floatValue;
                break;
       
        }
    } else {
        // Male
        switch(pg.forPlayer.start_color.unsignedIntegerValue) {
            case 1:
                ret = self.forCourse.sss1F.floatValue;
                break;
            case 2:
                ret = self.forCourse.sss2F.floatValue;
                break;
            case 3:
                ret = self.forCourse.sss3F.floatValue;
                break;
            case 4:
                ret = self.forCourse.sss4F.floatValue;
                break;
            case 5:
                ret = self.forCourse.sss5F.floatValue;
                break;
                
        }
    }
    return ret;
}
- (float)getSlope:(PlayerGame *)pg
{
    float ret = 0;
    if(pg.forPlayer.gender.unsignedIntegerValue == 1)
    {
        // Male
        switch(pg.forPlayer.start_color.unsignedIntegerValue) {
            case 1:
                ret = self.forCourse.slope1M.floatValue;
                break;
            case 2:
                ret = self.forCourse.slope2M.floatValue;
                break;
            case 3:
                ret = self.forCourse.slope3M.floatValue;
                break;
            case 4:
                ret = self.forCourse.slope4M.floatValue;
                break;
            case 5:
                ret = self.forCourse.slope5M.floatValue;
                break;
                
        }
    } else {
        // Male
        switch(pg.forPlayer.start_color.unsignedIntegerValue) {
            case 1:
                ret = self.forCourse.slope1F.floatValue;
                break;
            case 2:
                ret = self.forCourse.slope2F.floatValue;
                break;
            case 3:
                ret = self.forCourse.slope3F.floatValue;
                break;
            case 4:
                ret = self.forCourse.slope4F.floatValue;
                break;
            case 5:
                ret = self.forCourse.slope5F.floatValue;
                break;
                
        }
    }
    return ret;
}

-(void)findOrCreateHolesForPlayers
{
    for(PlayerGame *pg in self.thePlayerGames) {
        float sss = [self getSSS:pg];
        float slope = [self getSlope:pg];
        
        pg.game_total_hcp = [NSNumber numberWithUnsignedInt:pg.forPlayer.index.floatValue * (slope / 113) + sss - self.forCourse.par.unsignedIntegerValue];
        
        NSArray *holes = [Hole MR_findAll];
        for(Hole* hole in holes) {
            PlayerGameHole *found = nil;
            for(PlayerGameHole *pgh in pg.thePlayerGameHoles) {
                if(pgh.number.integerValue == hole.number.integerValue) {
                    found = pgh;
                    break;
                }
            }
            if(! found) {
                PlayerGameHole *pgh = [PlayerGameHole MR_createEntity];
                pgh.number = hole.number;
                pgh.forHole = hole;
                pgh.inPlayerGame = pg;
                pgh.hole_score = hole.par;
                pgh.nb_putts = [NSNumber numberWithInt:2];
                [pgh.managedObjectContext MR_saveToPersistentStoreAndWait];
                NSLog(@"Creation of %@ for \n\t%@", pgh, pg);
                assert(pgh.forHole);
                found = pgh;
            }
            // Game handicap
            NSUInteger hcp_base = (NSUInteger)(pg.game_total_hcp.unsignedIntegerValue / 18);
            NSUInteger hcp_rest = pg.game_total_hcp.unsignedIntegerValue - hcp_base * 18;
            found.game_hcp = [NSNumber numberWithUnsignedInt:(hcp_base + (hole.handicap.unsignedIntegerValue <= hcp_rest ? 1 : 0))];
            [found.managedObjectContext MR_saveToPersistentStoreAndWait];
            assert(found.forHole);
        }
    }
}
@end
