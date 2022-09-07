import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/view/news/faq_view.dart';
import 'package:fundpad/view/news/news_view.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
            length: 2,
            child: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "NEWS",
                    style: TextStyle(
                      color: _tabController.index == 0 ? COLOR.BLUE_DARK : null,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "FAQ",
                    style: TextStyle(
                      color: _tabController.index == 1 ? COLOR.BLUE_DARK : null,
                    ),
                  ),
                ),
              ],
              controller: _tabController,
              indicatorColor: COLOR.BLUE_LIGHT,
            )),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [NewsView(), FaqView()],
          ),
        )
      ],
    );
  }
}
