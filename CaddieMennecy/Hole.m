//
//  Hole.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 06/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "Hole.h"

@implementation Hole

-(Hole *)initWithArray:(NSArray *)holeData
{
    assert([holeData count] >= 7);
    self.num = (NSInteger)holeData[0];
    self.par = (NSInteger)holeData[1];
    self.hcp = (NSInteger)holeData[2];
    self.range2 = (NSInteger)holeData[3];
    self.range3 = (NSInteger)holeData[4];
    self.range4 = (NSInteger)holeData[5];
    self.range5  = (NSInteger)holeData[6];
    return self;
}

@end
