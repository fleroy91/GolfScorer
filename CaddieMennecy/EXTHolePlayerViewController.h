//
//  EXTHolePlayerViewController.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 05/06/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXTHoleDataViewController.h"

@interface EXTHolePlayerViewController : UIViewController <FXFormControllerDelegate>

@property PlayerGameHole *playerGameHole;
@property EXTHoleDataViewController *modelController;

- (void)saveHole;
@end
