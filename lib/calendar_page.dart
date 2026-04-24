import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'notification_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CalendarPage extends StatefulWidget {
  final String? initialPayload;

  const CalendarPage({super.key, this.initialPayload});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // 🎨 COLORS
  static const Color beige = Color(0xFFF5E6D3);
  static const Color warmBrown = Color(0xFF8B5E3C);
  static const Color softOrange = Color(0xFFF4A261);

  final supabase = Supabase.instance.client;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  Map<DateTime, List<Map<String, dynamic>>> _appointments = {};

  DateTime _normalize(DateTime day) =>
      DateTime(day.year, day.month, day.day);

  @override
  void initState() {
    super.initState();

    _loadAppointments();

    /// 🔔 HANDLE NOTIFICATION CLICK
    if (widget.initialPayload != null) {
      final parts = widget.initialPayload!.split('|');
      final date = DateTime.parse(parts[0]);

      _selectedDay = date;
      _focusedDay = date;

      /// refresh UI after navigation
      Future.delayed(const Duration(milliseconds: 300), () {
        _loadAppointments();
      });
    }
  }

  /// 🔄 LOAD FROM SUPABASE
  Future<void> _loadAppointments() async {
    try {
      final data = await supabase.from('appointments').select();

      _appointments.clear();

      for (var item in data) {
        if (item['datetime'] == null) continue;

        final dt = DateTime.parse(item['datetime']);
        final key = _normalize(dt);

        _appointments.putIfAbsent(key, () => []);
        _appointments[key]!.add(item);
      }

      setState(() {});
    } catch (e) {
      print("❌ Load Error: $e");
    }
  }

  List<Map<String, dynamic>> _getAppointmentsForDay(DateTime day) {
    return _appointments[_normalize(day)] ?? [];
  }

  /// 🔔 ADD APPOINTMENT
  void _addAppointment() async {
    TextEditingController controller = TextEditingController();
    TimeOfDay? selectedTime;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: beige,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            "Add Appointment 🐾",
            style: TextStyle(
              color: warmBrown,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Enter appointment",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: softOrange,
                ),
                onPressed: () async {
                  selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                },
                child: const Text("Select Time"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel",
                  style: TextStyle(color: warmBrown)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: softOrange,
              ),
              onPressed: () async {
                String text = controller.text.trim();

                if (text.isEmpty || selectedTime == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Enter text & select time")),
                  );
                  return;
                }

                final DateTime fullDateTime = DateTime(
                  _selectedDay.year,
                  _selectedDay.month,
                  _selectedDay.day,
                  selectedTime!.hour,
                  selectedTime!.minute,
                );

                /// ☁️ SAVE TO SUPABASE
                try {
                  await supabase.from('appointments').insert({
                    'title': text,
                    'datetime': fullDateTime.toIso8601String(),
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: $e")),
                  );
                  return;
                }

                /// 🔔 NOTIFICATION
                await NotificationService.scheduleNotification(
                  id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                  title: "Pet Appointment 🐾",
                  body: text,
                  scheduledTime: fullDateTime,
                  payload:
                  "${fullDateTime.toIso8601String()}|$text",
                );

                /// ⏰ REMINDER
                await NotificationService.scheduleNotification(
                  id: DateTime.now().millisecondsSinceEpoch ~/ 1000 + 1,
                  title: "Reminder ⏰",
                  body: "$text in 10 minutes",
                  scheduledTime:
                  fullDateTime.subtract(const Duration(minutes: 10)),
                  payload:
                  "${fullDateTime.toIso8601String()}|$text",
                );

                await _loadAppointments();

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Appointment Saved 🔔")),
                );
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  /// 🗑 DELETE
  void _deleteAppointment(String id) async {
    await supabase.from('appointments').delete().eq('id', id);

    await _loadAppointments();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Deleted")),
    );
  }

  /// ⏰ FORMAT TIME
  String _formatDateTime(String iso) {
    final dt = DateTime.parse(iso);
    final time = TimeOfDay.fromDateTime(dt);
    return "${dt.day}/${dt.month}/${dt.year} - ${time.format(context)}";
  }

  @override
  Widget build(BuildContext context) {
    final selectedAppointments =
    _getAppointmentsForDay(_selectedDay);

    return Scaffold(
      backgroundColor: beige,
      appBar: AppBar(
        title: const Text("Pet Schedule 🐶"),
        backgroundColor: warmBrown,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton(
          onPressed: _addAppointment,
          backgroundColor: softOrange,
          child: const Icon(Icons.add),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020),
            lastDay: DateTime.utc(2035),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) =>
                isSameDay(day, _selectedDay),

            /// 🔵 SHOW DOTS
            eventLoader: (day) =>
                _getAppointmentsForDay(day),

            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),

          Expanded(
            child: selectedAppointments.isEmpty
                ? const Center(
                child: Text("No Appointments 🐾"))
                : ListView.builder(
              itemCount: selectedAppointments.length,
              itemBuilder: (context, index) {
                final item = selectedAppointments[index];

                return ListTile(
                  title: Text(item['title'] ?? ''),
                  subtitle:
                  Text(_formatDateTime(item['datetime'])),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        _deleteAppointment(item['id'].toString()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}