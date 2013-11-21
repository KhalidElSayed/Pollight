//
//  OldPollSlidingAnswerTableCell.m
//  Pollight
//
//  Created by amir hayek on 11/21/13.
//  Copyright (c) 2013 amir hayek. All rights reserved.
//

#import "OldPollSlidingAnswerTableCell.h"

@interface OldPollSlidingAnswerTableCell ()

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;


@end

@implementation OldPollSlidingAnswerTableCell

@synthesize panGestureRecognizer;
@synthesize panningView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)showVoteResults:(BOOL)animated
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    panningView.backgroundColor = [UIColor clearColor];
    _answerVotePercentageLabel.hidden = NO;
    _answerVoteView.hidden = NO;
    _answerVoteView.center = CGPointMake(-100, _answerVoteView.center.y);
    
    _answerVoteView.alpha = 0;
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationDelay:0.25];
    }
    
    //    _answerVoteView.center = CGPointMake(0, 0);
    _answerVoteView.alpha = _answer.percentageOfVotes.intValue / 100.0;
    
    if (_answerVoteView.alpha > 0.5) {
        _answerLabel.textColor = [UIColor whiteColor];
    }
    
    
    _answerVoteView.frame = CGRectOffset( _answerVoteView.frame,  _answer.percentageOfVotes.intValue * 2, 0 );
    
    if (animated) {
        [UIView commitAnimations];
    }
}

@end
