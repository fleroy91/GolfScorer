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
-(NSString *)formatDistanceForColor:(NSUInteger)start_color
{
    return [NSString stringWithFormat:@"%lu %@", (unsigned long)[self getDistanceForColor:start_color], [settings getDistanceUnit]];
}

-(NSUInteger)getDistanceForColor:(NSUInteger)start_color
{
    NSUInteger dist = 0;
    switch(start_color) {
        case 0:
            dist = self.range1.unsignedIntegerValue;
            break;
        case 1:
            dist = self.range2.unsignedIntegerValue;
            break;
        case 2:
            dist = self.range3.unsignedIntegerValue;
            break;
        case 3:
            dist = self.range4.unsignedIntegerValue;
            break;
        case 4:
            dist = self.range5.unsignedIntegerValue;
            break;
        default:
            dist = self.range3.unsignedIntegerValue;
            break;
    }
    return [settings convertDistance:dist];
}

@end
