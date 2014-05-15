//
//  Course.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 15/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game, Hole;

@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * par;
@property (nonatomic, retain) NSNumber * slope1F;
@property (nonatomic, retain) NSNumber * slope1M;
@property (nonatomic, retain) NSNumber * slope2F;
@property (nonatomic, retain) NSNumber * slope2M;
@property (nonatomic, retain) NSNumber * slope3F;
@property (nonatomic, retain) NSNumber * slope3M;
@property (nonatomic, retain) NSNumber * slope4F;
@property (nonatomic, retain) NSNumber * slope4M;
@property (nonatomic, retain) NSNumber * slope5F;
@property (nonatomic, retain) NSNumber * slope5M;
@property (nonatomic, retain) NSNumber * sss1F;
@property (nonatomic, retain) NSNumber * sss1M;
@property (nonatomic, retain) NSNumber * sss2F;
@property (nonatomic, retain) NSNumber * sss2M;
@property (nonatomic, retain) NSNumber * sss3F;
@property (nonatomic, retain) NSNumber * sss3M;
@property (nonatomic, retain) NSNumber * sss4F;
@property (nonatomic, retain) NSNumber * sss4M;
@property (nonatomic, retain) NSNumber * sss5F;
@property (nonatomic, retain) NSNumber * sss5M;
@property (nonatomic, retain) NSSet *theGames;
@property (nonatomic, retain) NSSet *theHoles;
@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addTheGamesObject:(Game *)value;
- (void)removeTheGamesObject:(Game *)value;
- (void)addTheGames:(NSSet *)values;
- (void)removeTheGames:(NSSet *)values;

- (void)addTheHolesObject:(Hole *)value;
- (void)removeTheHolesObject:(Hole *)value;
- (void)addTheHoles:(NSSet *)values;
- (void)removeTheHoles:(NSSet *)values;

@end
