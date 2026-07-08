// To parse this JSON data, do
//
//     final addFavouriteResponse = addFavouriteResponseFromJson(jsonString);

import 'dart:convert';

AddFavouriteResponse addFavouriteResponseFromJson(String str) =>
    AddFavouriteResponse.fromJson(json.decode(str));

String addFavouriteResponseToJson(AddFavouriteResponse data) =>
    json.encode(data.toJson());

class AddFavouriteResponse {
  String message;

  AddFavouriteResponse({required this.message});

  factory AddFavouriteResponse.fromJson(Map<String, dynamic> json) =>
      AddFavouriteResponse(message: json["message"]);

  Map<String, dynamic> toJson() => {"message": message};
}
