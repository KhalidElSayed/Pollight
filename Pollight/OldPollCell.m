//
//  OldPollCell.m
//  Pollight
//
//  Created by amir hayek on 11/21/13.
//  Copyright (c) 2013 amir hayek. All rights reserved.
//

#import "OldPollCell.h"
#import "SLPanningTableView.h"

@interface OldPollCell ()

@property (weak, nonatomic) IBOutlet UITableView *pollTable;
@property (strong, nonatomic) DataHandler* dataHandler;
@property (strong, nonatomic) Poll* poll;

@property (assign, nonatomic) BOOL showResults;

@end

@implementation OldPollCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)prepareForReuse
{
    //_poll = nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataHandler == nil) {
        _dataHandler = [DataHandler dataHandler];
        [_dataHandler addDelegate:self];
    }
    if (_poll == nil) {
        [_dataHandler fetchPastPoll:_dayOffset];
    }
    
    return _poll.answers.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        OldPollQuesitonTableCell* cell = [tableView dequeueReusableCellWithIdentifier:@"pollQuestionTableCell"];
        [cell.questionLabel setText:_poll.questionString];
        [cell.dateLabel setText:[NSString stringWithFormat:@"%d/11/2013",22+_dayOffset]];
        return cell;
    }
    if (indexPath.row > 0) {
        OldPollSlidingAnswerTableCell* cell = [tableView dequeueReusableCellWithIdentifier:@"pollAnswerTableCell"];
        Answer* answer = ((Answer*)_poll.answers[indexPath.row-1]);
        [cell.answerLabel setText:answer.answerString];
        [cell.answerNumberLabel setText:[NSString stringWithFormat:@"%d",indexPath.row]];
        [cell setAnswer:answer];
        [cell.answerVotePercentageLabel setText:[NSString stringWithFormat:@"%@%%",answer.percentageOfVotes]];
        
        //if (_showResults) {
            [cell showVoteResults:YES];
        //}
        
        return cell;
    }
    return nil;
}

-(void)showVotes
{
    _showResults = YES;
    [_pollTable reloadData];
}

-(void)gotPoll:(Poll*)poll atDayOffset:(int)offset
{
    _poll = poll;
    //[self showVotes];
}

-(void)refreshPoll
{
    _poll = nil;
    [_pollTable reloadData];
}
@end
