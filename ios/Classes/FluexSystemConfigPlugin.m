#import "FluexSystemConfigPlugin.h"
#if __has_include(<fluex_system_config_plugin/fluex_system_config_plugin-Swift.h>)
#import <fluex_system_config_plugin/fluex_system_config_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fluex_system_config_plugin-Swift.h"
#endif

@implementation FluexSystemConfigPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFluexSystemConfigPlugin registerWithRegistrar:registrar];
}
@end
