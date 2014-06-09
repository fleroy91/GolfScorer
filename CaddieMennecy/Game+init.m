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
    game.kind = @0;
    game.start_hole = @0;
    game.nb_holes = @0;
    game.forCourse = [Course MR_findFirst];
    game.is_over = NO;
    game.is_started = NO;
    for(Player *player in [Player MR_findByAttribute:@"is_default" withValue:@YES]) {
        [game addPlayerInGame:player];
    }
    NSManagedObjectContext* context = game.managedObjectContext;
    [context MR_saveToPersistentStoreAndWait];
    return game;
}

-(void)setIsOver:(BOOL)over
{
    self.is_over = [NSNumber numberWithBool:over];
    self.end_at = [NSDate date];
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
        
        for(Hole* hole in currentGame.forCourse.theHoles) {
            PlayerGameHole *found = nil;
            for(PlayerGameHole *pgh in pg.thePlayerGameHoles) {
                if(pgh.number.integerValue == hole.number.integerValue) {
                    found = pgh;
                    break;
                }
            }
            if([currentGame getNbHolesPlayed] < 18 && (hole.number.integerValue < [currentGame getStartingHoleNumber]  || hole.number.integerValue > [currentGame getEndingHoleNumber]))
            {
                // We need to remove it
                if(found) {
                    [found MR_deleteEntity];
                }
            } else {
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
                found.game_hcp = [NSNumber numberWithUnsignedLong:(hcp_base + (hole.handicap.unsignedIntegerValue <= hcp_rest ? 1 : 0))];
                [found.managedObjectContext MR_saveToPersistentStoreAndWait];
                assert(found.forHole);
            }
        }
    }
}
- (NSUInteger)getNbHolesPlayed
{
    NSUInteger ret = 0;
    switch(self.nb_holes.integerValue) {
        case 0:
            ret = 18;
            break;
        case 1:
            ret = 9;
            break;
    }
    return ret;
}

- (NSUInteger)getStartingHoleNumber
{
    NSUInteger ret = 0;
    switch(self.start_hole.integerValue) {
        case 0:
            ret = 1;
            break;
        case 1:
            ret = 10;
            break;
    }
    return ret;
}
- (NSUInteger)getEndingHoleNumber
{
    NSUInteger ret = 0;
    if([self getNbHolesPlayed] == 18) {
        if([self getStartingHoleNumber] == 1) {
            ret = 18;
        } else {
            ret = 9;
        }
    } else {
        if([self getStartingHoleNumber] == 1) {
            ret = 9;
        } else {
            ret = 18;
        }
        
    }
    return ret;
}


- (NSUInteger)nbPlayers
{
    return [self.thePlayerGames count];
}
- (NSString *)theCourse
{
    if(self.forCourse) {
        return self.forCourse.name;
    } else {
        return nil;
    }
}

- (void)setTheCourse:(NSString *)course_name
{
    Course *course = [Course MR_findFirstByAttribute:@"name" withValue:(NSString *)course_name];
    if(course) {
        self.forCourse = course;
    }
}

- (NSArray *)getCoursesOptions
{
    NSArray *courses = [Course MR_findAllSortedBy:@"name" ascending:YES];
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    for(Course *course in courses) {
        [ret addObject:course.name];
    }
    return ret;
}

- (PlayerGame *)findPlayerGameForPlayer:(Player *)player
{
    for(PlayerGame *pg in self.thePlayerGames) {
        if(pg.forPlayer == player) {
            return pg;
        }
    }
    return nil;
}

- (BOOL)addPlayerInGame:(Player *)player
{
    BOOL added = NO;
    if([self.thePlayerGames count] < 4) {
        added = YES;
        [PlayerGame initInGame:self forPlayer:player andRow:[NSNumber numberWithUnsignedLong:([self.thePlayerGames count] + 1)]];
    }
    return added;
}
- (BOOL)removePlayerFromGame:(Player *)player
{
    BOOL removed = true;
    PlayerGame *pg = [self findPlayerGameForPlayer:player];
    if(pg) {
        NSInteger currentRow = pg.row.integerValue;
        [pg MR_deleteEntity];
        removed = YES;
        // We need to rename the order the next PlayerGame
        for(PlayerGame *next_pg in self.thePlayerGames) {
            if(next_pg.row.integerValue > currentRow) {
                next_pg.row = [NSNumber numberWithLong:(next_pg.row.integerValue - 1)];
            }
        }
        [pg.managedObjectContext MR_saveToPersistentStoreAndWait];
    }
    return removed;
}
-(NSArray *)kindOptions
{
    return @[@"18 trous - départ 1", @"18 trous - départ 10", @"9 trous - départ 1", @"9 trous - départ 10"];
}
-(NSString *)getKindName
{
    return [[self kindOptions] objectAtIndex:self.kind.integerValue];
}
- (NSString *)getWhenDescription
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    return [dateFormatter stringFromDate:self.when];
}

- (NSArray *)fields
{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    [ret addObject:@{FXFormFieldKey: @"when", FXFormFieldTitle: @"Date", FXFormFieldHeader:@" ", FXFormFieldType: FXFormFieldTypeLabel, FXFormFieldAction: @"doNothing:"}];
    [ret addObject:@{FXFormFieldKey: @"theCourse", FXFormFieldTitle: @"Parcours", FXFormFieldOptions: [self getCoursesOptions]}];
    [ret addObject:@{FXFormFieldKey: @"nb_holes", FXFormFieldTitle: @"Nombre de trous", FXFormFieldOptions: @[@"18 trous", @"9 trous"]}];
    [ret addObject:@{FXFormFieldKey: @"start_hole", FXFormFieldTitle: @"Trou de départ", FXFormFieldOptions: @[@"1", @"10"]}];
    [ret addObject:@{FXFormFieldKey: @"nbPlayers", FXFormFieldTitle: @"Joueurs", FXFormFieldAction: @"choosePlayers:"}];
    return ret;
}
@end
