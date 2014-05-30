//
//  PlayerGameHole+form.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 10/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "PlayerGameHole.h"

@interface PlayerGameHole (form)

- (NSArray *)fields;
- (NSUInteger)getDistanceForColor:(NSUInteger)start_color;
- (NSString *)formatDistanceForColor:(NSUInteger)start_color;
- (BOOL)isLastHoleAndPlayer;
@end
