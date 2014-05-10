//
//  Hole+create.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 07/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "Hole+create.h"

@implementation Hole (create)

-(Hole *)initWithArray:(NSArray *)holeData andCourse:(Course *)course
{
    assert([holeData count] >= 7);
    self.number = holeData[0];
    self.par = holeData[1];
    self.handicap = holeData[2];
    self.range1 = holeData[3];
    self.range2 = holeData[3];
    self.range3 = holeData[4];
    self.range4 = holeData[5];
    self.range5  = holeData[6];
    self.forCourse = course;
    [self.managedObjectContext MR_saveToPersistentStoreAndWait];
    return self;
}

@end
