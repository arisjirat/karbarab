import 'package:flutter/material.dart';

enum Flavor { DEVELOPMENT, STAGING, PRODUCTION }

class FlavorValues {
  FlavorValues({@required this.data, @required this.adMobId});
  final String data;
  final String adMobId;
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final Color color;
  final FlavorValues values;
  static FlavorConfig _instance;
  factory FlavorConfig({
    @required Flavor flavor,
    @required FlavorValues values,
    Color color = Colors.blue,
  }) {
    _instance ??= FlavorConfig._internal(
      flavor,
      StringUtils.enumName(flavor.toString()),
      color,
      values,
    );
    return _instance;
  }

  FlavorConfig._internal(this.flavor, this.name, this.color, this.values);
  static FlavorConfig get instance {
    return _instance;
  }

  static bool isProduction() => _instance.flavor == Flavor.PRODUCTION;
  static bool isDevelopment() => _instance.flavor == Flavor.DEVELOPMENT;
  static bool isStaging() => _instance.flavor == Flavor.STAGING;
}

class StringUtils {
  static String enumName(String string) {
    return string.replaceFirst('Flavor.', '');
  }
}
