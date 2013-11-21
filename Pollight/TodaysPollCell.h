//
//  TodaysPollCell.h
//  Pollight
//
//  Created by amir hayek on 11/21/13.
//  Copyright (c) 2013 amir hayek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TodaysPollSlidingAnswerTableCell.h"
#import "TodaysPollQuesitonTableCell.h"
#import "DataHandler.h"

@interface TodaysPollCell : UICollectionViewCell <UITableViewDataSource, UITableViewDelegate, TodaysPollSlidingAnswerTableCellProtocol,DataHandlerProtocol>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
