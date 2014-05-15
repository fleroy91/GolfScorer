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
- (void)saveAndComputeScoreUntil:(Hole *)hole
{
    NSLog(@"Before %@ H=%@ B=%@ N=%@ CP=%@ SB=%@ SN=%@", self.forPlayer.firstname, hole.number, self.brut_score, self.net_score, self.game_total_hcp, self.stbl_brut_score, self.stbl_net_score);
    self.brut_score = @0;
    self.net_score = @0;
    self.stbl_brut_score = @0;
    self.stbl_net_score = @0;
    assert([self.thePlayerGameHoles count] <= 18);
    for(PlayerGameHole *pgh in self.thePlayerGameHoles) {
        NSInteger brut_score = pgh.hole_score.intValue - pgh.forHole.par.intValue;
        NSInteger net_score = pgh.hole_score.intValue - (pgh.forHole.par.intValue + pgh.game_hcp.intValue);
        // We don't compute net score of future holes
        if(pgh.number.unsignedIntValue > hole.number.unsignedIntValue) {
            brut_score = 0;
            net_score = 0;
        }
        NSLog(@"PGH #%@ B=%d N=%d", pgh.number, brut_score, net_score);
        self.brut_score = [NSNumber numberWithInt:(self.brut_score.intValue + brut_score)];
        self.stbl_brut_score = [NSNumber numberWithInt:MAX(0, self.stbl_brut_score.intValue + 2 - brut_score)];
        self.net_score = [NSNumber numberWithInt:(self.net_score.intValue + net_score)];
        self.stbl_net_score = [NSNumber numberWithInt:MAX(0, self.stbl_net_score.intValue + 2 - net_score)];
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
