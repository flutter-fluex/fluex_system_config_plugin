import 'dart:io';

import 'package:fluex/fluex.dart';
import 'package:device_info_plus/device_info_plus.dart';

abstract class SystemConfig {}

class AndroidSystemConfig implements SystemConfig {
  final String? androidId;
  final String? model;
  final String? brand;
  final String? version;
  final int? versionInt;

  const AndroidSystemConfig(
      this.androidId,
      this.model,
      this.brand,
      this.version,
      this.versionInt);
}

class IOSSystemConfig implements SystemConfig {
  final String? name;
  final String? model;
  final String? systemName;
  final String? systemVersion;
  final String? identifierForVendor;

  const IOSSystemConfig(
      this.name,
      this.model,
      this.systemName,
      this.systemVersion,
      this.identifierForVendor);
}

class UnknownSystemConfig implements SystemConfig {
  const UnknownSystemConfig();
}


class FluexSystemConfigPlugin implements FuturePlugin<SystemConfig> {
  @override
  Future<SystemConfig> run() {
    final DeviceInfoPlugin plugin = DeviceInfoPlugin();
    Future<SystemConfig> config;
    if (Platform.isAndroid) {
      config = _loadAndroidSystemConfig(plugin);
    } else if (Platform.isIOS) {
      config = _loadIOSSystemConfig(plugin);
    } else {
      config = _loadUnknownSystemConfig(plugin);
    }
    return config;
  }

  Future<AndroidSystemConfig> _loadAndroidSystemConfig(DeviceInfoPlugin plugin) =>
      plugin.androidInfo.then((deviceInfo) => AndroidSystemConfig(
          deviceInfo.androidId,
          deviceInfo.model,
          deviceInfo.brand,
          deviceInfo.version.release,
          deviceInfo.version.sdkInt
      ));

  Future<IOSSystemConfig> _loadIOSSystemConfig(DeviceInfoPlugin plugin) =>
      plugin.iosInfo.then((deviceInfo) => IOSSystemConfig(
          deviceInfo.name,
          deviceInfo.model,
          deviceInfo.systemName,
          deviceInfo.systemVersion,
          deviceInfo.identifierForVendor
      ));

  Future<UnknownSystemConfig> _loadUnknownSystemConfig(DeviceInfoPlugin plugin) =>
      Future.value(const UnknownSystemConfig());
}

extension SystemConfigExtension on Fluex {
  SystemConfig get system => getExtensionNonNull<FluexSystemConfigPlugin>();
}
