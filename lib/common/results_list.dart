import 'package:yuix/common/list_widget.dart';
import 'package:yuix/models/media.dart';
import 'package:yuix/data/providers/anilist/queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yuix/data/providers/anilist/anilist_providers.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MeidaList extends StatelessWidget {
  const MeidaList({
    super.key,
    required this.mainTitle,
    required this.query,
    required this.variables,
  });

  final String mainTitle;
  final String query;
  final String variables;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              mainTitle.text
                  .minFontSize(16)
                  .fontWeight(FontWeight.w600)
                  .uppercase
                  .make(),
              InkWell(
                  onTap: () {},
                  child: 'View all'.text.minFontSize(13).makeCentered())
            ],
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            // double itemWidth = constraints.maxWidth / 2.5;
            return SizedBox(
              height: 260, // Adjust height proportionally
              width: double.infinity,
              child: Query(
                  options: QueryOptions(
                      document: gql(query),
                      variables: returnQuery(1, variables, AnilistType.manga)),
                  builder: (QueryResult<Object?> result,
                      {Future<QueryResult<Object?>> Function(FetchMoreOptions)?
                          fetchMore,
                      Future<QueryResult<Object?>?> Function()? refetch}) {
                    if (result.hasException) {
                      return const Center(child: Text('No Data Found'));
                    }
                    MediaList? mediaData = MediaList.fromJson(result.data!);

                    return CarouselSlider.builder(
                      itemCount: mediaData.page!.pageInfo!.perPage!,
                      options: CarouselOptions(
                        aspectRatio: 1.7,
                        viewportFraction: 0.31,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: false,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemBuilder: (context, itemIndex, realIndex) {
                        return ListWidget(
                            media: mediaData.page!.media![itemIndex]);
                      },
                    );
                  }),
            );
          },
        ),
      ],
    );
  }
}
