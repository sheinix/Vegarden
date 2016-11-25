//
//  NSManagedObject+Duplicate.m
//
//  Copyright (c) 2014 Barry Allard
//
//  MIT license
//
// inspiration: https://stackoverflow.com/questions/2998613/how-do-i-copy-or-move-an-nsmanagedobject-from-one-context-to-another 

#import "NSManagedObject+Duplicate.h"

@implementation NSManagedObject (Duplicate)
- (void)duplicateToTarget:(NSManagedObject *)target
{
    NSEntityDescription *entityDescription = self.objectID.entity;
    NSArray *attributeKeys = entityDescription.attributesByName.allKeys;
    NSDictionary *attributeKeysAndValues = [self dictionaryWithValuesForKeys:attributeKeys];
    [target setValuesForKeysWithDictionary:attributeKeysAndValues];
}

- (instancetype)duplicateAssociated
{
    NSManagedObject *result = [NSEntityDescription
                               insertNewObjectForEntityForName:self.objectID.entity.name
                                        inManagedObjectContext:self.managedObjectContext];
    
    [self duplicateToTarget:result];
    return result;
}

- (instancetype)duplicateUnassociated
{
    NSManagedObject *result = [[NSManagedObject alloc]
                                               initWithEntity:self.entity
                               insertIntoManagedObjectContext:nil];
    [self duplicateToTarget:result];
    return result;
}

- (BOOL)hasBeenDeleted {
    
    return (self == [self.managedObjectContext existingObjectWithID:self.objectID error:NULL]);
}
//    NSParameterAssert(self);
//    NSManagedObjectContext *moc = [self managedObjectContext];
//    
//    // Check for Mac OS X 10.6+
//    if ([moc respondsToSelector:@selector(existingObjectWithID:error:)])  {
//        
//        NSManagedObjectID   *objectID           = [self objectID];
//        NSManagedObject     *managedObjectClone = [moc existingObjectWithID:objectID error:NULL];
//        
//        if (!managedObjectClone)
//            return YES;                 // Deleted.
//        else
//            return NO;                  // Not deleted.
//    }
//    
//    // Check for Mac OS X 10.5
//    else if ([moc respondsToSelector:@selector(countForFetchRequest:error:)]) {
//        
//        // 1) Per Apple, "may" be nil if |managedObject| deleted but not always.
//        if (![self managedObjectContext])
//            return YES;                 // Deleted.
//        
//        
//        // 2) Clone |managedObject|. All Properties will be un-faulted if
//        //    deleted. -objectWithID: always returns an object. Assumed to exist
//        //    in the Persistent Store. If it does not exist in the Persistent
//        //    Store, firing a fault on any of its Properties will throw an
//        //    exception (#3).
//        NSManagedObjectID *objectID             = [self objectID];
//        NSManagedObject   *managedObjectClone   = [moc objectWithID:objectID];
//        
//        
//        // 3) Fire fault for a single Property.
//        NSEntityDescription *entityDescription  = [managedObjectClone entity];
//        NSDictionary        *propertiesByName   = [entityDescription propertiesByName];
//        NSArray             *propertyNames      = [propertiesByName allKeys];
//        
//        NSAssert1([propertyNames count] != 0, @"Method cannot detect if |managedObject| has been deleted because it has zero Properties defined: %@", self);
//        
//        @try
//        {
//            // If the property throws an exception, |managedObject| was deleted.
//            (void)[managedObjectClone valueForKey:[propertyNames objectAtIndex:0]];
//            return NO;                  // Not deleted.
//        }
//        @catch (NSException *exception)
//        {
//            if ([[exception name] isEqualToString:NSObjectInaccessibleException])
//                return YES;             // Deleted.
//            else
//                [exception raise];      // Unknown exception thrown.
//        }
//    }
//    
//    // Mac OS X 10.4 or earlier is not supported.
//    else
//    {
//        NSAssert(0, @"Unsupported version of Mac OS X detected.");
//    }
//}

@end
