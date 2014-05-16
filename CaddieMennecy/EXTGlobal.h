//
//  EXTGlobal.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 05/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#ifndef CaddieMennecy_EXTGlobal_h
#define CaddieMennecy_EXTGlobal_h

#import "Game+init.h"
#import "Player+create.h"
#import "Hole+create.h"
#import "PlayerGame+addon.h"
#import "PlayerGameHole.h"
#import "Course.h"

Game *currentGame;

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBAndAlpha(rgbValue,alph) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(alph)]

#endif
