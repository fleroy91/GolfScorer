//
//  Player.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 10/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <FXForms.h>

@class PlayerGame;

@interface Player : NSManagedObject <FXForm>

@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSString * lastname;
@property (nonatomic, retain) NSString * surname;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSNumber * start_color;
@property (nonatomic, retain) NSSet *thePlayerGames;
@end

@interface Player (CoreDataGeneratedAccessors)

- (void)addThePlayerGamesObject:(PlayerGame *)value;
- (void)removeThePlayerGamesObject:(PlayerGame *)value;
- (void)addThePlayerGames:(NSSet *)values;
- (void)removeThePlayerGames:(NSSet *)values;

@end
