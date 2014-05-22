//
//  Game.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 17/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course, PlayerGame;

@interface Game : NSManagedObject

@property (nonatomic, retain) NSNumber * is_over;
@property (nonatomic, retain) NSNumber * is_started;
@property (nonatomic, retain) NSNumber * kind;
@property (nonatomic, retain) NSDate * when;
@property (nonatomic, retain) NSDate * end_at;
@property (nonatomic, retain) Course *forCourse;
@property (nonatomic, retain) NSOrderedSet *thePlayerGames;
@end

@interface Game (CoreDataGeneratedAccessors)

- (void)insertObject:(PlayerGame *)value inThePlayerGamesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromThePlayerGamesAtIndex:(NSUInteger)idx;
- (void)insertThePlayerGames:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeThePlayerGamesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInThePlayerGamesAtIndex:(NSUInteger)idx withObject:(PlayerGame *)value;
- (void)replaceThePlayerGamesAtIndexes:(NSIndexSet *)indexes withThePlayerGames:(NSArray *)values;
- (void)addThePlayerGamesObject:(PlayerGame *)value;
- (void)removeThePlayerGamesObject:(PlayerGame *)value;
- (void)addThePlayerGames:(NSOrderedSet *)values;
- (void)removeThePlayerGames:(NSOrderedSet *)values;
@end
