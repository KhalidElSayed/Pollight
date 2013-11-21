//
//  Poll.h
//  Pollight
//
//  Created by amir hayek on 11/21/13.
//  Copyright (c) 2013 amir hayek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Poll : NSObject

@property (strong, nonatomic) NSString* questionString;
@property (strong, nonatomic) NSArray* answers;

@property (strong, nonatomic) NSNumber* numberOfVotesForPoll;

@property (strong, nonatomic) NSNumber* pollId;
@property (strong, nonatomic) NSNumber* pollDayId;

@end
