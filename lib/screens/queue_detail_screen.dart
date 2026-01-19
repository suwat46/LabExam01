import 'package:flutter/material.dart';
import '../models/queue_item.dart';

class QueueDetailScreen extends StatelessWidget {
  final QueueItem queue;

  const QueueDetailScreen({super.key, required this.queue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('รายละเอียดคิว')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ชื่อลูกค้า: ${queue.customerName}', style: const TextStyle(fontSize: 18)),
                Text('จำนวนคน: ${queue.people}', style: const TextStyle(fontSize: 18)),
                Text('เบอร์โทร: ${queue.phone}', style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}