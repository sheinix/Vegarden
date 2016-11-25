//
//  NSManagedObject+Duplicate.h
//
//  Copyright (c) 2014 Barry Allard
//
//  MIT license
//
// inspiration: https://stackoverflow.com/questions/2998613/how-do-i-copy-or-move-an-nsmanagedobject-from-one-context-to-another 

#import <CoreData/CoreData.h>

@interface NSManagedObject (Duplicate)
// shallow copy of MOC ASSOCIATED object, does not update relationships
- (instancetype)duplicateAssociated;

// shallow copy of MOC UNASSOCIATED object, does not update relationships
- (instancetype)duplicateUnassociated;

//Return a booleand indicating if the object has been deleted from the context
/*
 Returns YES if |managedObject| has been deleted from the Persistent Store,
 or NO if it has not.
 
 NO will be returned for NSManagedObject's who have been marked for deletion
 (e.g. their -isDeleted method returns YES), but have not yet been commited
 to the Persistent Store. YES will be returned only after a deleted
 NSManagedObject has been committed to the Persistent Store.
 
 Rarely, an exception will be thrown if Mac OS X 10.5 is used AND
 |managedObject| has zero properties defined. If all your NSManagedObject's
 in the data model have at least one property, this will not be an issue.
 
 Property == Attributes and Relationships
 
 Mac OS X 10.4 and earlier are not supported, and will throw an exception.
 */
- (BOOL)hasBeenDeleted;
@end

