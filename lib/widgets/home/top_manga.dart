import "package:flutter/material.dart";
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:yuix/data/providers/anilist/queries.dart';
import 'package:yuix/models/media.dart';

class TopManga extends StatefulWidget {
  const TopManga({
    super.key,
  });

  @override
  State<TopManga> createState() => _TopMangaState();
}

class _TopMangaState extends State<TopManga> {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(allTimePopularQuery),
          variables: returnQuery(1, 'trending')),
      builder: (QueryResult<Object?> result,
          {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore,
          Future<QueryResult<Object?>?> Function()? refetch}) {
        if (result.hasException) {
          return const Center(child: Text('No Data Found'));
        }

        // Media? MediaData = Media.fromJson(result.data!);

        final List<dynamic> mediaList = result.data?['Page']['media'] ?? [];
        final List<Media> mediaObjects =
            mediaList.map((json) => Media.fromJson(json)).toList();
        final List<Widget> imageSliders = mediaObjects.map<Widget>((image) {
          return 
          Container(
            margin: const EdgeInsets.all(3.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(image.bannerImage!.toString(),
                      fit: BoxFit.cover, width: double.infinity),
                  // Positioned(
                  //   bottom: 0.0,
                  //   left: 0.0,
                  //   right: 0.0,
                  //   child: Container(
                  //     decoration: const BoxDecoration(
                  //       gradient: LinearGradient(
                  //         colors: [
                  //           Color.fromARGB(200, 0, 0, 0),
                  //           Color.fromARGB(0, 0, 0, 0),
                  //         ],
                  //         begin: Alignment.bottomCenter,
                  //         end: Alignment.topCenter,
                  //       ),
                  //     ),
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 10.0, horizontal: 20.0),
                  //     child: Text(
                  //       'No Title',
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 20.0,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        }).toList();

        return CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 0.9,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
          ),
          items: imageSliders,
        );
      },
    );
  }
}
