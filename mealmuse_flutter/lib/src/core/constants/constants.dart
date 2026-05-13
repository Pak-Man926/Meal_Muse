import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';

late PackageInfo packageInfo;

const String appName = "Meal Muse";
final String apiBaseUrl = dotenv.get("API_URL");
final String imageBaseUrl = apiBaseUrl.replaceAll(RegExp(r'/api/?$'), '');

const tinySpaceSize = SizedBox(height: 5);
const smallSpaceSize = SizedBox(height: 10);
const minSpaceSize = SizedBox(height: 15);
const mediumSpaceSize = SizedBox(height: 20);
const largeSpaceSize = SizedBox(height: 40);
