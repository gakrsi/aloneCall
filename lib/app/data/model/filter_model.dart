class FilterModel{

  FilterModel({this.initAge,this.initDistance,this.language,this.lastAge,this.lastDistance});
  FilterModel.fromJson(Map<String,dynamic> data){
    initDistance = data['init_distance'] as int;
    lastDistance = data['last_distance'] as int;
    initAge = data['init_age'] as int;
    lastAge = data['last_age'] as int;
    language = data['language'] as List<dynamic>;
  }
  int initAge;
  int lastAge;
  int initDistance;
  int lastDistance;
  List<dynamic> language = <dynamic>[];

  Map<String,dynamic> toJson(FilterModel filterModel){
    var data = <String,dynamic>{};
    data['init_distance'] = filterModel.initDistance;
    data['last_distance'] = filterModel.lastDistance;
    data['init_age'] = filterModel.initAge;
    data['last_age'] = filterModel.lastAge;
    data['language'] = filterModel.language;
    return data;
  }
}