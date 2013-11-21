//
//  PollDBHandler.h
//  Pollight
//
//  Created by amir hayek on 11/21/13.
//  Copyright (c) 2013 amir hayek. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Poll.h"
#import "Answer.h"

@protocol DataHandlerProtocol <NSObject>

@optional

-(void)gotTodaysPoll;
-(void)gotPoll:(Poll*)poll atDayOffset:(int)offset;
-(void)gotPolls:(NSArray*)polls atDayOffset:(int)offset;

@end

@interface DataHandler : NSObject

+ (instancetype)dataHandler;

-(void)fetchTodaysPoll;
-(void)fetchPastPoll:(int)dayOffset;
-(void)fetchFuturePoll:(int)dayOffset;

@property (strong, nonatomic) Poll* todaysPoll;

-(void)addDelegate:(id<DataHandlerProtocol>)delegate;

@end
