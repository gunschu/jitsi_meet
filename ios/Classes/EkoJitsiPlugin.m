#import "EkoJitsiPlugin.h"
#if __has_include(<eko_jitsi/eko_jitsi-Swift.h>)
#import <eko_jitsi/eko_jitsi-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "eko_jitsi-Swift.h"
#endif

@implementation EkoJitsiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEkoJitsiPlugin registerWithRegistrar:registrar];
}
@end
