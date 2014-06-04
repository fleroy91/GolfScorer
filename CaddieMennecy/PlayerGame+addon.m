//
//  PlayerGame+addon.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 08/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "PlayerGame+addon.h"
#import "Hole.h"

@implementation PlayerGame (addon)
- (NSString *)formatScore:(NSInteger)score
{
    NSString *ret = nil;
    if(score == 0) {
        ret = @"E";
    } else if(score > 0) {
        ret = [NSString stringWithFormat:@"+%d", score];
    } else {
        ret = [NSString stringWithFormat:@"%d", score];
    }
    return ret;
}
- (NSString *)getBrutScore:(BOOL)showStbl
{
    if(showStbl) {
        return self.stbl_brut_score.stringValue;
    } else {
        return [self formatScore:self.brut_score.intValue];
    }
}
- (NSString *)getNetScore:(BOOL)showStbl
{
    if(showStbl) {
        return self.stbl_net_score.stringValue;
    } else {
        return [self formatScore:self.net_score.intValue];
    }
}

- (NSString *)getFairwayScore:(BOOL)showRatio
{
    NSString *ret = nil;
    int nbFairway = 0;
    int nbHoles = 0;
    for(PlayerGameHole *pgh in self.thePlayerGameHoles) {
        if(pgh.forHole.par.integerValue > 3) {
            nbHoles ++;
            if(pgh.fairway.boolValue) {
                nbFairway ++;
            }
        }
    }
    if(nbHoles > 0) {
        if(showRatio) {
            ret = [NSString stringWithFormat:@"%d/%d", nbFairway,nbHoles];
        } else {
            ret = [NSString stringWithFormat:@"%.1f%%", 100 * (double)nbFairway / (double)nbHoles];
        }
    }
    return ret;
}
- (NSString *)getGIRScore:(BOOL)showRatio
{
    NSString *ret = nil;
    int nbGIR = 0;
    int nbHoles = 0;
    for(PlayerGameHole *pgh in self.thePlayerGameHoles) {
        nbHoles ++;
        if(pgh.gir.boolValue) {
            nbGIR ++;
        }
    }
    if(nbHoles > 0) {
        if(showRatio) {
            ret = [NSString stringWithFormat:@"%d/%d", nbGIR,nbHoles];
        } else {
            ret = [NSString stringWithFormat:@"%.1f%%", 100 * (double)nbGIR / (double)nbHoles];
        }
    }
    return ret;
}
- (NSString *)getAvgPuttScore:(BOOL)showRatio
{
    NSString *ret = nil;
    int nbPutts = 0;
    int nbHoles = 0;
    for(PlayerGameHole *pgh in self.thePlayerGameHoles) {
        nbHoles ++;
        nbPutts += pgh.nb_putts.integerValue;
    }
    if(nbHoles > 0) {
        if(showRatio) {
            ret = [NSString stringWithFormat:@"%d/%d", nbPutts,nbHoles];
        } else {
            ret = [NSString stringWithFormat:@"%.1f", (double)nbPutts / (double)nbHoles];
        }
    }
    return ret;
}

- (NSInteger)getNbHolesFrom:(NSInteger)min to:(NSInteger)max forNet:(BOOL)showNet
{
    NSInteger nb = 0;
    for(PlayerGameHole *pgh in self.thePlayerGameHoles) {
        NSInteger score = pgh.hole_score.integerValue;
        NSInteger par = pgh.forHole.par.integerValue;
        if(showNet) {
            par += pgh.game_hcp.integerValue;
        }
        if(score - par >= min && score - par <= max) {
            nb++;
        }
    }
    return nb;
}


- (void)saveAndComputeScoreUntil:(Hole *)hole
{
    NSLog(@"Before %@ H=%@ B=%@ N=%@ CP=%@ SB=%@ SN=%@", self.forPlayer.firstname, hole.number, self.brut_score, self.net_score, self.game_total_hcp, self.stbl_brut_score, self.stbl_net_score);
    self.brut_score = @0;
    self.net_score = @0;
    self.stbl_brut_score = @36;
    self.stbl_net_score = @36;
    assert([self.thePlayerGameHoles count] <= 18);
    for(PlayerGameHole *pgh in self.thePlayerGameHoles) {
        if(pgh.is_saved.boolValue) {
            NSInteger brut_score = pgh.hole_score.intValue - pgh.forHole.par.intValue;
            NSInteger net_score = pgh.hole_score.intValue - (pgh.forHole.par.intValue + pgh.game_hcp.intValue);
            NSLog(@"PGH #%@ B=%d N=%d", pgh.number, brut_score, net_score);
            self.brut_score = [NSNumber numberWithInt:(self.brut_score.intValue + brut_score)];
            self.stbl_brut_score = [NSNumber numberWithInt:MAX(0, self.stbl_brut_score.intValue + 2 - brut_score) - 2];
            self.net_score = [NSNumber numberWithInt:(self.net_score.intValue + net_score)];
            self.stbl_net_score = [NSNumber numberWithInt:MAX(0, self.stbl_net_score.intValue + 2 - net_score) - 2];
        }
    }
    NSLog(@"After %@ H=%@ B=%@ N=%@ CP=%@ SB=%@ SN=%@", self.forPlayer.firstname, hole.number, self.brut_score, self.net_score, self.game_total_hcp, self.stbl_brut_score, self.stbl_net_score);
    [self.managedObjectContext MR_saveToPersistentStoreAndWait];
}

+ (PlayerGame *)initInGame:(Game *)game forPlayer:(Player *)player andRow:(NSNumber *)row
{
    PlayerGame *pg = [PlayerGame MR_createEntity];
    pg.row = row;
    pg.forPlayer = player;
    pg.inGame = game;
    [pg.managedObjectContext MR_saveToPersistentStoreAndWait];
    return pg;
}

@end
