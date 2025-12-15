import 'package:flutter/material.dart';
import '../../../widgets/top_header.dart';
import '../../../colors/AppColors.dart';
import 'book_appointment_step3.dart';

class BookAppointmentStep2 extends StatefulWidget {
  final String serviceTitle;
  final DateTime selectedDate;

  const BookAppointmentStep2({
    super.key,
    required this.serviceTitle,
    required this.selectedDate,
  });

  @override
  State<BookAppointmentStep2> createState() => _BookAppointmentStep2State();
}

class _BookAppointmentStep2State extends State<BookAppointmentStep2> {
  String? selectedTime;

  final List<String> timeSlots = [
    "09:00 AM", "10:00 AM", "11:00 AM",
    "12:00 PM", "02:00 PM", "03:00 PM",
    "04:00 PM", "05:00 PM", "06:00 PM",
    "07:00 PM",
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.black.withOpacity(0.25),
      body: SafeArea(
        child: Column(
          children: [
            const TopHeader(),

            Expanded(
              child: Center(
                child: Container(
                  width: w * 0.9,
                  padding: EdgeInsets.all(w * 0.04),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(w * 0.04),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      /// 🔝 TITLE + CLOSE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Book Appointment - ${widget.serviceTitle}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: w * 0.04,
                                color: AppColors.textDark,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.close,
                              size: w * 0.05,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: h * 0.02),

                      /// 🔢 STEPS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _stepDone(w),
                          _stepLine(active: true, w: w),
                          _stepCircle("2", true, w),
                          _stepLine(active: false, w: w),
                          _stepCircle("3", false, w),
                        ],
                      ),

                      SizedBox(height: h * 0.03),

                      /// ⏰ SELECT TIME
                      Text(
                        "Select Time",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: w * 0.045,
                          color: AppColors.textDark,
                        ),
                      ),

                      SizedBox(height: h * 0.006),

                      Text(
                        _formattedDate(widget.selectedDate),
                        style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: w * 0.035,
                        ),
                      ),

                      SizedBox(height: h * 0.03),

                      /// ⏱ TIME SLOTS
                      Wrap(
                        spacing: w * 0.025,
                        runSpacing: w * 0.025,
                        children: timeSlots.map((time) {
                          final isSelected = selectedTime == time;
                          return GestureDetector(
                            onTap: () {
                              setState(() => selectedTime = time);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: w * 0.04,
                                vertical: h * 0.012,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(w * 0.025),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.border,
                                ),
                                color: isSelected
                                    ? AppColors.primary.withOpacity(0.1)
                                    : AppColors.white,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: w * 0.04,
                                    color: AppColors.primary,
                                  ),
                                  SizedBox(width: w * 0.015),
                                  Text(
                                    time,
                                    style: TextStyle(
                                      fontSize: w * 0.035,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      SizedBox(height: h * 0.035),

                      /// 🔘 BUTTONS
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side: const BorderSide(color: AppColors.primary),
                                padding:
                                EdgeInsets.symmetric(vertical: h * 0.018),
                              ),
                              child: Text(
                                "Back",
                                style: TextStyle(fontSize: w * 0.04),
                              ),
                            ),
                          ),

                          SizedBox(width: w * 0.03),

                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding:
                                EdgeInsets.symmetric(vertical: h * 0.018),
                              ),
                              onPressed: selectedTime == null
                                  ? null
                                  : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        BookAppointmentStep3(
                                          serviceTitle: widget.serviceTitle,
                                          selectedDate: widget.selectedDate,
                                          selectedTime: selectedTime!,
                                        ),
                                  ),
                                );
                              },
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                  fontSize: w * 0.04,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 HELPERS
  Widget _stepCircle(String text, bool active, double w) {
    return CircleAvatar(
      radius: w * 0.035,
      backgroundColor:
      active ? AppColors.primary : AppColors.border,
      child: Text(
        text,
        style: TextStyle(
          color: active ? AppColors.white : AppColors.textDark,
          fontSize: w * 0.035,
        ),
      ),
    );
  }

  Widget _stepDone(double w) {
    return CircleAvatar(
      radius: w * 0.035,
      backgroundColor: AppColors.primary,
      child: Icon(Icons.check, size: w * 0.04, color: AppColors.white),
    );
  }

  Widget _stepLine({required bool active, required double w}) {
    return Container(
      width: w * 0.07,
      height: 2,
      color: active ? AppColors.primary : AppColors.border,
    );
  }

  String _formattedDate(DateTime date) {
    return "${_dayName(date.weekday)}, ${date.day} ${_monthName(date.month)} ${date.year}";
  }

  String _dayName(int day) =>
      ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][day - 1];

  String _monthName(int month) =>
      ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][month - 1];
}
