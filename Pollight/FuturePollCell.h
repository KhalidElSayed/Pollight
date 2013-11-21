//
//  FuturePollCell.h
//  Pollight
//
//  Created by amir hayek on 11/21/13.
//  Copyright (c) 2013 amir hayek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataHandler.h"

@interface FuturePollCell : UICollectionViewCell <UITableViewDataSource, UITableViewDelegate,DataHandlerProtocol>

@property (assign, nonatomic) int dayOffset;

-(void)refreshPolls;

@end
