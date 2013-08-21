//
//  SGOperation.h
//  Operational
//
//  Created by mrJacob on 8/21/13.
//  Copyright (c) 2013 sushiGrass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGOperationSingleton : NSObject

typedef void(^performBlock)();

+(instancetype)sharedOperation;

-(void)performBlockOnMainQueue:(void (^)())performBlock;
-(void)performBlockOnPrivateQueue:(void (^)())performBlock;
-(void)performJuneOperationOnMainThreadWithCompletionBlock: (void (^)(NSData *completionData))operationBlock;
-(void)performJuneOperationOnPrivateThreadWithCompletionBlock: (void (^)(NSData *completionData))operationBlock;

@end
