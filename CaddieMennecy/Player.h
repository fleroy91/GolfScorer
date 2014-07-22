//
//  Player.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 04/07/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PlayerGame;

@interface Player : NSManagedObject

@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSNumber * is_default;
@property (nonatomic, retain) NSString * lastname;
@property (nonatomic, retain) NSNumber * start_color;
@property (nonatomic, retain) NSString * surname;
@property (nonatomic, retain) NSSet *thePlayerGames;
@end

@interface Player (CoreDataGeneratedAccessors)

- (void)addThePlayerGamesObject:(PlayerGame *)value;
- (void)removeThePlayerGamesObject:(PlayerGame *)value;
- (void)addThePlayerGames:(NSSet *)values;
- (void)removeThePlayerGames:(NSSet *)values;

@end
