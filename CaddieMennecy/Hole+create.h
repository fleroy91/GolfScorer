//
//  Hole+create.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 07/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "Hole.h"
#import "Course.h"

@interface Hole (create)

-(Hole *)initWithArray:(NSArray *)holeData andCourse:(Course *)course;
-(Hole *)initWithDictionnary:(NSDictionary *)holeDictionnary andCourse:(Course *)course;
-(NSUInteger)getDistanceForColor:(NSUInteger)start_color;
-(NSString *)formatDistanceForColor:(NSUInteger)start_color;

@end
