import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';

class InfiniteScroller extends StatefulWidget {
  const InfiniteScroller({
    super.key,
    required this.child,
    // required this.onRefresh,
    // required this.onLoad,
    this.refreshOnStart = true,
    this.enableInfiniteScroll = true,
    // this.easyRefreshController,
  });

  final Widget child;
  // final Future<void> Function() onRefresh;
  // final Future<void> Function() onLoad;
  final bool refreshOnStart;
  final bool enableInfiniteScroll;
  // final EasyRefreshController? easyRefreshController;

  @override
  State<InfiniteScroller> createState() => _InfiniteScrollerState();
}

class _InfiniteScrollerState extends State<InfiniteScroller> {
  // bool _isLoading = false;

  // @override
  // void initState() {
  //   if (!Platform.isAndroid && widget.refreshOnStart) {
  //     SchedulerBinding.instance.addPostFrameCallback((_) {
  //       widget.onRefresh();
  //     });
  //   }
  //   super.initState();
  // }

  // void _onScroll(ScrollMetrics metrics) {
  //   if (metrics.atEdge && metrics.pixels == metrics.maxScrollExtent) {
  //     if (_isLoading || !widget.enableInfiniteScroll) {
  //       return;
  //     }
  //     widget.onLoad().then((_) {
  //       if (mounted) {
  //         setState(() {
  //           _isLoading = false;
  //         });
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      // controller: widget.easyRefreshController,
      // onRefresh: widget.onRefresh,
      header: const ClassicHeader(
        processedDuration: Duration.zero,
        showMessage: false,
        showText: false,
      ),
      footer: const ClassicFooter(
        processedDuration: Duration.zero,
        showMessage: false,
        showText: false,
      ),
      refreshOnStart: widget.refreshOnStart,
      // onLoad: widget.onLoad,
      child: widget.child,
    );
  }
}
