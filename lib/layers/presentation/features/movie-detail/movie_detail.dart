import 'package:flutter/material.dart';
import 'package:flutter_movie_db_app/layers/domain/entity/movie_entity.dart';
import 'package:flutter_movie_db_app/layers/presentation/features/movie-detail/provider/movie_credits_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetail extends ConsumerStatefulWidget {
  final MovieEntity movie;
  const MovieDetail({super.key, required this.movie});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieDetailState();
}

class _MovieDetailState extends ConsumerState<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Text(widget.movie.title),
                Text(widget.movie.overview),
                Text(widget.movie.popularity.toString()),
                Text(widget.movie.releaseDate.toString()),
              ],
            ),
          ),
          _credits(),
        ],
      ),
    );
  }

  AppBar _appBar() => AppBar(title: const Text('Movie Detail'), centerTitle: true);

  Container _credits() {
    final credits = ref.watch(movieCreditsProvider(widget.movie.id));
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 100,
      width: MediaQuery.sizeOf(context).width,
      child: credits.when(
        data:
            (credits) => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: credits.length,
              itemBuilder: (context, index) {
                final credit = credits[index];
                return SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          CircleAvatar(child: Image.network(credit.profilePath)),
                          Text(credit.name),
                          Text(credit.character),
                        ],
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                );
              },
            ),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
