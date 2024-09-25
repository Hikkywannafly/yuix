import "package:flutter/material.dart";
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:yuix/data/providers/anilist/queries.dart';
import 'package:yuix/models/media.dart';

class TopManga extends StatelessWidget {
  const TopManga({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String proxyUrl =
        'https://goodproxy.goodproxy.workers.dev/fetch?url=';
    return Query(
        options: QueryOptions(
            document: gql(allTimePopularQuery),
            variables: trendingMeidaQueryVariables),
        builder: (QueryResult<Object?> result,
            {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore,
            Future<QueryResult<Object?>?> Function()? refetch}) {
          if (result.hasException) {
            return const Center(child: Text('No Data Found'));
          }
          final List<dynamic> mediaList = result.data?['Page']['media'] ?? [];

          final List<Media> mediaObjects =
              mediaList.map((json) => Media.fromJson(json)).toList();
          final List<Widget> imageSliders = mediaObjects.map<Widget>((data) {
            return Container(
              margin: const EdgeInsets.all(3.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(
                        data.bannerImage != null
                            ? proxyUrl + data.bannerImage.toString()
                            : data.coverImage!.extraLarge.toString(),
                        fit: BoxFit.fitHeight,
                        width: double.maxFinite,
                        height: double.maxFinite),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0),
                              ],
                              begin: Alignment.center,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title!.userPreferred.toString().length > 35
                                    ? '${data.title!.userPreferred.toString().substring(0, 20)}...'
                                    : data.title!.userPreferred.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                data.genres!.join(' - '),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )),
                    ),
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
        });
  }
}
