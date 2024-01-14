import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminApp extends StatelessWidget {
  final CollectionReference userActivities = FirebaseFirestore.instance.collection('rentals');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      home: Scaffold(
        appBar: AppBar(
          title: Text('CMS Dashboard'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Statistik Trafik',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
             Container(
  height: 200,
  child: LineChart(
    LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1),
      ),
      minX: 0,
      maxX: 7,
      minY: 0,
      maxY: 6,
      backgroundColor: Colors.amber, // Tambahkan ini
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(1, 1),
            FlSpot(2, 4),
            FlSpot(3, 2),
            FlSpot(4, 5),
            FlSpot(5, 1),
            FlSpot(6, 4),
            FlSpot(7, 3),
          ],
          isCurved: true,
          color: Colors.black,
          dotData: FlDotData(show: false),
        ),
      ],
    ),
  ),
),

              SizedBox(height: 32),
              Text(
                'Aktivitas Pengguna',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: userActivities.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var activity = snapshot.data!.docs[index];
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              activity['nama'],
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Mobil: ${activity['mobil']} | Durasi: ${activity['durasi']} hari',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
