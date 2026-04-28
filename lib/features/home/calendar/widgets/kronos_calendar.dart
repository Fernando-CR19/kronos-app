import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forui/forui.dart';

class KronosCalendar extends StatelessWidget {
  final DateTime? selectedDate;
  final void Function(DateTime?)? onDateSelected;

  const KronosCalendar({super.key, this.selectedDate, this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return FCalendar(
      control: .managedDate(initial: selectedDate ?? DateTime.now()),
      start: DateTime(2020),
      end: DateTime(2030),
      today: DateTime.now(),
      initialMonth: selectedDate ?? DateTime.now(),
      initialType: FCalendarPickerType.day,
      style: (style) => style.copyWith(
        decoration: BoxDecoration(color: Colors.transparent),
        padding: EdgeInsets.only(top: 24),
        dayPickerStyle: (dayStyle) => dayStyle.copyWith(
          tileSize: MediaQuery.of(context).size.width / 7,
          enclosing: (enclosing) => enclosing.copyWith(
            backgroundColor: FWidgetStateMap({
              WidgetState.any: Colors.transparent,
            }),
          ),
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
        ),
        yearMonthPickerStyle: (yearStyle) => yearStyle.copyWith(
          backgroundColor: FWidgetStateMap({
            WidgetState.any: Colors.transparent,
          }),
          borderColor: FWidgetStateMap({WidgetState.any: Colors.transparent}),
          radius: Radius.circular(12.r),
          textStyle: FWidgetStateMap({
            WidgetState.selected: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            WidgetState.any: TextStyle(color: Colors.white),
          }),
        ),
      ),
    );
  }
}
