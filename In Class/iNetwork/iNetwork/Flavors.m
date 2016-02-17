//
//  Flavors.m
//  iNetwork
//
//  Created by Blake Oistad on 10/15/15.
//  Copyright © 2015 VizNetwork. All rights reserved.
//

#import "Flavors.h"

@implementation Flavors

- (id)initWithName:(NSString *)flavorName andImageName:(NSString *)imageName {
    self = [super init];
    if (self) {
        self.flavorName = flavorName;
        self.flavorImageFilename = imageName;
        
    }
    return self;
}


@end
