//
//  SGJuneOperation.m
//  Operational
//
//  Created by mrJacob on 8/21/13.
//  Copyright (c) 2013 sushiGrass. All rights reserved.
//

#import "SGJuneOperation.h"

@implementation SGJuneOperation

-(void)main {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/688911/June.png"]];
    
    NSURLResponse *connectionResponse = nil;
    NSError *connectionError = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&connectionResponse error:&connectionError];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"JuneOperationDone" object:responseData];
}

@end
