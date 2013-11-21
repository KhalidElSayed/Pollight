//
//  ViewController.m
//  Pollight
//
//  Created by amir hayek on 11/21/13.
//  Copyright (c) 2013 amir hayek. All rights reserved.
//

#import "PollightViewController.h"
#import "TodaysPollCell.h"
#import "OldPollCell.h"
#import "FuturePollCell.h"
#import "DataHandler.h"

@interface PollightViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) DataHandler* dataHandler;

@end

@implementation PollightViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _dataHandler = [DataHandler dataHandler];
    [_dataHandler fetchTodaysPoll];
//    [self.collectionView registerClass:[TodaysPollCell class] forCellWithReuseIdentifier:@"pollCell"];

}

-(void)viewWillAppear:(BOOL)animated{
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collection data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 14;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 7) {
        OldPollCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"oldPollCell" forIndexPath:indexPath];
        [cell setDayOffset: indexPath.row - 7];
        [cell refreshPoll];
        return cell;
    }
    if (indexPath.row == 7) {
        TodaysPollCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pollCell" forIndexPath:indexPath];
        [cell setCollectionView:_collectionView];
        return cell;
    }
    if (indexPath.row > 7) {
        FuturePollCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"futurePollCell" forIndexPath:indexPath];
        [cell setDayOffset: indexPath.row - 7];
        [cell refreshPolls];
        return cell;
    }

    return nil;
}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didEndDisplayingCell");
    
    NSArray* visibleItems = [_collectionView indexPathsForVisibleItems];
    NSIndexPath* path = visibleItems[0];
    if([_collectionView cellForItemAtIndexPath:path].class == [OldPollCell class])
    {
        OldPollCell* oldCell = (OldPollCell*)[_collectionView cellForItemAtIndexPath:path];
        
        [oldCell showVotes];
    }
}

@end
