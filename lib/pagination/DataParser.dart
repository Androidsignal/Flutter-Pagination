import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:google_maps/Constants.dart';
import 'package:google_maps/pagination/UserModel.dart';
import 'package:http/http.dart';

class Dataparser {

  static Future getCategoryList(String url) async {

    try {
      final response = await get(Uri.encodeFull(url));
      if (response.statusCode == 200) {
        Map body = json.decode(response.body);
        if (body != null) {
          if (body.containsKey("ProductsFromParentcategory")) {
            List categories = body["ProductsFromParentcategory"];
            List<UserModel> categoryList = categories.map((c) => new UserModel.fromMap(c)).toList();
            return Constants.resultInApi(categoryList, false);
          }else{
            return Constants.resultInApi("body doesn't contain code",true);
          }
        }else{
          return Constants.resultInApi("body is null",true);
        }
      }
    } catch (e) {
      return Constants.resultInApi("errorStack = "+e.toString(),true);
    }
  }

}