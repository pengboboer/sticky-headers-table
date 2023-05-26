import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

/// @author: pengboboer
/// @createDate: 2023/4/27
class NestedScrollViewBadDemoPage extends StatelessWidget {
  NestedScrollViewBadDemoPage({
    required this.data,
    required this.titleColumn,
    required this.titleRow,
  });

  final List<List<String>> data;
  final List<String> titleColumn;
  final List<String> titleRow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('NestedScrollView with '),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        color: Colors.white,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => _buildHeadWidget(context),
          body: StickyHeadersTable(
            columnsLength: titleColumn.length,
            rowsLength: titleRow.length,
            columnsTitleBuilder: (i) => Text(titleColumn[i]),
            rowsTitleBuilder: (i) => Text(titleRow[i]),
            contentCellBuilder: (i, j) => Text(data[i][j]),
            legendCell: Text('Sticky Legend'),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildHeadWidget(BuildContext context) {
    return [
      SliverToBoxAdapter(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 60, horizontal: 30),
          color: Colors.yellow,
          child: Text(
            "header",
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: CommonSilverAppBarDelegate(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 70,
                color: Colors.red,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "persistentHeader",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              )
              // _buildHeadTabRowWidget()
            ],
          ),
        ),
      ),
    ];
  }
}

class CommonSilverAppBarDelegate extends SliverPersistentHeaderDelegate {
  CommonSilverAppBarDelegate(this._tabBar, {this.height = 70});

  final Widget _tabBar;

  final double height;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
