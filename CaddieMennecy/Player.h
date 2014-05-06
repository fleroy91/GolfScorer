//
//  Player.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 06/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game;

@interface Player : NSManagedObject

@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSString * lastname;
@property (nonatomic, retain) NSString * surname;
@property (nonatomic, retain) Game *game;

@end
