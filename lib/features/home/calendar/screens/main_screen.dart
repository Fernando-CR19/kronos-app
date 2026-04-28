import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:kronos_app/features/home/calendar/widgets/kronos_calendar.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  bool _isCalendarExpanded = true;
  final DateTime _selectedDate = DateTime.now();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 50 && _isCalendarExpanded) {
        setState(() => _isCalendarExpanded = false);
      } else if (_scrollController.offset <= 50 && !_isCalendarExpanded) {
        setState(() => _isCalendarExpanded = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _CalendarHeaderDelegate(
                isExpanded: _isCalendarExpanded,
                selectedDate: _selectedDate,
                expandedHeight: MediaQuery.of(context).size.height * 0.5,
                collapsedHeight: 75,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFF111120),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Evento $index',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                childCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _CalendarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final bool isExpanded;
  final DateTime selectedDate;
  final double expandedHeight;
  final double collapsedHeight;

  _CalendarHeaderDelegate({
    required this.isExpanded,
    required this.selectedDate,
    required this.expandedHeight,
    required this.collapsedHeight,
  });

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => collapsedHeight;

  @override
  bool shouldRebuild(covariant _CalendarHeaderDelegate oldDelegate) =>
      oldDelegate.isExpanded != isExpanded ||
      oldDelegate.selectedDate != selectedDate;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final isCollapsed = progress > 0.85;

    return Container(
      color: Color(0xFF0A0A14),
      child: ClipRect(
        child: SizedBox(
          height: (maxExtent - shrinkOffset).clamp(minExtent, maxExtent),
          child: isCollapsed
              ? FLineCalendar(
                  control: .managed(initial: selectedDate),
                  style: (style) => style.copyWith(
                    decoration: FWidgetStateMap({
                      WidgetState.selected: BoxDecoration(
                        color: const Color(0xFF1A2A3A),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF4A90D9)),
                      ),
                      WidgetState.any: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF2A2A4A)),
                      ),
                    }),
                    dateTextStyle: FWidgetStateMap({
                      WidgetState.selected: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      WidgetState.any: TextStyle(color: Colors.white),
                    }),
                    weekdayTextStyle: FWidgetStateMap({
                      WidgetState.selected: TextStyle(
                        color: const Color(0xFF4A90D9),
                      ),
                      WidgetState.any: TextStyle(
                        color: const Color(0xFF9B9BB5),
                      ),
                    }),
                    todayIndicatorColor: FWidgetStateMap({
                      WidgetState.any: const Color(0xFF4A90D9),
                    }),
                  ),
                )
              : KronosCalendar(selectedDate: selectedDate),
        ),
      ),
    );
  }
}
