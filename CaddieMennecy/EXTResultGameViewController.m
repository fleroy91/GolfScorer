//
//  EXTResultGameViewController.m
//  CaddieMennecy
//
//  Created by Frédéric Leroy on 16/05/2014.
//  Copyright (c) 2014 Frédéric Leroy. All rights reserved.
//

#import "EXTResultGameViewController.h"
#import "EXTPlayerResultTableViewCell.h"
#import "EXTScoreCardViewController.h"

@interface EXTResultGameViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@end

@implementation EXTResultGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSTimeInterval duration = [self.game.end_at timeIntervalSinceDate:self.game.when];
    NSUInteger seconds = (NSUInteger)round(duration);
    [self.durationLabel setText:[NSString stringWithFormat:@"Durée de jeu : %02uh%02u",
                        seconds / 3600, (seconds / 60) % 60]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.game.thePlayerGames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EXTPlayerResultTableViewCell *cell = (EXTPlayerResultTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"playerResult" forIndexPath:indexPath];
    for(PlayerGame *pg in self.game.thePlayerGames) {
        if(pg.row.integerValue == indexPath.row + 1) {
            cell.playerGame = pg;
            [cell update];
        }
    }
    return cell;
}
-(BOOL)shouldAutorotate
{
    return NO;
}
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    EXTPlayerResultTableViewCell *cell = (EXTPlayerResultTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell toggleDisplay];
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"showScoreCard"] ){
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        EXTPlayerResultTableViewCell *cell = (EXTPlayerResultTableViewCell *)sender;
        EXTScoreCardViewController *vc = (EXTScoreCardViewController *)[segue destinationViewController];
        vc.playerGame = cell.playerGame;
    }
}

@end
