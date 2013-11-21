//
//  OldPollCell.h
//  Pollight
//
//  Created by amir hayek on 11/21/13.
//  Copyright (c) 2013 amir hayek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OldPollSlidingAnswerTableCell.h"
#import "OldPollQuesitonTableCell.h"
#import "DataHandler.h"

@interface OldPollCell : UICollectionViewCell <UITableViewDataSource, UITableViewDelegate,DataHandlerProtocol>

@property (assign, nonatomic) int dayOffset;

-(void)showVotes;
-(void)refreshPoll;

@end
