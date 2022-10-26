import 'dart:io' as io;
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;

class WebViewHelper {
  static List<String> get desktopBrowserAvailablePath {
    if (io.Platform.isWindows) {
      return windowBrowserAvailablePath;
    } else if (io.Platform.isMacOS) {
      return macosBrowserAvailablePath;
    } else if (io.Platform.isLinux) {
      return linuxBrowserAvailablePath;
    }
    return [];
  }

  static List<String> get windowBrowserAvailablePath => [
        "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe",
        "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe",
        "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe",
        "C:\\Program Files\\Microsoft\\Edge\\Application\\msedge.exe",
        "C:\\Program Files\\Mozilla Firefox\\firefox.exe",
        io.Directory("chromium").absolute.path,
      ];

  static List<String> get macosBrowserAvailablePath => [
        "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome",
        "/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary",
        "/Applications/Microsoft\ Edge\ Canary.app/Contents/MacOS/Microsoft\ Edge\ Canary",
        "/Applications/Chromium.app/Contents/MacOS/Chromium",
        "/Applications/Firefox.app/Contents/MacOS/firefox",
        "/Applications/Firefox.app/Contents/MacOS/firefox-bin",
        io.Directory("chromium").absolute.path,
      ];

  static List<String> get linuxBrowserAvailablePath =>
      ["/usr/bin/google-chrome"];

  static bool get isChromeAvailable {
    List<String> paths = desktopBrowserAvailablePath;

    for (var path in paths) {
      bool isExist = io.File(path).existsSync();
      if (isExist) {
        return true;
      }
    }

    return false;
  }

  static String? executablePath() {
    var paths = desktopBrowserAvailablePath;
    if (paths.isNotEmpty) {
      for (var path in paths) {
        if (io.File(path).existsSync()) {
          print("====== exist ====== $path");
          return path;
        }
      }
    }
    print("====== not exist ====== ");
    return null;
  }

  static bool get isDesktop {
    if (kIsWeb) return false;
    return [
      TargetPlatform.windows,
      TargetPlatform.linux,
      TargetPlatform.macOS,
    ].contains(defaultTargetPlatform);
  }

  static bool get isMobile {
    if (kIsWeb) return false;
    return [
      TargetPlatform.iOS,
      TargetPlatform.android,
    ].contains(defaultTargetPlatform);
  }
}
