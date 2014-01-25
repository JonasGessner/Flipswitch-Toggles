#import <Foundation/Foundation.h>

#include "xpc/xpc.h"

int main(int argc, char **argv, char **envp) {
    @autoreleasepool {
        xpc_connection_t connection = xpc_connection_create_mach_service("de.j-gessner.syslogflipswitchxpc", NULL, XPC_CONNECTION_MACH_SERVICE_LISTENER);
        
        if (connection) {
            xpc_connection_set_event_handler(connection, ^(xpc_object_t object) {
                xpc_type_t type = xpc_get_type(object);
                
                if (type == XPC_TYPE_CONNECTION) {
                    xpc_connection_set_event_handler(object, ^(xpc_object_t some_object) {
                        const char *syslog = xpc_dictionary_get_string(some_object, "syslog");
                        if (strcmp(syslog, "On") == 0) {
                            [[NSFileManager defaultManager] removeItemAtPath:@"/var/log/de.j-gessner.syslogflipswitch.syslogoff" error:nil];
                            system("rm /var/log/syslog; killall -9 syslogd");
                        }
                        else if (strcmp(syslog, "Off") == 0) {
                            [[NSFileManager defaultManager] createFileAtPath:@"/var/log/de.j-gessner.syslogflipswitch.syslogoff" contents:nil attributes:nil];
                            system("rm /var/log/syslog; mknod /var/log/syslog c 3 2");
                        }
                        else {
                            NSLog(@"Unknown syslog state %s", syslog);
                        }
                    });
                    
                    xpc_connection_resume(object);
                }
            });
            
            xpc_connection_resume(connection);
            
            [[NSRunLoop currentRunLoop] run];
        }
        
        return 0;
    }
}
