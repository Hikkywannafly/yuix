import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:yuix/common/list_widget.dart';
import 'package:yuix/models/media.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:yuix/widgets/infinity_scroll.dart';
import 'package:yuix/widgets/grid_item_title.dart';
import 'package:yuix/widgets/media_item_card.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class MeidaList extends StatelessWidget {
  const MeidaList({
    super.key,
    required this.mainTitle,
    required this.query,
    required this.variables,
    this.isShowAll = true,
  });

  final String mainTitle;
  final bool isShowAll;
  final String query;
  final Map<String, dynamic> variables;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
        // Query(
        //     options: QueryOptions(
        //       document: gql(query),
        //       variables: variables,
        //     ),
        //     builder: (QueryResult<Object?> result,
        //         {Future<QueryResult<Object?>> Function(FetchMoreOptions)?
        //             fetchMore,
        //         Future<QueryResult<Object?>?> Function()? refetch}) {
        //       if (result.hasException) {
        //         return const Center(child: Text('No Data Found'));
        //       }
        //       MediaList? mediaData = MediaList.fromJson(result.data!);

        //     }),

        // InfiniteScroller(
        //   child:
        // LayoutBuilder(
        //   builder: (context, constraints) {
        //     int crossAxisCount = constraints.maxWidth ~/ 180;

        //     return GridView.builder(
        //       padding: const EdgeInsets.symmetric(horizontal: 16),
        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: crossAxisCount,
        //         childAspectRatio: 0.7,
        //         crossAxisSpacing: 16,
        //         mainAxisSpacing: 16,
        //       ),
        //       itemCount: 3,
        //       itemBuilder: (context, index) {
        //         return MediaItemCard(
        //           title: 'sd',
        //           cover:
        //               'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
        //           url:
        //               'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
        //         );
        //       },
        //     );
        //   },
        // ),
        // )

        // LayoutBuilder(
        //   builder: (context, constraints) {
        //     int itemsPerView = (constraints.maxWidth / 160).floor();
        //     double viewportFraction = 1 / itemsPerView;
        //     // double itemWidth = constraints.maxWidth / 120;
        //     return SizedBox(
        //       height: 350,
        //       width: double.infinity,
        //       child: Query(
        //           options: QueryOptions(
        //             document: gql(query),
        //             variables: variables,
        //           ),
        //           builder: (QueryResult<Object?> result,
        //               {Future<QueryResult<Object?>> Function(FetchMoreOptions)?
        //                   fetchMore,
        //               Future<QueryResult<Object?>?> Function()? refetch}) {
        //             if (result.hasException) {
        //               return const Center(child: Text('No Data Found'));
        //             }
        //             MediaList? mediaData = MediaList.fromJson(result.data!);

        //             return CarouselSlider.builder(
        //               itemCount: mediaData.page!.pageInfo!.perPage!,
        //               options: CarouselOptions(
        //                 // aspectRatio: 1.3,
        //                 viewportFraction: viewportFraction,
        //                 initialPage: 0,
        //                 enableInfiniteScroll: true,
        //                 autoPlayInterval: const Duration(seconds: 3),
        //                 autoPlayCurve: Curves.fastOutSlowIn,
        //                 enlargeCenterPage: false,
        //                 scrollDirection: Axis.horizontal,
        //               ),
        //               itemBuilder: (context, itemIndex, realIndex) {
        //                 final media = mediaData.page!.media![itemIndex];

        //                 return MediaItemCard(
        //                   title: 'text',
        //                   cover:
        //                       'https://via.placeholder.com/300x400.png?text=No+Image',
        //                   url:
        //                       'https://via.placeholder.com/300x400.png?text=No+Image',
        //                   update:
        //                       'https://via.placeholder.com/300x400.png?text=No+Image',
        //                 );
        //               },
        //             );
        //           }),
        //     );
        //   },
        // ),
      ],
    );
  }
}
