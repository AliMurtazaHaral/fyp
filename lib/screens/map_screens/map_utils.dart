

import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class MapUtils {

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }
  static Future<void> launchMapUrl(String address) async {
    String encodedAddress = Uri.encodeComponent(address);
    String googleMapUrl = "google.navigation:q=$encodedAddress";
    String appleMapUrl = "http://maps.apple.com/?q=$encodedAddress";
    if (Platform.isAndroid) {
      try {
        if (await canLaunchUrl(Uri.parse(googleMapUrl))) {
          await launchUrl(Uri.parse(googleMapUrl));
        } else {
          throw 'Could not open the map.';
        }
      } catch (error) {
        throw("Cannot launch Google map");
      }
    }
    if (Platform.isIOS) {
      try {
        if (await canLaunchUrl(Uri.parse(appleMapUrl))) {
          await launchUrl(Uri.parse(appleMapUrl));
        } else {
          throw 'Could not open the map.';
        }
      } catch (error) {
        throw("Cannot launch Apple map");
      }
    }
  }
}