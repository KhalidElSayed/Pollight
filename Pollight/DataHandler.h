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

@end

@interface DataHandler : NSObject

+ (instancetype)dataHandler;

-(void)fetchTodaysPoll;

@property (strong, nonatomic) Poll* todaysPoll;

-(void)addDelegate:(id<DataHandlerProtocol>)delegate;

@end
