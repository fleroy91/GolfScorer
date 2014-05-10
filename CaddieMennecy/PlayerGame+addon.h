//
//  PlayerGame+addon.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 08/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "PlayerGame.h"
@class Hole;

@interface PlayerGame (addon)
- (NSString *)getBrutScore:(BOOL)showStbl;
- (NSString *)getNetScore:(BOOL)showStbl;

- (void)saveAndComputeScoreUntil:(Hole *)hole;

@end
