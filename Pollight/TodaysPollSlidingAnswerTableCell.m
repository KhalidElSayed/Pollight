//
//  SLPanningTableViewCell.m
//  Sparrowlike
//
//  Created by Jay Chae  on 7/26/13.
//
//

#import "TodaysPollSlidingAnswerTableCell.h"

@interface TodaysPollSlidingAnswerTableCell ()


@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@end


@implementation TodaysPollSlidingAnswerTableCell

@synthesize panGestureRecognizer;
@synthesize panningView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initAllSubviews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)initAllSubviews {
    [self initPanningView];
}


- (void)setDelegateForPanGesture:(id<UIGestureRecognizerDelegate>)delegate {
    panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    [panGestureRecognizer addTarget:delegate action:@selector(handleSparrowPan:)];
    [panGestureRecognizer setDelegate:delegate];
    [self addGestureRecognizer:panGestureRecognizer];
}

-(void)removeDelegateForPanGesture
{
    panGestureRecognizer = nil;
}

/*
 Subclass should override this contents on the panning
 */

- (void)initPanningView {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];

}

- (IBAction)voteClick:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(voted:)]) {
        [_delegate performSelector:@selector(voted:) withObject:_answer];
    }
}

-(void)showVoteResults:(BOOL)animated
{
    [self setNeedsDisplay];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    _answerWrapperView.backgroundColor = [UIColor clearColor];
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

    
    _answerVoteView.frame = CGRectOffset( _answerVoteView.frame,  _answer.percentageOfVotes.intValue * 2.5, 0 );
    
    if (animated) {
        [UIView commitAnimations];
    }
}

@end
