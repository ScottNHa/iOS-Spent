//
//  SPCategory.m
//  Spent
//
//  Created by Scott Ha on 3/13/16.
//  Copyright © 2016 HappyViet. All rights reserved.
//

#import "SPCategory.h"
#import "SPTransaction.h"

@implementation SPCategory

// Insert code here to add functionality to your managed object subclass

+ (void)checkAndCreateBasicEntities{
    NSArray *categories = [SPCategory MR_findAll];
    
    if(!(categories.count >3)){
	   SPCategory *newCategory1 = [SPCategory MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
	   [newCategory1 setId:[NSNumber numberWithInt:1]];
	   [newCategory1 setName:@"Food"];
	   [newCategory1 setColor:@"#FF2C76"];
	   [newCategory1 setTotal:[NSNumber numberWithDouble:0]];
	   
	   [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
	   
	   SPCategory *newCategory2 = [SPCategory MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
	   [newCategory2 setId:[NSNumber numberWithInt:2]];
	   [newCategory2 setName:@"Entertainment"];
	   [newCategory2 setColor:@"#3A4BFF"];
	   [newCategory2 setTotal:[NSNumber numberWithDouble:0]];
	   
	   [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
							 
	   SPCategory *newCategory3 = [SPCategory MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
	   [newCategory3 setId:[NSNumber numberWithInt:3]];
	   [newCategory3 setName:@"Essentials"];
	   [newCategory3 setColor:@"#35FF84"];
	   [newCategory3 setTotal:[NSNumber numberWithDouble:0]];
	   
	   [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
	   
	   SPCategory *newCategory4 = [SPCategory MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
	   [newCategory4 setId:[NSNumber numberWithInt:4]];
	   [newCategory4 setName:@"Other"];
	   [newCategory4 setColor:@"#FFBA53"];
	   [newCategory4 setTotal:[NSNumber numberWithDouble:0]];
	   
	   [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    }
}

+ (double)returnTotal{
    NSArray *categories = [SPCategory MR_findAll];
	
	/*
	NSString *input = @"Other";
	SPCategory *pip = [SPCategory MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"name == %@", input]];
	NSLog(@"More testing with predicates.\nName: %@", pip.name);
	 */
	
    double total = 0;
    for ( SPCategory *cat in categories){
	   total += [[cat total]doubleValue];
    }
    
    return total;
}

+ (double)returnCategoryTotal:(int)category{
    NSArray *categories = [SPCategory MR_findAll];
    SPCategory *cat = categories[category];
    
    return [[cat total]doubleValue];
}

+ (NSString *)returnCategoryName:(int)category{
    NSArray *categories = [SPCategory MR_findAll];
    SPCategory *cat = categories[category];
    
    return [cat name];
}

+ (UIColor *)returnCategoryColor:(int)category{
    NSArray *categories = [SPCategory MR_findAll];
    SPCategory *cat = categories[category];
    
    // Taken from http://stackoverflow.com/questions/1560081/how-can-i-create-a-uicolor-from-a-hex-string
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:[cat color]];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

+ (int) numberOfTotalCategories{
	NSArray *categories = [SPCategory MR_findAll];
	return (int)categories.count;
}

+(double)returnCategoryTotalDate:(int)category daysBack:(int)days{
	NSArray *categories = [SPCategory MR_findAll];
	double totalForDate = 0;
	
	NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
	NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
	components.day -= days;
	
	NSArray *tran = [SPTransaction MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"category == %@", categories[category]]];
	NSDate *date = [calendar dateFromComponents:components];
	for ( SPTransaction *train in tran){
		if([train.dateSpent compare:date] == NSOrderedDescending || [train.dateSpent compare:date] == NSOrderedSame){
			totalForDate += [train.amountSpent doubleValue];
		}
	}
	
	return totalForDate;
}

@end
