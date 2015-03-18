//
//  Item.h
//  hw6-ckl8
//
//  Created by rlam on 3/17/15.
//  Copyright (c) 2015 rlam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSManagedObject *location;
@property (nonatomic, retain) NSSet *tags;
@end

@interface Item (CoreDataGeneratedAccessors)

- (void)addTagsObject:(NSManagedObject *)value;
- (void)removeTagsObject:(NSManagedObject *)value;
- (void)addTags:(NSSet *)values;
- (void)removeTags:(NSSet *)values;

@end
