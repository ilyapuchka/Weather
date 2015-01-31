//
//  COOLForecastComposedDataSourceImpl.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLComposedDataSource.h"
#import "COOLForecastComposedDataSource.h"
#import "COOLForecastDataSourceFactory.h"

@interface COOLForecastComposedDataSourceImpl : COOLComposedDataSource <COOLForecastComposedDataSource>

@property (nonatomic, strong) id<COOLForecastDataSourceFactory> dataSourcesFactory;

@end
