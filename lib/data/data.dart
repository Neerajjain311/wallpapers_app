import 'package:wallpapers_app/model/categories_model.dart';

String apiKey = "563492ad6f91700001000001fcf02d17ea584d28aac875898ebae83f";

List<CategoryModel> getCategories(){
  List<CategoryModel> categories = new List();
  CategoryModel categoryModel = new CategoryModel();

  //Ele 1
  categoryModel.imgUrl = "https://images.pexels.com/photos/36762/scarlet-honeyeater-bird-red-feathers.jpg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categoryModel.categoryName = "Nature";
  categories.add(categoryModel);

  categoryModel = new CategoryModel();

  //Ele 2
  categoryModel.imgUrl = "https://images.pexels.com/photos/169647/pexels-photo-169647.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categoryModel.categoryName = "City Life";
  categories.add(categoryModel);
  
  categoryModel = new CategoryModel();

  //Ele 3
  categoryModel.imgUrl = "https://images.pexels.com/photos/1283208/pexels-photo-1283208.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categoryModel.categoryName = "Modern Art";
  categories.add(categoryModel);
  
  categoryModel = new CategoryModel();

  //Ele 4
  categoryModel.imgUrl = "https://images.pexels.com/photos/1565982/pexels-photo-1565982.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categoryModel.categoryName = "Food";
  categories.add(categoryModel);
  
  categoryModel = new CategoryModel();

  //Ele 5
  categoryModel.imgUrl = "https://images.pexels.com/photos/1714208/pexels-photo-1714208.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categoryModel.categoryName = "Technology";
  categories.add(categoryModel);
  
  categoryModel = new CategoryModel();

  //Ele 6
  categoryModel.imgUrl = "https://images.pexels.com/photos/96381/pexels-photo-96381.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categoryModel.categoryName = "Abstract";
  categories.add(categoryModel);

  categoryModel = new CategoryModel();

  //Ele 7
  categoryModel.imgUrl = "https://images.pexels.com/photos/1169754/pexels-photo-1169754.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categoryModel.categoryName = "Space";
  categories.add(categoryModel);
  
  categoryModel = new CategoryModel();

  //Ele 8
  categoryModel.imgUrl = "https://images.pexels.com/photos/919073/pexels-photo-919073.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categoryModel.categoryName = "Cars";
  categories.add(categoryModel);
  
  return categories;
}