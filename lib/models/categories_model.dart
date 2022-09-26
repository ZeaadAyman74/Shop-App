class CategoryModel {
  bool? status;
  CategoryData? data;
  CategoryModel(Map<String,dynamic>json){
    status=json['status'];
    data=CategoryData(json['data']);
  }
}

class CategoryData {
  int? currentPage;
  List<DataInfo>categoryData=[];
CategoryData(Map<String,dynamic>json){
currentPage=json['current_page'];

json['data'].forEach((element) {
categoryData.add(DataInfo(element));
});
}
}
class DataInfo{
    int? id;
    String? name;
    String? image;

    DataInfo(Map<String,dynamic>json){
      id=json['id'];
      name=json['name'];
      image=json['image'];
    }
}