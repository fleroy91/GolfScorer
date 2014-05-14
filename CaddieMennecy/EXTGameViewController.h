//
//  EXTGameViewController.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 29/04/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface EXTGameViewController : UITableViewController <FXFormControllerDelegate>
@property Game *game;
@end
