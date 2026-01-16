import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  bool showUpcoming = true;
  BorderRadius dynamicBorder = const BorderRadius.only(
    topLeft: Radius.circular(20),
    bottomLeft: Radius.circular(20),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 15,
            children: [
              _buildHeader(),
              //_buildTabs(),
              _customSlideTabs(),
              Expanded(child: _buildAppointmentList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customSlideTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 15),
      child: CustomSlidingSegmentedControl<int>(
        fromMax: true,
        isStretch: true,
        initialValue: 1,
        height: 50,
        padding: 10,
        children: {
          1: Text('Upcoming'),
          2: Text('Past'),
        },
        innerPadding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.shade700,
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside
          ),
        ),
        thumbDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:  Colors.redAccent,
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside
          ),
        ),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInToLinear,
        clipBehavior: Clip.none,
        onValueChanged: (v) {
          print(v);
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Your Appointments",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            _circleButton(Icons.map_outlined),
            const SizedBox(width: 10),
            _circleButton(Icons.filter_list),
          ],
        ),
      ],
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 22),
    );
  }

  Widget _buildTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _tabButton(
          "Upcoming",
          isActive: showUpcoming,
          onTap: () {
            setState(() => showUpcoming = true);
          },
        ),
        const SizedBox(width: 12),
        _tabButton(
          "Past",
          isActive: !showUpcoming,
          onTap: () {
            setState(() => showUpcoming = false);
          },
        ),
      ],
    );
  }

  Widget _tabButton(
    String title, {
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive ? Colors.redAccent : Colors.grey.shade700,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isActive ? Colors.redAccent.withOpacity(0.1) : Colors.transparent,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.redAccent : Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentList() {
    final appointments = [
      {
        "date": "10 October 2025, 08:00",
        "name": "Jawed Habib",
        "address": "6391 Elgin St. Celina, Delaware",
        "services": "Regular haircut, Classic shaving",
        "image": "assets/onboard_images/1.jpg",
        "reminder": "30 min before",
      },
      {
        "date": "10 October 2025, 16:30",
        "name": "Green Apple",
        "address": "8502 Preston Rd. Inglewood, Maine",
        "services": "Regular haircut, Classic shaving",
        "image": "assets/onboard_images/1.jpg",
        "reminder": "Remind me",
      },
      {
        "date": "10 October 2025, 20:00",
        "name": "The Galleria",
        "address": "4813 Cambria Rd. Los Angeles",
        "services": "Regular haircut, Classic shaving",
        "image": "assets/onboard_images/1.jpg",
        "reminder": "30 min before",
      },
    ];

    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final item = appointments[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _appointmentCard(item),
        );
      },
    );
  }

  Widget _appointmentCard(Map<String, String> item) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      shadowColor: Colors.white60,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(18),
      // ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item["date"]!,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    item["image"]!,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["name"]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item["address"]!,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Services: ${item["services"]!}",
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Switch(
                      value: true,
                      activeColor: Colors.redAccent,
                      onChanged: (v) {},
                    ),
                    Text(
                      item["reminder"]!,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade700),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  child: const Text("Cancel", style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
