import 'package:flutter/material.dart';
import '../../../widgets/top_header.dart';
import '../../../colors/AppColors.dart';

class BookAppointmentStep3 extends StatefulWidget {
  final String serviceTitle;
  final DateTime selectedDate;
  final String selectedTime;

  const BookAppointmentStep3({
    super.key,
    required this.serviceTitle,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  State<BookAppointmentStep3> createState() => _BookAppointmentStep3State();
}

class _BookAppointmentStep3State extends State<BookAppointmentStep3> {
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final requestCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

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
                    child: SingleChildScrollView(
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
                                    color: AppColors.textDark,
                                    fontSize: w * 0.042,
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

                          const SizedBox(height: 16),

                          /// 🔢 STEPS
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _stepDone(),
                              _stepLine(true),
                              _stepDone(),
                              _stepLine(true),
                              _stepCircle("3", true),
                            ],
                          ),

                          const SizedBox(height: 24),

                          /// 🧾 YOUR DETAILS
                          Text(
                            "Your Details",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            "Please provide your contact information",
                            style: TextStyle(color: AppColors.textGrey),
                          ),

                          const SizedBox(height: 20),

                          _inputField("Full Name *", Icons.person, nameCtrl),
                          _inputField("Phone Number *", Icons.phone, phoneCtrl),
                          _inputField("Email (Optional)", Icons.email, emailCtrl),
                          _inputField(
                            "Special Requests (Optional)",
                            Icons.note,
                            requestCtrl,
                            maxLines: 2,
                          ),

                          const SizedBox(height: 16),

                          /// 📋 SUMMARY
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Appointment Summary",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textDark,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text("Service: ${widget.serviceTitle}"),
                                Text("Date: ${_formattedDate(widget.selectedDate)}"),
                                Text("Time: ${widget.selectedTime}"),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          /// 🔘 BUTTONS
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColors.primary,
                                    side: const BorderSide(color: AppColors.primary),
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Back"),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    "Confirm Booking",
                                    style: TextStyle(color: AppColors.white),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 HELPERS
  Widget _inputField(
      String hint,
      IconData icon,
      TextEditingController ctrl, {
        int maxLines = 1,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColors.primary),
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.greyText),
          filled: true,
          fillColor: AppColors.bgLight,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _stepCircle(String text, bool active) {
    return CircleAvatar(
      radius: 14,
      backgroundColor:
      active ? AppColors.primary : AppColors.border,
      child: Text(
        text,
        style: TextStyle(
          color: active ? AppColors.white : AppColors.textDark,
        ),
      ),
    );
  }

  Widget _stepDone() {
    return const CircleAvatar(
      radius: 14,
      backgroundColor: AppColors.primary,
      child: Icon(Icons.check, size: 16, color: AppColors.white),
    );
  }

  Widget _stepLine(bool active) {
    return Container(
      width: 30,
      height: 2,
      color: active ? AppColors.primary : AppColors.border,
    );
  }

  String _formattedDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  void _confirmBooking(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Appointment booked successfully! You will receive a confirmation SMS.",
        ),
      ),
    );

    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
