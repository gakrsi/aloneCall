class PlanModel{
  PlanModel({this.desc,this.discountPrice,this.price,this.title,this.isVideo, this.min});

  PlanModel.fromJson(Map<String,dynamic> data){
    title = data['title'] as String;
    desc = data['desc'] as String;
    price = data['price'] as int;
    discountPrice = data['discount_price'] as int;
    isVideo = data['is_video'] as bool;
    min = data['min'] as int;
  }

  String title;
  String desc;
  int discountPrice;
  int price;
  bool isVideo;
  int min;
}