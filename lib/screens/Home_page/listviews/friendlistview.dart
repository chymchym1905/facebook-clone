import 'package:loading_more_list/loading_more_list.dart';

import '../../../index.dart';
import '../friend_card_container.dart';
import 'dart:math' as math;

class FriendListView extends StatefulWidget {
  final LoadMorePost source;
  // final List<dynamic> list;
  // final ScrollController controller;
  final PageStorageKey pagekey;

  const FriendListView({
    Key? key,
    // required this.list,
    // required this.controller,
    required this.source,
    required this.pagekey,
  }) : super(key: key);

  @override
  State<FriendListView> createState() => _FriendListViewState();
}

class _FriendListViewState extends State<FriendListView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    initLoad();
  }

  void initLoad() async {
    // await widget.source.loadData()==true;
  }

  @override
  void dispose() {
    // widget.source.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // AppData appdata = AppDataProvider.of(context);

    return Column(
      children: [
        Row(children: [
          Expanded(
            child: Row(
              children: [
                IconButton(
                    splashRadius: MediaQuery.of(context).size.width * 0.07,
                    onPressed: () {},
                    iconSize: MediaQuery.of(context).size.width * 0.07,
                    icon: const Icon(Octicons.three_bars)),
                Text("Friends",
                    style: Theme.of(context).textTheme.headlineSmall)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Transform.rotate(
              angle: 270 * math.pi / 180,
              child: IconButton(
                  splashRadius: MediaQuery.of(context).size.width * 0.07,
                  onPressed: () {},
                  iconSize: MediaQuery.of(context).size.width * 0.06,
                  icon: const Icon(Elusive.search)),
            ),
          ),
        ]),
        Expanded(
          child: LoadingMoreList<Post>(ListConfig<Post>(
            sourceList: widget.source,
            itemBuilder: (context, item, index) {
              // var items = list.map((e) => Post.fromJson(e)).toList();
              return FriendCard(data: widget.source[index].user);
            },
            indicatorBuilder: (context, status) {
              switch (status) {
                case IndicatorStatus.loadingMoreBusying:
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                case IndicatorStatus.error:
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ErrorWidget('Not found'),
                    ),
                  );
                case IndicatorStatus.noMoreLoad:
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Come back tommrow!',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  );
                case IndicatorStatus.empty:
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('No posts available',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  );
                case IndicatorStatus.fullScreenBusying:
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Fullscreen Busying...',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  );
                case IndicatorStatus.none:
                case IndicatorStatus.fullScreenError:
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Cannot load data',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  );
              }
            },
          )),
        ),
      ],
    );
  }
}
