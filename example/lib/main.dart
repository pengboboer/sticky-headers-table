import 'package:flutter/material.dart';
import 'package:table_sticky_headers_example/nested_scroll_view_bad_demo_page.dart';
import 'column_in_percent_page.dart';
import 'infinite_scroll_page.dart';
import 'nested_scroll_view_good_demo_page.dart';
import 'offset_to_cell_page.dart';
import 'simple_table_page.dart';
import 'tap_handler_page.dart';
import 'decorated_table_page.dart';

void main() {
  runApp(
    MaterialApp(
      home: LandingPage(),
    ),
  );
}

class LandingPage extends StatefulWidget {
  final columns = 10;
  final rows = 30;

  List<List<String>> makeData({int rows = 30}) {
    final List<List<String>> output = [];
    for (int i = 0; i < columns; i++) {
      final List<String> row = [];
      for (int j = 0; j < rows; j++) {
        row.add('L$j : T$i');
      }
      output.add(row);
    }
    return output;
  }

  /// Simple generator for column title
  List<String> makeTitleColumn() => List.generate(columns, (i) => 'Top $i');

  /// Simple generator for row title
  List<String> makeTitleRow({int rows = 30}) => List.generate(rows, (i) => 'Left $i');

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;

  Widget _widgetOptions(int index) {
    switch (index) {
      case 0:
        return SimpleTablePage(
          titleColumn: widget.makeTitleColumn(),
          titleRow: widget.makeTitleRow(),
          data: widget.makeData(),
        );
      case 1:
        return NestedScrollViewBadDemoPage(
          titleColumn: widget.makeTitleColumn(),
          titleRow: widget.makeTitleRow(),
          data: widget.makeData(),
        );
      case 2:
        return NestedScrollViewBadDemoPage(
          titleColumn: widget.makeTitleColumn(),
          titleRow: widget.makeTitleRow(rows: 2),
          data: widget.makeData(rows: 2),
        );
      case 3:
        return NestedScrollViewGoodDemoPage(
          titleColumn: widget.makeTitleColumn(),
          titleRow: widget.makeTitleRow(),
          data: widget.makeData(),
        );
      case 4:
        return NestedScrollViewGoodDemoPage(
          titleColumn: widget.makeTitleColumn(),
          titleRow: widget.makeTitleRow(rows: 2),
          data: widget.makeData(rows: 2),
        );
      // case 1:
      //   return TapHandlerPage(
      //     titleColumn: widget.makeTitleColumn(),
      //     titleRow: widget.makeTitleRow(),
      //     data: widget.makeData(),
      //   );
      // case 2:
      //   return DecoratedTablePage(
      //     titleColumn: widget.makeTitleColumn(),
      //     titleRow: widget.makeTitleRow(),
      //     data: widget.makeData(),
      //   );
      // case 3:
      //   return OffsetToCellPage(
      //     titleColumn: widget.makeTitleColumn(),
      //     titleRow: widget.makeTitleRow(),
      //     data: widget.makeData(),
      //   );
      // case 4:
      //   return ColumnWidthInPercentPage();
      // case 5:
      //   return InfiniteScrollPage();

      default:
        print('$index not supported');
        return Container();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(),
            label: 'Base',
          ),
          // BottomNavigationBarItem(
          //   icon: Container(),
          //   label: 'Tap',
          // ),
          // BottomNavigationBarItem(
          //   icon: Container(),
          //   label: 'Decorated',
          // ),
          // BottomNavigationBarItem(
          //   icon: Container(),
          //   label: 'Offset',
          // ),
          // BottomNavigationBarItem(
          //   icon: Container(),
          //   label: 'Column %',
          // ),
          // BottomNavigationBarItem(
          //   icon: Container(),
          //   label: 'Web',
          // ),
          BottomNavigationBarItem(
            icon: Container(),
            label: 'Bad',
          ),
          BottomNavigationBarItem(
            icon: Container(),
            label: 'BadLittle',
          ),
          BottomNavigationBarItem(
            icon: Container(),
            label: 'Good',
          ),
          BottomNavigationBarItem(
            icon: Container(),
            label: 'GoodLittle',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
