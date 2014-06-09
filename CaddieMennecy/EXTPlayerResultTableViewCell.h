//
//  EXTPlayerResultTableViewCell.h
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 16/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXTPlayerResultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *playerName;
@property (weak, nonatomic) IBOutlet UILabel *birdieLabel;
@property (weak, nonatomic) IBOutlet UILabel *eagleLabel;
@property (weak, nonatomic) IBOutlet UILabel *albatrosLabel;
@property (weak, nonatomic) IBOutlet UILabel *parLabel;
@property (weak, nonatomic) IBOutlet UILabel *bogeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *doubleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripleLabel;
@property (weak, nonatomic) IBOutlet UILabel *brutLabel;
@property (weak, nonatomic) IBOutlet UILabel *netLabel;
@property (weak, nonatomic) IBOutlet UILabel *sBrutLabel;
@property (weak, nonatomic) IBOutlet UILabel *sNetLabel;

@property PlayerGame *playerGame;
-(void)update;

@end
