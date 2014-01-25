//
//  SyslogFlipswitchSwitch.x
//  Syslog Flipswitch
//
//  Created by Jonas Gessner on 24.01.2014.
//  Copyright (c) 2014 Jonas Gessner. All rights reserved.
//

#import "SyslogFlipswitchSwitch.h"

#include "syslogflipswitchserver/xpc/xpc.h"

NS_INLINE BOOL syslogIsOn(void) {
    BOOL offFileExists = [[NSFileManager defaultManager] fileExistsAtPath:@"/var/log/de.j-gessner.syslogflipswitch.syslogoff"];
    
    if (offFileExists) {
        return NO;
    }
    else {
        return YES;
    }
}

@implementation SyslogFlipswitchSwitch {
    BOOL _on;
}

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier {
	return (_on ? FSSwitchStateOn : FSSwitchStateOff);
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier {
    if (newState == FSSwitchStateOn) {
        xpc_connection_t connection = xpc_connection_create_mach_service("de.j-gessner.syslogflipswitchxpc", NULL, 0);
        
        xpc_connection_set_event_handler(connection, ^(xpc_object_t some_object) { });
        
        xpc_connection_resume(connection);
        
        xpc_object_t object = xpc_dictionary_create(NULL, NULL, 0);
        
        xpc_dictionary_set_string(object, "syslog", "On");
        
        xpc_connection_send_message(connection, object);
        
        _on = YES;
    }
    else if (newState == FSSwitchStateOff) {
        xpc_connection_t connection = xpc_connection_create_mach_service("de.j-gessner.syslogflipswitchxpc", NULL, 0);
        
        xpc_connection_set_event_handler(connection, ^(xpc_object_t some_object) { });
        
        xpc_connection_resume(connection);
        
        xpc_object_t object = xpc_dictionary_create(NULL, NULL, 0);
        
        xpc_dictionary_set_string(object, "syslog", "Off");
        
        xpc_connection_send_message(connection, object);
        
        _on = NO;
    }
}

- (void)switchWasRegisteredForIdentifier:(NSString *)switchIdentifier {
    _on = syslogIsOn();
}

@end