//
//  Course+Addon.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 09/06/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "Course+Addon.h"

@implementation Course (Addon)
-(void)createHoles:(NSArray *)holesData
{
    for(NSArray *holeData in holesData){
        [[Hole MR_createEntity] initWithArray:holeData andCourse:self];
    }
}

-(void)createHolesWithJsonArray:(NSArray *)holesData
{
    int par = 0;
    for(NSDictionary *holeData in holesData){
        Hole *hole = (Hole *)[[Hole MR_createEntity] initWithDictionnary:holeData andCourse:self];
        par += hole.par.integerValue;
    }
    self.par = [NSNumber numberWithInteger:par];
    [self.managedObjectContext MR_saveToPersistentStoreAndWait];
}

-(void)computePar
{
    int par = 0;
    for(Hole *hole in self.theHoles) {
        par += hole.par.integerValue;
    }
    self.par = [NSNumber numberWithInteger:par];
    [self.managedObjectContext MR_saveToPersistentStoreAndWait];
}

@end
