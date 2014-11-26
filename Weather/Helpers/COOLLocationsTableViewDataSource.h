//
//  COOLLocationsTableViewDataSource.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

@import UIKit;
#import "COOLLocationsSelection.h"

@interface COOLLocationsTableViewDataSource : NSObject <UITableViewDataSource, UITableViewDelegate, COOLLocationsSelection>

@property (nonatomic, weak) IBOutlet id<COOLLocationsSelectionOutput> output;

@end
