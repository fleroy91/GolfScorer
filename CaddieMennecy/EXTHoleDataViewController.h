//
//  EXTDataViewController.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 28/04/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FXForms.h>
#import "EXTScrollHolesViewController.h"

@interface EXTHoleDataViewController : UIViewController 

@property (strong, nonatomic) NSArray *playerGameHoles;
@property (strong, nonatomic) Hole *hole;
@property NSUInteger pageIndex;
@property EXTScrollHolesViewController *modelController;
- (void)saveHole;
- (PlayerGameHole *)getCurrentPlayerGameHole;

@end
