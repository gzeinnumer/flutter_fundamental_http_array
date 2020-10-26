import 'dart:convert';
import 'package:http/http.dart' as http;

//https://javiercbk.github.io/json_to_dart/
class ResponseUsers {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<Data> data;
  Ad ad;

  ResponseUsers(
      {this.page,
      this.perPage,
      this.total,
      this.totalPages,
      this.data,
      this.ad});

  ResponseUsers.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    ad = json['ad'] != null ? new Ad.fromJson(json['ad']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    data['total_pages'] = this.totalPages;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.ad != null) {
      data['ad'] = this.ad.toJson();
    }
    return data;
  }

  static Future<ResponseUsers> callApiArray(String page) async{

    String url = "https://reqres.in/api/users?page="+page;

    var response = await http.get(url);
    var jsonObject =  json.decode(response.body);

    ResponseUsers result = ResponseUsers.fromJson(jsonObject);
    List<dynamic> tempData = (jsonObject as Map<String, dynamic>)['data'];
    for(int i=0; i<tempData.length; i++){
      result.data.add(Data.fromJson(tempData[i]));
    }
    // result.ad = Ad.fromJson((jsonObject as Map<String, dynamic>)['ad']);

    return result;
  }
}

class Data {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  Data({this.id, this.email, this.firstName, this.lastName, this.avatar});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Ad {
  String company;
  String url;
  String text;

  Ad({this.company, this.url, this.text});

  Ad.fromJson(Map<String, dynamic> json) {
    company = json['company'];
    url = json['url'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company'] = this.company;
    data['url'] = this.url;
    data['text'] = this.text;
    return data;
  }
}
