import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

/// @author: pengboboer
/// @createDate: 2023/4/27
class NestedScrollViewGoodDemoPage extends StatefulWidget {
  NestedScrollViewGoodDemoPage({
    required this.data,
    required this.titleColumn,
    required this.titleRow,
  });

  final List<List<String>> data;
  final List<String> titleColumn;
  final List<String> titleRow;

  @override
  State<NestedScrollViewGoodDemoPage> createState() => _NestedScrollViewGoodDemoPageState();
}

class _NestedScrollViewGoodDemoPageState extends State<NestedScrollViewGoodDemoPage> {
  ScrollControllers _scs = ScrollControllers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('NestedScrollView with '),
        backgroundColor: Colors.amber,
      ),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => _buildHeadWidget(context),
          body: _buildBody()),
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
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverPersistentHeader(
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
                ),
                _buildHeadTabRowWidget(
                    legendCell: Text('Sticky Legend'),
                    columnsLength: widget.titleColumn.length,
                    columnsTitleBuilder: (i) => Text(widget.titleColumn[i]))
              ],
            ),
            height: 120
          ),
        ),
      ),
    ];
  }

  Widget _buildBody() {
    Widget content = Container(
      // height: 500,
      child: StickyHeadersTableInNested(
        scrollControllers: _scs,
        columnsLength: widget.titleColumn.length,
        rowsLength: widget.titleRow.length,
        columnsTitleBuilder: (i) => Text(widget.titleColumn[i]),
        rowsTitleBuilder: (i) => Text(widget.titleRow[i]),
        contentCellBuilder: (i, j) => Text(widget.data[i][j]),
        legendCell: Text('Sticky Legend'),
      ),
    );

    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(builder: (context) {
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            scrollbars: false,
          ),
          child: CustomScrollView(
            slivers: [
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverToBoxAdapter(
                child: content,
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeadTabRowWidget(
      {required Widget legendCell,
      required Widget Function(int columnIndex) columnsTitleBuilder,
      required int columnsLength}) {
    return Container(
      color: Colors.white,
      child: Row(
        textDirection: TextDirection.ltr,
        children: <Widget>[
          /// STICKY LEGEND
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Container(
              width: CellDimensions.base.stickyLegendWidth,
              height: CellDimensions.base.stickyLegendHeight,
              alignment: CellAlignments.base.stickyLegendAlignment,
              child: legendCell,
            ),
          ),

          /// STICKY ROW
          Expanded(
            child: NotificationListener<ScrollNotification>(
              child: Scrollbar(
                // Key is required to avoid 'The Scrollbar's ScrollController has no ScrollPosition attached.
                key: Key('Row ${false}'),
                thumbVisibility: false,
                controller: _scs.horizontalTitleController,
                child: SingleChildScrollView(
                  reverse: false,
                  physics: CustomScrollPhysics().stickyRow,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    textDirection: TextDirection.ltr,
                    children: List.generate(
                      columnsLength,
                      (i) => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {},
                        child: Container(
                          // key: globalRowTitleKeys[i] ??= GlobalKey(),
                          width: CellDimensions.base.stickyWidth(i),
                          height: CellDimensions.base.stickyLegendHeight,
                          alignment: CellAlignments.base.rowAlignment(i),
                          child: columnsTitleBuilder(i),
                        ),
                      ),
                    ),
                  ),
                  controller: _scs.horizontalTitleController,
                ),
              ),
              onNotification: (notification) =>
                  _scs.customNotificationListener?.call(
                    notification: notification,
                    controller: _scs.horizontalTitleController,
                  ) ??
                  false,
            ),
          )
        ],
      ),
    );
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
