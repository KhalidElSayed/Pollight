//
//  FuturePollCell.m
//  Pollight
//
//  Created by amir hayek on 11/21/13.
//  Copyright (c) 2013 amir hayek. All rights reserved.
//

#import "FuturePollCell.h"
#import "FuturePollTableCell.h"

@interface FuturePollCell ()

@property (strong, nonatomic) DataHandler* dataHandler;
@property (strong, nonatomic) NSArray* polls;
@property (weak, nonatomic) IBOutlet UITableView *pollsTableView;


@end

@implementation FuturePollCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataHandler == nil) {
        _dataHandler = [DataHandler dataHandler];
        [_dataHandler addDelegate:self];
    }
    
    if (_polls == nil) {
        [_dataHandler fetchFuturePoll:_dayOffset];
    }
    
    return _polls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FuturePollTableCell* cell = (FuturePollTableCell*)[tableView dequeueReusableCellWithIdentifier:@"pollCell"];
    
    Poll* poll = [_polls objectAtIndex:indexPath.row];
    
    [cell.quetionLabel setText:poll.questionString];
    Answer* answer1 = poll.answers[0];
    [cell.answer1 setText:answer1.answerString];
    Answer* answer2 = poll.answers[1];
    [cell.answer2 setText:answer2.answerString];
    if (poll.answers.count > 2) {
        Answer* answer3 = poll.answers[2];
        [cell.answer3 setText:answer3.answerString];
        if (poll.answers.count > 3) {
            Answer* answer4 = poll.answers[3];
            [cell.answer4 setText:answer4.answerString];
        }
    }

    return cell;
}

-(void)refreshPolls
{
    _polls = nil;
    [_pollsTableView reloadData];
}

-(void)gotPolls:(NSArray *)polls atDayOffset:(int)offset
{
    if (_polls == nil) {
        _polls = polls;
        [_pollsTableView reloadData];
    }
}

@end
