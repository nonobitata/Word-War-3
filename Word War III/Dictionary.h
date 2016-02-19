//
//  Dictionary.h
//  Word War III
//
//  Created by Outliers on 8/17/14.
//  Copyright (c) 2014 Outliers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dictionary : NSObject
@property NSString *pathDictionary;
@property NSArray *WordList;
-(id)initWithPath:(NSString *) filepath;
- (NSString*) getAWordAtIndex:(int) index;
@end