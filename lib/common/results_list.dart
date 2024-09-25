import 'package:yuix/models/media.dart';
import 'package:yuix/data/providers/anilist/queries.dart';
// import 'package:yuix/common/list_widget.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yuix/data/providers/anilist/anilist_providers.dart';

class AnimeList extends StatelessWidget {
  AnimeList(
      {Key? key,
      required this.mainTitle,
      required this.query,
      required this.variables})
      : super(key: key);
  final String mainTitle;
  final String query;
  final String variables;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 5,
            ),
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
          Query(
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
              TrendingAnime? animedata = TrendingAnime.fromJson(result.data!);

              return Text(
                  animedata.page!.media![0].title!.userPreferred!.toString());

              // return ListView.builder(
              //   // padding: const EdgeInsets.symmetric(horizontal: 0),
              //   // scrollDirection: Axis.horizontal,
              //   itemBuilder: ((context, index) {
              //     // return ListWidget(
              //     //   itsColor: Vx.randomPrimaryColor,
              //     //   media: animedata.page!.media![index],
              //     // );
              //     // print('text');
              //     // return Text(animedata.page!.media![index].title!.userPreferred!
              //     //     .toString());
              //   }),
              //   itemCount: animedata.page?.pageInfo?.perPage,
              // );
            },
          ),
        ],
      ),
    );
  }
}
