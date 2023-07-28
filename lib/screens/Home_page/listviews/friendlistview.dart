import 'package:loading_more_list/loading_more_list.dart';

import '../../../index.dart';
import '../friend_card_container.dart';

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

    return Container(
      color: themeManager.themeMode == dark
          ? const Color.fromARGB(255, 38, 38, 38)
          : whitee,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              padding: const EdgeInsets.only(right: 8, top: 8),
              child: Transform.flip(
                flipX: true,
                child: IconButton(
                    splashRadius: MediaQuery.of(context).size.width * 0.07,
                    onPressed: () {},
                    iconSize: MediaQuery.of(context).size.width * 0.06,
                    icon: const Icon(Elusive.search)),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 10),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: themeManager.themeMode == dark
                      ? const Color.fromARGB(255, 58, 59, 60)
                      : const Color.fromARGB(255, 241, 242, 246),
                  shape: const StadiumBorder(),
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                      vertical: 8)),
              child: Text("Your friends",
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
          ),
          Center(
            child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.4))),
                height: 1,
                width: MediaQuery.of(context).size.width * 0.9),
          ),
          Expanded(
            child: LoadingMoreList<Post>(ListConfig<Post>(
              sourceList: widget.source,
              itemBuilder: (context, item, index) {
                // var items = list.map((e) => Post.fromJson(e)).toList();
                if (index == 0) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.05,
                            left: 8,
                            top: 20,
                            bottom: 5),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Text("Friend Request",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                            ),
                            Expanded(
                                child: Text("100",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(color: Colors.red))),
                            Text("See all",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.blue,
                                    ))
                          ],
                        ),
                      ),
                      FriendCard(
                        user: widget.source[index].user,
                        posts: widget.source[index],
                      ),
                    ],
                  );
                } else {
                  return FriendCard(
                    user: widget.source[index].user,
                    posts: widget.source[index],
                  );
                }
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
      ),
    );
  }
}
