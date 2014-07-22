//
//  EXTDistanceView.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 04/06/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTDistanceView.h"

static int kLabelHeight = 25.0f;

@interface EXTDistanceView ()
@property (nonatomic)  NSArray *distColors;
@end

@implementation EXTDistanceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setPlayerGameHole:(PlayerGameHole *)playerGameHole
{
    CGFloat scrollWidth = CGRectGetWidth(self.bounds);
    CGFloat screenHeight = CGRectGetHeight(self.bounds);
    [self setFrame:CGRectMake(0,
                              0,
                              scrollWidth,
                              screenHeight)];
    
    [self setPagingEnabled:NO];
    [self setShowsVerticalScrollIndicator:NO];
    [self setContentSize:CGSizeMake(scrollWidth, 5 * kLabelHeight)];

    _distColors = @[[UIColor blackColor], [UIColor whiteColor], [UIColor yellowColor], [UIColor blueColor], [UIColor redColor]];
    
    _playerGameHole = playerGameHole;
    for(int rangeIndex = 0; rangeIndex <= 4; rangeIndex ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, rangeIndex * kLabelHeight, scrollWidth, kLabelHeight)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.text = [playerGameHole formatDistanceForColor:rangeIndex];
        [label setTextColor:self.distColors[rangeIndex]];
        [self addSubview:label];
        if(rangeIndex == playerGameHole.inPlayerGame.forPlayer.start_color.unsignedIntegerValue) {
            [self setContentOffset:CGPointMake(0, rangeIndex * kLabelHeight - kLabelHeight/2) animated:NO];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
