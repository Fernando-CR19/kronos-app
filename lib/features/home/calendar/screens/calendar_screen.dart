import 'package:flutter/material.dart';
import 'package:kronos_app/features/home/calendar/widgets/kronos_calendar.dart';

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
            child: KronosCalendar(),
          ),
        ),
      ),
    );
  }
}
