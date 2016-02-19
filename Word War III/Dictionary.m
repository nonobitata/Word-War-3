//
//  Dictionary.m
//  Word War III
//
//  Created by Outliers on 8/17/14.
//  Copyright (c) 2014 Outliers. All rights reserved.
//

#import "Dictionary.h"

@implementation Dictionary
@synthesize WordList;
@synthesize pathDictionary;
-(id)initWithPath:(NSString *) filepath{
    id newInstance = [super init];
    if (newInstance) {
        //Start reading the file
        NSString *path= [[NSBundle mainBundle] pathForResource:filepath ofType:@"txt" ];
        NSString *fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        // NSLog(@"abc %@",fileContents);
        
        if (fileContents == nil) {
            NSLog(@"fileContents failed.");
            return nil;
        }
        // separate into lines
        WordList = [fileContents componentsSeparatedByString:@","];
        /*   for (id line in WordList){
         NSLog(@"%@1", line);
         }*/
        
    }
    return newInstance;
}
- (NSString*) getAWordAtIndex:(int) index{
    return [WordList objectAtIndex:index];
}
@end
