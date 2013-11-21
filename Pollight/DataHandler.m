//
//  PollDBHandler.m
//  Pollight
//
//  Created by amir hayek on 11/21/13.
//  Copyright (c) 2013 amir hayek. All rights reserved.
//

#import "DataHandler.h"

#define kGetTodayPollsUrl [NSURL URLWithString:@"http://merushatim.co.il/pollight/getTodaysPoll"]
#define kGetDayByOffsetPollsUrl [NSURL URLWithString:@"http://merushatim.co.il/pollight/getPastPollsPerDay/"]
#define kGetFutureDayByOffsetUrl [NSURL URLWithString:@"http://merushatim.co.il/pollight/getCandidatePollsPerDay/"]

@interface DataHandler ()

@property (strong,nonatomic) NSMutableArray* delegates;
@property (strong, nonatomic) NSMutableArray* futurePollsArray; //at single day offset

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

-(void)fetchPastPoll:(int)dayOffset
{
    NSURL* fetchPastPollUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%d",kGetDayByOffsetPollsUrl,dayOffset]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:fetchPastPollUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
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
         
         Poll* poll = [self parsePollFromJson:json];
         
         for (id<DataHandlerProtocol> delegate in _delegates) {
             if ([delegate respondsToSelector:@selector(gotPoll:atDayOffset:)]) {
                 [delegate gotPoll:poll atDayOffset:dayOffset];
             }
         }
     }];
}

-(void)fetchFuturePoll:(int)dayOffset
{
    NSURL* fetchFuturePollUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%d",kGetFutureDayByOffsetUrl,dayOffset]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:fetchFuturePollUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData *data, NSError *error)
     {
         NSDictionary* json = [NSJSONSerialization
                               JSONObjectWithData:data
                               options:kNilOptions
                               error:&error];
         
         _futurePollsArray = [NSMutableArray new];
         for (NSDictionary* jsonDict in json) {
             Poll* poll = [self parsePollFromJson:jsonDict];
             [_futurePollsArray addObject:poll];
         }
         
         
         for (id<DataHandlerProtocol> delegate in _delegates) {
             if ([delegate respondsToSelector:@selector(gotPolls:atDayOffset:)]) {
                 [delegate gotPolls:_futurePollsArray atDayOffset:dayOffset];
             }
         }
     }];

}

@end
