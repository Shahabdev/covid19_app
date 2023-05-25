import 'dart:convert';

import 'package:covid_app19/view_model/utilities/app_url.dart';
import 'package:http/http.dart' as http;

import '../model/woldstate_model.dart';

class StatesServices {
  Future<WorlstateModel> fetchWorldRecord() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorlstateModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }
  Future<List<dynamic>> fetchcountrieslist()async{
    final response=await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode==200)
      {
        var data=jsonDecode(response.body);
        return data;
      }
    else
      {
        throw Exception('Error');
      }
  }
}

