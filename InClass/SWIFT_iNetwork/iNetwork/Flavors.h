//
//  Flavors.h
//  iNetwork
//
//  Created by Blake Oistad on 10/15/15.
//  Copyright © 2015 VizNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flavors : NSObject

@property (nonatomic, strong) NSString *flavorName;
@property (nonatomic, strong) NSString *flavorImageFilename;

- (id) initWithName:(NSString *)flavorName andImageName:(NSString *)imageName;          //sets up custom init convenience method

@end
