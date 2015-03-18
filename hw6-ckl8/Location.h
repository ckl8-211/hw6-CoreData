//
//  Location.h
//  hw6-ckl8
//
//  Created by rlam on 3/17/15.
//  Copyright (c) 2015 rlam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSString * contents;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, retain) Item *item;

@end
