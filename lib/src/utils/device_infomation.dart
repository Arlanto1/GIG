import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInformation {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();


    try {
      // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      // log('Running on ${androidInfo.model}');  // e.g. "Moto G (4)"

      // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      // log('Running on ${iosInfo.utsname.machine}');  // e.g. "iPod7,1"

      // WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      // log('Running on ${webBrowserInfo.userAgent}');


      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          deviceData =
              _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
          log('-Android-deviceData-${deviceData.toString()}--');
          break;
        case TargetPlatform.iOS:
          deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
          log('-iOS-deviceData-${deviceData.toString()}--');
          break;
        case TargetPlatform.fuchsia:
          // TODO: Handle this case.
          break;
        case TargetPlatform.linux:
          // TODO: Handle this case.
          break;
        case TargetPlatform.macOS:
          // TODO: Handle this case.
          break;
        case TargetPlatform.windows:
          // TODO: Handle this case.
          break;
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'displaySizeInches':
          ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayWidthInches': build.displayMetrics.widthInches,
      'displayHeightPixels': build.displayMetrics.heightPx,
      'displayHeightInches': build.displayMetrics.heightInches,
      'displayXDpi': build.displayMetrics.xDpi,
      'displayYDpi': build.displayMetrics.yDpi,
      'serialNumber': build.serialNumber,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}
