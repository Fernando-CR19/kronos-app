import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forui/forui.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FCalendar(
              style: (style) => style.copyWith(
                pageAnimationDuration: Duration(milliseconds: 200),
                decoration: BoxDecoration(color: Colors.transparent),
                padding: EdgeInsets.only(top: 24),
                dayPickerStyle: (dayStyle) => dayStyle.copyWith(
                  tileSize: MediaQuery.of(context).size.width / 7,
                  current: (current) => current.copyWith(
                    backgroundColor: FWidgetStateMap({
                      WidgetState.selected: const Color(0xFF4A90D9),
                      WidgetState.any: Colors.transparent,
                    }),
                    textStyle: FWidgetStateMap({
                      WidgetState.selected: TextStyle(color: Colors.white),
                      WidgetState.any: TextStyle(color: Colors.white),
                    }),
                    radius: Radius.circular(8.r),
                  ),
                  enclosing: (enclosing) => enclosing.copyWith(
                    backgroundColor: FWidgetStateMap({
                      WidgetState.any: Colors.transparent,
                    }),
                  ),
                ),
                yearMonthPickerStyle: (yearStyle) => yearStyle.copyWith(
                  backgroundColor: FWidgetStateMap({
                    WidgetState.any: Colors.transparent,
                  }),
                  borderColor: FWidgetStateMap({
                    WidgetState.any: Colors.transparent,
                  }),
                  textStyle: FWidgetStateMap({
                    WidgetState.selected: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    WidgetState.any: TextStyle(color: Colors.white),
                  }),
                ),
              ),
              control: .managedDate(initial: DateTime.now()),
              start: DateTime(2020),
              end: DateTime(2030),
              initialMonth: DateTime.now(),
              initialType: FCalendarPickerType.day,
            ),
          ),
        ),
      ),
    );
  }
}
