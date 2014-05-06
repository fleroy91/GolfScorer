//
//  Hole.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 06/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hole : NSObject

@property NSInteger num;
@property NSInteger par;
@property NSInteger hcp;
@property NSInteger range1; // Black
@property NSInteger range2; // White
@property NSInteger range3; // Yellow
@property NSInteger range4; // Red
@property NSInteger range5; // Blue

-(Hole *)initWithArray:(NSArray *)holeData;

@end
