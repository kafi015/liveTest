
class ApiModel {
  String? status;
  List<Data>? data;

  ApiModel({this.status, this.data});

  ApiModel.fromJson(List<dynamic> json) {

    data = <Data>[];
    for (var v in json) {
      data!.add(Data.fromJson(v));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? userId;
  int? id;
  String? title;
  String? body;

  Data({this.userId, this.id, this.title, this.body});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
