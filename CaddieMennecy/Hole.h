//
//  Hole.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 04/07/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course, PlayerGameHole;

@interface Hole : NSManagedObject

@property (nonatomic, retain) NSNumber * handicap;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * par;
@property (nonatomic, retain) NSNumber * range1;
@property (nonatomic, retain) NSNumber * range2;
@property (nonatomic, retain) NSNumber * range3;
@property (nonatomic, retain) NSNumber * range4;
@property (nonatomic, retain) NSNumber * range5;
@property (nonatomic, retain) NSNumber * time;
@property (nonatomic, retain) Course *forCourse;
@property (nonatomic, retain) NSSet *thePlayerGameHoles;
@end

@interface Hole (CoreDataGeneratedAccessors)

- (void)addThePlayerGameHolesObject:(PlayerGameHole *)value;
- (void)removeThePlayerGameHolesObject:(PlayerGameHole *)value;
- (void)addThePlayerGameHoles:(NSSet *)values;
- (void)removeThePlayerGameHoles:(NSSet *)values;

@end
