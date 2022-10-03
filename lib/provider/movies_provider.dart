import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practica2/helpers/debuncer.dart';
import 'package:practica2/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = "0a115d141218871b1fd850171b8581a9";
  final String _baseUrl = "api.themoviedb.org";
  final String _language = "es-ES";
  List<Movie> onDiplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> popularTvSeries = [];
  Map<int, List<Cast>> movieCasts = {};

  int _popularPague = 0;
  int _popularTvSeriesPague = 0;

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionStreamController =
      StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream =>
      _suggestionStreamController.stream;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }
  Future<String> _getJsonDta(String endponint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endponint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonDta("3/movie/now_playing");
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    onDiplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPague++;
    final jsonData = await _getJsonDta("3/movie/popular", _popularPague);
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCasts.containsKey(movieId)) {
      return movieCasts[movieId]!;
    }
    final jsonData = await _getJsonDta("3/movie/$movieId/credits");
    final credistResponse = CredistResponse.fromJson(jsonData);
    movieCasts[movieId] = credistResponse.cast;
    return credistResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, "3/search/movie",
        {'api_key': _apiKey, 'language': _language, 'query': query});
    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = "";
    debouncer.onValue = (value) async {
      final results = await searchMovie(value);
      _suggestionStreamController.add(results);
    };
    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });
    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
