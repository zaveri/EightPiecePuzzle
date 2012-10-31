//
//  MZSecondViewController.m
//  EightPiecePuzzle
//
//  Created by Muzzammil Zaveri on 10/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MZSecondViewController.h"
#import "MZScoreCell.h"
#import "Score.h"
#import "MZScore.h"

@interface MZSecondViewController ()

@end

@implementation MZSecondViewController

@synthesize tableView = _tableView;
@synthesize scores = _scores;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    float tableViewHeight = 480 - self.tabBarController.tabBar.frame.size.height;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320.0, tableViewHeight)];
    [self setTableView:tableView];
    [self.tableView setHidden:YES];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.hidden = NO;
    [self.view addSubview:tableView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self fetchScoresFromCoreData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)fetchScoresFromCoreData
{
    NSManagedObjectContext *managedObjectContext = [MZAppDelegateInstance managedObjectContext];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Score"];
        NSError *error;
        NSArray *fetched;
        
        NSSortDescriptor *nameSort = [[NSSortDescriptor alloc] initWithKey:@"totalScore" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
        NSArray *sorters = [NSArray arrayWithObject:nameSort];
        
        [fetchRequest setEntity:[NSEntityDescription entityForName:@"Score" inManagedObjectContext:managedObjectContext]];
        [fetchRequest setSortDescriptors:sorters];
        
        fetched = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        NSMutableArray *scores = [[NSMutableArray alloc] init];
        [self setScores:scores];
        
        for (Score *score in fetched) {
            MZScore *rerievedScore = [[MZScore alloc] initFromScore:score];
            [self.scores addObject:rerievedScore];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.scores count] > 0) {
                [self.tableView reloadData];
                [self.tableView setHidden:NO];
            } else {
                [self.tableView reloadData];
            }
        });
    });
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    int rows = self.scores.count;
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ScoreCell";
    MZScoreCell *cell = (MZScoreCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MZScoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.textLabel.text = [[[self.scores objectAtIndex:indexPath.row] fullName] capitalizedString];
    cell.badgeString = [NSString stringWithFormat:@"%d", [[[self.scores objectAtIndex:indexPath.row] totalScore] intValue]];
    //    cell.badgeColor = [UIColor colorWithRed:0.17 green:0.52 blue:0.219 alpha:1.000];
    cell.badge.radius = 9;
    
    return cell;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
