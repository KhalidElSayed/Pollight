//
//  PollDBHandler.m
//  Pollight
//
//  Created by amir hayek on 11/21/13.
//  Copyright (c) 2013 amir hayek. All rights reserved.
//

#import "DataHandler.h"

#define kGetTodayPollsUrl [NSURL URLWithString:@"http://merushatim.co.il/pollight/getTodaysPoll"]

@interface DataHandler ()

@property (strong,nonatomic) NSMutableArray* delegates;


@end

@implementation DataHandler

+ (instancetype)dataHandler
{
	static DataHandler *sharedInstance = nil;
	if (sharedInstance == nil)
	{
		sharedInstance = [[self alloc] init];
	}
	return sharedInstance;
}

-(void)addDelegate:(id<DataHandlerProtocol>)delegate
{
    if (_delegates == nil) {
        _delegates = [NSMutableArray array];
    }
    [_delegates addObject:delegate];
}

-(void)fetchTodaysPoll
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:kGetTodayPollsUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData *data, NSError *error)
     {
         NSDictionary* json = [NSJSONSerialization
                               JSONObjectWithData:data
                               options:kNilOptions
                               error:&error];

         NSLog(@"%@",json);
         
         _todaysPoll = [self parsePollFromJson:json];
         
         for (id<DataHandlerProtocol> delegate in _delegates) {
             if ([delegate respondsToSelector:@selector(gotTodaysPoll)]) {
                 [delegate gotTodaysPoll];
             }
         }
     }];
}

-(Poll*)parsePollFromJson:(NSDictionary*)json
{
    Poll* parsedPoll = [Poll new];
    parsedPoll.questionString = [json objectForKey:@"title"];
    
    NSMutableArray* parsedAnswers = [NSMutableArray new];
    for (NSDictionary* answerDict in [json objectForKey:@"answers"]) {
        Answer* answer = [Answer new];
        answer.answerString = [answerDict objectForKey:@"title"];
        answer.percentageOfVotes = [answerDict objectForKey:@"percentage"];
        [parsedAnswers addObject:answer];
    }
    
    parsedPoll.answers = parsedAnswers;
    
    return parsedPoll;
}

//
//-(Poll*)todaysPoll
//{
//    _todaysPoll = [[Poll alloc] init];
//    _todaysPoll.questionString = @"this is a question?";
//    Answer* answer1 = [Answer new];
//    answer1.percentageOfVotes = @10;
//    answer1.answerString = @"answer string 1";
//    Answer* answer2 = [Answer new];
//    answer2.percentageOfVotes = @20;
//    answer2.answerString = @"answer string 2";
//    Answer* answer3 = [Answer new];
//    answer3.percentageOfVotes = @55;
//    answer3.answerString = @"answer string 3";
//    Answer* answer4 = [Answer new];
//    answer4.percentageOfVotes = @15;
//    answer4.answerString = @"answer string 4";
//    _todaysPoll.answers = [NSArray arrayWithObjects:answer1,answer2,answer3,answer4, nil];
//    
//    return _todaysPoll;
//}

@end
