

import 'AllAnimeData.dart';

class AllAnimeModel {
    List<AllAnimeData> allData;
    String msg;
    String status_code;

    AllAnimeModel({this.allData, this.msg, this.status_code});

    factory AllAnimeModel.fromJson(Map<String, dynamic> json) {
        return AllAnimeModel(
            allData: json['data'] != null ? (json['data'] as List).map((i) => AllAnimeData.fromJson(i)).toList() : null,
            msg: json['msg'], 
            status_code: json['status_code'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['msg'] = this.msg;
        data['status_code'] = this.status_code;
        if (this.allData != null) {
            data['data'] = this.allData.map((v) => v.toJson()).toList();
        }
        return data;
    }
}