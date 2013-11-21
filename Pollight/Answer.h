//
//  Answer.h
//  Pollight
//
//  Created by amir hayek on 11/21/13.
//  Copyright (c) 2013 amir hayek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Answer : NSObject

@property (strong, nonatomic) NSString* answerString;

@property (strong, nonatomic) NSNumber* numberOfVotes;
@property (strong, nonatomic) NSNumber* percentageOfVotes;

@property (strong, nonatomic) NSNumber* answerId;
@property (strong, nonatomic) NSNumber* parentPollId;

@end
