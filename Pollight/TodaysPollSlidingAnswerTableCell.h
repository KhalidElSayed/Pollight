//
//  SLPanningTableViewCell.h
//  Sparrowlike
//
//  Created by Jay Chae  on 7/26/13.
//
//

#import <UIKit/UIKit.h>

#import "Answer.h"

@protocol TodaysPollSlidingAnswerTableCellProtocol <NSObject>

-(void)voted:(Answer*)answer;

@end

@interface TodaysPollSlidingAnswerTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *answerWrapperView;
@property (weak, nonatomic) IBOutlet UILabel *answerNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerVotePercentageLabel;
@property (weak, nonatomic) IBOutlet UIView *answerVoteView;

@property (strong, nonatomic)  Answer* answer;

@property (assign, nonatomic) id<TodaysPollSlidingAnswerTableCellProtocol> delegate;

@property (nonatomic, strong) IBOutlet UIView *panningView;

- (void)setDelegateForPanGesture:(id<UIGestureRecognizerDelegate>)delegate;
- (void)initPanningView;
-(void)showVoteResults:(BOOL)animated;

@end
