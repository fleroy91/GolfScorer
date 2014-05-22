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

    // Configure the view for the selected state
}

-(void)update
{
    [self.playerName setText:[self.playerGame.forPlayer description]];
    [self.fairwayResultLabel setText:[self.playerGame getFairwayScore:self.showRatio]];
    [self.girResultLabel setText:[self.playerGame getGIRScore:self.showRatio]];
    [self.avgPuttResultLabel setText:[self.playerGame getAvgPuttScore:self.showRatio]];
    
    [self.parLabel setText:[NSString stringWithFormat:@"Par : %d", [self.playerGame getNbHolesFrom:0 to:0 forNet:self.showNet]]];
    [self.birdieLabel setText:[NSString stringWithFormat:@"Birdie : %d", [self.playerGame getNbHolesFrom:-1 to:-1 forNet:self.showNet]]];
    [self.eagleLabel setText:[NSString stringWithFormat:@"Eagle : %d", [self.playerGame getNbHolesFrom:-2 to:-2 forNet:self.showNet]]];
    [self.albatrosLabel setText:[NSString stringWithFormat:@"Albatros : %d", [self.playerGame getNbHolesFrom:-100 to:-3 forNet:self.showNet]]];
    [self.bogeyLabel setText:[NSString stringWithFormat:@"Bogey : %d", [self.playerGame getNbHolesFrom:1 to:1 forNet:self.showNet]]];
    [self.doubleLabel setText:[NSString stringWithFormat:@"Double : %d", [self.playerGame getNbHolesFrom:2 to:2 forNet:self.showNet]]];
    [self.tripleLabel setText:[NSString stringWithFormat:@"Triple et + : %d", [self.playerGame getNbHolesFrom:3 to:100 forNet:self.showNet]]];
    
    UIColor *color = (self.showStbl ? [UIColor yellowColor] : [UIColor whiteColor]);
    [self.displayLabel setTextColor:color];
    [self.parLabel setTextColor:color];
    [self.birdieLabel setTextColor:color];
    [self.eagleLabel setTextColor:color];
    [self.albatrosLabel setTextColor:color];
    [self.bogeyLabel setTextColor:color];
    [self.doubleLabel setTextColor:color];
    [self.tripleLabel setTextColor:color];
    NSString *title = nil;
    if(self.showNet) {
        if(self.showStbl) {
            title = [NSString stringWithFormat:@"Stabelford Net : %@", [self.playerGame getNetScore:self.showStbl]];
        } else {
            title = [NSString stringWithFormat:@"Net : %@", [self.playerGame getNetScore:self.showStbl]];
        }
    } else {
        if(self.showStbl) {
            title = [NSString stringWithFormat:@"Stabelford Brut : %@", [self.playerGame getBrutScore:self.showStbl]];
        } else {
            title = [NSString stringWithFormat:@"Brut : %@", [self.playerGame getBrutScore:self.showStbl]];
        }
    }
    [self.displayLabel setText:title];
}

-(void)toggleDisplay
{
    if(! self.showNet) {
        self.showNet = YES;
    } else {
        if(! self.showStbl) {
            self.showStbl = YES;
        } else {
            if(! self.showRatio) {
                self.showRatio = YES;
            } else {
                self.showRatio = NO;
                self.showNet = NO;
                self.showStbl = NO;
            }
        }
    }
    [self update];
}

@end
