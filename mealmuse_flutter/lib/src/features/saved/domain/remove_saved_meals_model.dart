// To parse this JSON data, do
//
//     final removeFavouriteResponse = removeFavouriteResponseFromJson(jsonString);

import 'dart:convert';

RemoveFavouriteResponse removeFavouriteResponseFromJson(String str) =>
    RemoveFavouriteResponse.fromJson(json.decode(str));

String removeFavouriteResponseToJson(RemoveFavouriteResponse data) =>
    json.encode(data.toJson());

class RemoveFavouriteResponse {
  String message;

  RemoveFavouriteResponse({required this.message});

  factory RemoveFavouriteResponse.fromJson(Map<String, dynamic> json) =>
      RemoveFavouriteResponse(message: json["message"]);

  Map<String, dynamic> toJson() => {"message": message};
}
