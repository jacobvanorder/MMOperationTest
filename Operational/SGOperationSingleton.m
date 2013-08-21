//
//  SGOperation.m
//  Operational
//
//  Created by mrJacob on 8/21/13.
//  Copyright (c) 2013 sushiGrass. All rights reserved.
//

#import "SGOperationSingleton.h"

#import "SGJuneOperation.h"

@interface SGOperationSingleton ()

@property (nonatomic, strong) NSOperationQueue *privateQueue;
@property (nonatomic, strong) void (^operationBlock)(NSData *completionData);

@end

@implementation SGOperationSingleton

+(instancetype)sharedOperation {
    static SGOperationSingleton *sharedOperation;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedOperation = [SGOperationSingleton new];
        sharedOperation.privateQueue = [NSOperationQueue new];
    });
    return sharedOperation;
}

-(void)performBlockOnMainQueue:(void (^)())performBlock {
    [[NSOperationQueue mainQueue] addOperationWithBlock:performBlock];
}

-(void)performBlockOnPrivateQueue:(void (^)())performBlock {
    [self.privateQueue addOperationWithBlock:performBlock];
}

-(void)performJuneOperationOnMainThreadWithCompletionBlock:(void (^)(NSData *))operationBlock {
    self.operationBlock = operationBlock;
    SGJuneOperation *juneOperation = [SGJuneOperation new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(juneDataCameBack:) name:@"JuneOperationDone" object:nil];
    [[NSOperationQueue mainQueue] addOperation:juneOperation];
}

-(void)performJuneOperationOnPrivateThreadWithCompletionBlock:(void (^)(NSData *))operationBlock {
    self.operationBlock = operationBlock;
    SGJuneOperation *juneOperation = [SGJuneOperation new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(juneDataCameBack:) name:@"JuneOperationDone" object:nil];
    [self.privateQueue addOperation:juneOperation];
}

-(void)juneDataCameBack:(NSNotification *)note {
    if (self.operationBlock) {
        self.operationBlock(note.object);
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"JuneOperationDone" object:nil];
}

@end
