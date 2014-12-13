//
//  COOLLocationsDataSourceImpl.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLAPIClientDataSource.h"
#import "COOLLocationsDataSource.h"
#import "COOLLocationsSearchAPIResponse.h"

@interface COOLLocationsDataSourceImpl : COOLAPIClientDataSource <COOLLocationsDataSource>

@property (nonatomic, strong) COOLLocationsSearchAPIResponse *response;

@end
