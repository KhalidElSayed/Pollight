//
//  TodaysPollCell.m
//  Pollight
//
//  Created by amir hayek on 11/21/13.
//  Copyright (c) 2013 amir hayek. All rights reserved.
//

#import "TodaysPollCell.h"
#import "SLPanningTableView.h"

@interface TodaysPollCell ()

@property (weak, nonatomic) IBOutlet SLPanningTableView *pollTable;
@property (strong, nonatomic) DataHandler* dataHandler;
@property (strong, nonatomic) Poll* todaysPoll;

@property (assign, nonatomic) BOOL showResults;

@end

@implementation TodaysPollCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _dataHandler = [DataHandler dataHandler];
    [_dataHandler addDelegate:self];
    _todaysPoll = _dataHandler.todaysPoll;
    
    return _todaysPoll.answers.count + 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TodaysPollQuesitonTableCell* cell = [tableView dequeueReusableCellWithIdentifier:@"pollQuestionTableCell"];
        [cell.questionLabel setText:_todaysPoll.questionString];
        return cell;
    }
    if (indexPath.row > 0) {
        TodaysPollSlidingAnswerTableCell* cell = [tableView dequeueReusableCellWithIdentifier:@"pollAnswerTableCell"];
        Answer* answer = ((Answer*)_todaysPoll.answers[indexPath.row-1]);
        [cell.answerLabel setText:answer.answerString];
        [cell.answerNumberLabel setText:[NSString stringWithFormat:@"%d",indexPath.row]];
        [cell setAnswer:answer];
        [cell.answerVotePercentageLabel setText:[NSString stringWithFormat:@"%@%%",answer.percentageOfVotes]];
        [cell setDelegate:self];
        if (_showResults) {
            [cell showVoteResults:YES];
        }
        [cell setDelegateForPanGesture:_pollTable];
        return cell;
    }
    return nil;
}

-(void)voted:(Answer *)answer
{
    [_pollTable setSlidingDisabled:YES];
    _showResults = YES;
    [_pollTable reloadData];
    [_collectionView setScrollEnabled:YES];
}

-(void)gotTodaysPoll
{
    _todaysPoll = _dataHandler.todaysPoll;
    [_pollTable reloadData];
}



@end
