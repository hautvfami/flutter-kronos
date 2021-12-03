#import "FlutterKronosPlugin.h"
#if __has_include(<flutter_kronos/flutter_kronos-Swift.h>)
#import <flutter_kronos/flutter_kronos-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_kronos-Swift.h"
#endif

@implementation FlutterKronosPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterKronosPlugin registerWithRegistrar:registrar];
}
@end
