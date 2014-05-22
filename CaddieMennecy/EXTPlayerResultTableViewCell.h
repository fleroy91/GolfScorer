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
@property (weak, nonatomic) IBOutlet UILabel *fairwayResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *girResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgPuttResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *fairwayLabel;
@property (weak, nonatomic) IBOutlet UILabel *girLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgPuttLabel;
@property (weak, nonatomic) IBOutlet UILabel *birdieLabel;
@property (weak, nonatomic) IBOutlet UILabel *eagleLabel;
@property (weak, nonatomic) IBOutlet UILabel *albatrosLabel;
@property (weak, nonatomic) IBOutlet UILabel *parLabel;
@property (weak, nonatomic) IBOutlet UILabel *bogeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *doubleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripleLabel;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
- (IBAction)toggleDisplay:(id)sender;

@property PlayerGame *playerGame;
-(void)update;
-(void)toggleDisplay;
@property BOOL showStbl;
@property BOOL showNet;
@property BOOL showRatio;

@end
