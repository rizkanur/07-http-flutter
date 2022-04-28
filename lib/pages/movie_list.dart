import 'package:flutter/material.dart';
import 'package:flutter_http_request/pages/movie_detail.dart';
import 'package:flutter_http_request/services/http_service.dart';

// ignore: use_key_in_widget_constructors
class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late int moviesCount;
  late List movies;
  late HttpService service;
  bool _isLoading = true;

  Future initialize() async {
    service.getPopularMovies().then((value) => {
          setState(() {
            movies = value!;
            moviesCount = movies.length;
            _isLoading = false;
          })
        });
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies - Rizka Nur Cahyani(2031710065)"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              // ignore: unnecessary_null_comparison
              itemCount: (moviesCount == null) ? 0 : moviesCount,
              itemBuilder: (context, int position) {
                return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: new BorderRadius.circular(30),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w500/" +
                            movies[position].posterPath,
                        height: 100,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(movies[position].title),
                    subtitle: Text(
                        'Rating =' + movies[position].voteAverage.toString()),
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (_) => MovieDetail(movies[position]));
                      Navigator.push(context, route);
                    },
                  ),
                );
              },
            ),
    );
  }
}