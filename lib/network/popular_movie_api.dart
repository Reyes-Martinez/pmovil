// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:practica2/models/popular_model.dart';

// class PopularMovies {
//   final URL =
//       'https://api.themoviedb.org/3/movie/popular?api_key=0a115d141218871b1fd850171b8581a9&language=en-US&page=1';

//       Future<?> getAllPopular() async{
//         final response =  await http.get(Uri.parse(URL));
//         if(response.statusCode == 200){
//           var popular = jsonDecode(response.body)['result'] as List;
//           List<PopularMovies> listPopular = popular.map((e) => PopularModel.frommap(e)).toList();
//       }
// }
