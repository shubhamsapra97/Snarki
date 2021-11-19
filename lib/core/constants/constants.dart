import 'dart:math';
import '../models/models.dart';

const imageUrl =
    'https://png.pngtree.com/element_our/png/20181206/users-vector-icon-png_260862.jpg';

class Role {
  static String admin = "admin";
  static String user = "user";
  static String tutor = "tutor";
}

class DatePickerType {
  static String date = "By Date";
  static String range = "By Range";
  static String week = "By Week";
}

DateTime defaultDate = DateTime.fromMicrosecondsSinceEpoch(10000);

List<QuestionModel> allQuestions = [
  QuestionModel(
    "American",
    "assets/American.jpg",
  ),
  QuestionModel(
    "Barbecue",
    "assets/Barbeque.jpg",
  ),
  QuestionModel(
    "Fast Food",
    "assets/Burgers.jpg",
  ),
  QuestionModel(
    "Caribbean",
    "assets/Caribbean.jpg",
  ),
  QuestionModel(
    "Chinese",
    "assets/chinese.jpg",
  ),
  QuestionModel(
    "Cafe",
    "assets/Coffee-and-tea.jpg",
  ),
  QuestionModel(
    "Dessert",
    "assets/icecream.jpg",
  ),
  QuestionModel(
    "Irish",
    "assets/Irish.jpg",
  ),
  QuestionModel(
    "Italian",
    "assets/Italian.jpg",
  ),
  QuestionModel(
    "Korean",
    "assets/Korean.jpeg",
  ),
  QuestionModel(
    "Latin",
    "assets/Latin-America.jpg",
  ),
  QuestionModel(
    "Mediterranean",
    "assets/Mediterranean.jpg",
  ),
  QuestionModel(
    "Middle Eastern",
    "assets/MiddleEastern.jpg",
  ),
  QuestionModel(
    "Noodles",
    "assets/Noodles.jpg",
  ),
  QuestionModel(
    "European",
    "assets/pasta.jpg",
  ),
  QuestionModel(
    "Pizza",
    "assets/pizza.jpg",
  ),
  QuestionModel(
    "Sandwich",
    "assets/sandwiches.jpg",
  ),
  QuestionModel(
    "South American",
    "assets/SouthAmerican.jpeg",
  ),
  QuestionModel(
    "Steak",
    "assets/Steaks.jpg",
  ),
  QuestionModel(
    "Vegetarian",
    "assets/vegeterian.jpg",
  ),
  QuestionModel(
    "Asian",
    "assets/Asian.jpeg",
  ),
  QuestionModel(
    "Bar",
    "assets/Bar.jpeg",
  ),
  QuestionModel(
    "Pub",
    "assets/Pub.png",
  ),
  QuestionModel(
    "Mexican",
    "assets/Mexican.jpeg",
  ),
  QuestionModel(
    "Japanese",
    "assets/Japanese.jpeg",
  ),
  QuestionModel(
    "Deli",
    "assets/Deli.png",
  ),
  QuestionModel(
    "Spanish",
    "assets/Spanish.jpeg",
  ),
  QuestionModel(
    "Seafood",
    "assets/Seafood.jpeg",
  ),
  QuestionModel(
    "French",
    "assets/French.jpeg",
  ),
  QuestionModel(
    "Thai",
    "assets/Thai.jpeg",
  ),
  QuestionModel(
    "Bakery",
    "assets/Bakery.jpeg",
  ),
  QuestionModel(
    "Indian",
    "assets/Indian.jpeg",
  ),
  QuestionModel(
    "Greek",
    "assets/Greek.jpeg",
  ),
  QuestionModel(
    "Soups",
    "assets/Soups.jpeg",
  ),
  QuestionModel(
    "Vietnamese",
    "assets/Vietnamese.jpeg",
  ),
  QuestionModel(
    "Jamaican",
    "assets/Jamaican.jpeg",
  )
];

Map<String, List<String>> similarCuisines = {
  "Japanese": ["Sushi"],
  "Bar": ["Wine Bar"],
  "Fast Food": ["fast food"],
  "Pub": ["Wine Bar", "Gastropub"]
};

