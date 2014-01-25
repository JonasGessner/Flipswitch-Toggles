//
//  SafeModeFlipswitchSwitch.x
//  Safe Mode Flipswitch
//
//  Created by Jonas Gessner on 24.01.2014.
//  Copyright (c) 2014 Jonas Gessner. All rights reserved.
//

#import "SafeModeFlipswitchSwitch.h"

@implementation SafeModeFlipswitchSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier {
	return FSSwitchStateIndeterminate;
}

- (void)applyActionForSwitchIdentifier:(NSString *)switchIdentifier {
    NSObject *object = [[NSObject alloc] init];
    [object release];
    [object release];
}

@end