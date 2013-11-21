//
//  OldPollSlidingAnswerTableCell.h
//  Pollight
//
//  Created by amir hayek on 11/21/13.
//  Copyright (c) 2013 amir hayek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Answer.h"

@interface OldPollSlidingAnswerTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *answerNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerVotePercentageLabel;
@property (weak, nonatomic) IBOutlet UIView *answerVoteView;

@property (strong, nonatomic)  Answer* answer;

@property (nonatomic, strong) IBOutlet UIView *panningView;

-(void)showVoteResults:(BOOL)animated;

@end
