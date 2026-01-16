import 'package:flutter/material.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF000000), Color(0xFF0B0B0B), Color(0xFF000000)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _header(context),
              const SizedBox(height: 14),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _salonCard(),
                      const SizedBox(height: 18),
                      _dateTimeRow(),
                      const SizedBox(height: 18),

                      // Ticket container
                      TicketBillContainer(child: _servicesBill()),

                      const SizedBox(height: 26),
                    ],
                  ),
                ),
              ),

              _bottomButtons(size),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(100),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.arrow_back, color: Colors.white, size: 22),
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            "Book Appointment",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- SALON CARD ----------------
  Widget _salonCard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            "https://images.unsplash.com/photo-1521590832167-7bcbfaa6381f?q=80&w=600&auto=format&fit=crop",
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Mirrors Luxury Salons",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "NBT Nagar, Banjara Hills...",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.star, size: 16, color: Color(0xFFFFC107)),
                  Icon(Icons.star, size: 16, color: Color(0xFFFFC107)),
                  Icon(Icons.star, size: 16, color: Color(0xFFFFC107)),
                  Icon(Icons.star, size: 16, color: Color(0xFFFFC107)),
                  Icon(Icons.star_border, size: 16, color: Colors.white38),
                ],
              ),
            ],
          ),
        ),

        Row(
          children: const [
            Icon(Icons.location_on_outlined, color: Colors.white54, size: 18),
            SizedBox(width: 4),
            Text(
              "2 km",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------- DATE TIME ----------------
  Widget _dateTimeRow() {
    return Row(
      children: const [
        Text(
          "Date & Time",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Spacer(),
        Text(
          "12 October, 11:00am",
          style: TextStyle(
            color: Color(0xFFFF4D5A),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  // ---------------- SERVICES BILL ----------------
  Widget _servicesBill() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Services",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 18),

          _rowItem("Regular haircut", "₹900"),
          const SizedBox(height: 14),
          _rowItem("Classic shaving", "₹400"),
          const SizedBox(height: 14),
          _rowItem("Service Charges", "₹90"),

          const SizedBox(height: 18),
          Divider(color: Colors.white.withOpacity(0.15), thickness: 1),
          const SizedBox(height: 18),

          _rowItem("Sub Total", "₹1390", isBold: true),
          const SizedBox(height: 14),
          _rowItem("Discount", "-₹200", valueColor: const Color(0xFFFF4D5A)),

          const SizedBox(height: 18),
          Divider(color: Colors.white.withOpacity(0.15), thickness: 1),
          const SizedBox(height: 18),

          _rowItem("Total", "₹1190", isBold: true, big: true),

          const SizedBox(height: 18),

          // payment card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF151515),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black.withOpacity(0.4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircleAvatar(radius: 6, backgroundColor: Colors.red),
                      SizedBox(width: 4),
                      CircleAvatar(radius: 6, backgroundColor: Colors.orange),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Samantha Martin",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "**** **** **** 8295",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.white54),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowItem(
    String title,
    String value, {
    bool isBold = false,
    bool big = false,
    Color valueColor = Colors.white,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white70,
            fontSize: big ? 16 : 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: big ? 18 : 14,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w700,
          ),
        ),
      ],
    );
  }

  // ---------------- BOTTOM BUTTONS ----------------
  Widget _bottomButtons(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          const Text(
            "Back",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Container(
            height: 54,
            width: size.width * 0.62,
            decoration: BoxDecoration(
              color: const Color(0xFFFF4D5A),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF4D5A).withOpacity(0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(width: 18),
                Text(
                  "₹890.00",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// Ticket Bill Container (dotted border + cut corners)
// ======================================================

class TicketBillContainer extends StatelessWidget {
  final Widget child;

  const TicketBillContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedTicketPainter(),
      child: ClipPath(
        clipper: _TicketClipper(),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF0F0F0F),
            borderRadius: BorderRadius.circular(22),
          ),
          child: child,
        ),
      ),
    );
  }
}

// Ticket shape with side cuts
class _TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const radius = 20.0;
    const cutRadius = 18.0;

    final path = Path();
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(radius),
      ),
    );

    // Left cut
    path.addOval(
      Rect.fromCircle(center: Offset(0, size.height * 0.78), radius: cutRadius),
    );

    // Right cut
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width, size.height * 0.78),
        radius: cutRadius,
      ),
    );

    return Path.combine(
      PathOperation.difference,
      path,
      Path()
        ..addOval(
          Rect.fromCircle(
            center: Offset(0, size.height * 0.78),
            radius: cutRadius,
          ),
        )
        ..addOval(
          Rect.fromCircle(
            center: Offset(size.width, size.height * 0.78),
            radius: cutRadius,
          ),
        ),
    );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Dotted border painter
class _DottedTicketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF4D5A)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(22),
    );

    final path = Path()..addRRect(rrect);

    const dashWidth = 6;
    const dashSpace = 4;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
