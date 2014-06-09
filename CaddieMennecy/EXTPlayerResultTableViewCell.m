//
//  EXTPlayerResultTableViewself.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 16/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTPlayerResultTableViewCell.h"

@implementation EXTPlayerResultTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)update
{
    [self.playerName setText:[self.playerGame.forPlayer description]];
    
    [self.parLabel setText:[NSString stringWithFormat:@"Par : %ld", (long)[self.playerGame getNbHolesFrom:0 to:0 forNet:NO]]];
    [self.birdieLabel setText:[NSString stringWithFormat:@"Birdie : %ld", (long)[self.playerGame getNbHolesFrom:-1 to:-1 forNet:NO]]];
    [self.eagleLabel setText:[NSString stringWithFormat:@"Eagle : %ld", (long)[self.playerGame getNbHolesFrom:-2 to:-2 forNet:NO]]];
    [self.albatrosLabel setText:[NSString stringWithFormat:@"Albatros : %ld", (long)[self.playerGame getNbHolesFrom:-100 to:-3 forNet:NO]]];
    [self.bogeyLabel setText:[NSString stringWithFormat:@"Bogey : %ld", (long)[self.playerGame getNbHolesFrom:1 to:1 forNet:NO]]];
    [self.doubleLabel setText:[NSString stringWithFormat:@"Double : %ld", (long)[self.playerGame getNbHolesFrom:2 to:2 forNet:NO]]];
    [self.tripleLabel setText:[NSString stringWithFormat:@"Triple et + : %ld", (long)[self.playerGame getNbHolesFrom:3 to:100 forNet:NO]]];
    
    [self.brutLabel setText:[NSString stringWithFormat:@"Brut : %@", [self.playerGame getBrutScore:NO]]];
    [self.netLabel setText:[NSString stringWithFormat:@"Net : %@", [self.playerGame getNetScore:NO]]];
    [self.sBrutLabel setText:[NSString stringWithFormat:@"Stabelford Brut : %@", [self.playerGame getBrutScore:YES]]];
    [self.sNetLabel setText:[NSString stringWithFormat:@"Stabelford Net : %@", [self.playerGame getNetScore:YES]]];
}

@end
