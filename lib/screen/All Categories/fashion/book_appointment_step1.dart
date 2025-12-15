import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/screen/All%20Categories/fashion/book_appointment_step2.dart';
import '../../../widgets/top_header.dart';
import '../../../colors/AppColors.dart';

class BookAppointmentStep1 extends StatefulWidget {
  final String serviceTitle;

  const BookAppointmentStep1({super.key, required this.serviceTitle});

  @override
  State<BookAppointmentStep1> createState() => _BookAppointmentStep1State();
}

class _BookAppointmentStep1State extends State<BookAppointmentStep1> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.black.withOpacity(0.25),
      body: SafeArea(
        child: Column(
          children: [
            /// 🔵 TOP HEADER
            const TopHeader(),

            Expanded(
              child: Center(
                child: Container(
                  width: w * 0.9,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(w * 0.04),
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
                            _stepCircle("1", true),
                            _stepLine(),
                            _stepCircle("2", false),
                            _stepLine(),
                            _stepCircle("3", false),
                          ],
                        ),

                        SizedBox(height: h * 0.03),

                        /// 📅 SELECT DATE
                        Text(
                          "Select Date",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: w * 0.045,
                            color: AppColors.textDark,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "Choose your preferred appointment date",
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: w * 0.035,
                          ),
                        ),

                        SizedBox(height: h * 0.02),

                        /// 📆 CALENDAR
                        Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: AppColors.primary,
                              onPrimary: AppColors.white,
                              onSurface: AppColors.textDark,
                            ),
                          ),
                          child: CalendarDatePicker(
                            initialDate: selectedDate,
                            firstDate: DateTime.now(),
                            lastDate:
                            DateTime.now().add(const Duration(days: 365)),
                            onDateChanged: (date) {
                              setState(() {
                                selectedDate = date;
                              });
                            },
                          ),
                        ),

                        SizedBox(height: h * 0.02),

                        /// 🔘 CONTINUE BUTTON
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding:
                              const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BookAppointmentStep2(
                                    serviceTitle: widget.serviceTitle,
                                    selectedDate: selectedDate,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "Continue",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 STEP CIRCLE
  Widget _stepCircle(String text, bool active) {
    return CircleAvatar(
      radius: 14,
      backgroundColor:
      active ? AppColors.primary : AppColors.border,
      child: Text(
        text,
        style: TextStyle(
          color: active ? AppColors.white : AppColors.textDark,
          fontSize: 12,
        ),
      ),
    );
  }

  // 🔹 STEP LINE
  Widget _stepLine() {
    return Container(
      width: 30,
      height: 2,
      color: AppColors.border,
    );
  }
}
