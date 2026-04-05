import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  // 🎨 PET BREED AI WARM PALETTE
  static const Color beige = Color(0xFFF5E6D3);
  static const Color warmBrown = Color(0xFF8B5E3C);
  static const Color softOrange = Color(0xFFF4A261);
  static const Color greenAccent = Color(0xFF4CAF50);

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  final Map<DateTime, List<String>> _appointments = {};

  List<String> _getAppointmentsForDay(DateTime day) {
    return _appointments[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void _addAppointment() async {
    if (_selectedDay == null) return;

    TextEditingController controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: beige,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: const Text(
            "Book Appointment 🐾",
            style: TextStyle(color: warmBrown),
          ),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Enter appointment (Vet, Grooming...)",
              hintStyle: TextStyle(color: Colors.brown),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: warmBrown)),
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel",
                  style: TextStyle(color: warmBrown)),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: softOrange,
              ),
              child: const Text("Save"),
              onPressed: () {
                final dayKey = DateTime(
                    _selectedDay!.year,
                    _selectedDay!.month,
                    _selectedDay!.day);

                _appointments.putIfAbsent(dayKey, () => []);
                _appointments[dayKey]!.add(controller.text);

                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final selectedAppointments =
    _selectedDay == null ? [] : _getAppointmentsForDay(_selectedDay!);

    return Scaffold(
      backgroundColor: beige,
      appBar: AppBar(
        title: const Text("Pet Schedule 🐶"),
        backgroundColor: warmBrown,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: softOrange,
        onPressed: _addAppointment,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [

          /// CALENDAR
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) =>
                isSameDay(_selectedDay, day),
            eventLoader: _getAppointmentsForDay,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: softOrange,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: greenAccent,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: warmBrown,
                shape: BoxShape.circle,
              ),
              defaultTextStyle:
              TextStyle(color: warmBrown),
              weekendTextStyle:
              TextStyle(color: Colors.brown),
            ),
            headerStyle: const HeaderStyle(
              formatButtonTextStyle:
              TextStyle(color: Colors.white),
              formatButtonDecoration: BoxDecoration(
                color: softOrange,
                borderRadius:
                BorderRadius.all(Radius.circular(12)),
              ),
              titleTextStyle: TextStyle(
                  color: warmBrown,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              leftChevronIcon:
              Icon(Icons.chevron_left,
                  color: warmBrown),
              rightChevronIcon:
              Icon(Icons.chevron_right,
                  color: warmBrown),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle:
              TextStyle(color: warmBrown),
              weekendStyle:
              TextStyle(color: Colors.brown),
            ),
          ),

          const SizedBox(height: 10),

          /// APPOINTMENT LIST
          Expanded(
            child: selectedAppointments.isEmpty
                ? const Center(
              child: Text(
                "No Appointments 🐾",
                style: TextStyle(
                    color: warmBrown,
                    fontSize: 16),
              ),
            )
                : ListView.builder(
              itemCount: selectedAppointments.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(15)),
                  child: ListTile(
                    title: Text(
                      selectedAppointments[index],
                      style: const TextStyle(
                          color: warmBrown),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: greenAccent,
                      ),
                      onPressed: () {
                        final dayKey = DateTime(
                            _selectedDay!.year,
                            _selectedDay!.month,
                            _selectedDay!.day);

                        _appointments[dayKey]!
                            .removeAt(index);

                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}