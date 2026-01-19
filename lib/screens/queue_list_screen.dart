import 'package:flutter/material.dart';
import '../models/queue_item.dart';
import 'add_queue_screen.dart';
import 'queue_detail_screen.dart';

class QueueListScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const QueueListScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<QueueListScreen> createState() => _QueueListScreenState();
}

class _QueueListScreenState extends State<QueueListScreen> {
  List<QueueItem> queueList = [
    QueueItem(
        id: '1',
        customerName: 'สมชาย',
        people: 4,
        phone: '0698471452',
        queueNumber: 10),
    QueueItem(
        id: '2',
        customerName: 'สมหญิง',
        people: 2,
        phone: '0812345678',
        queueNumber: 11),
    QueueItem(
        id: '3',
        customerName: 'เอก',
        people: 4,
        phone: '0899999999',
        queueNumber: 12),
  ];

  String search = '';

  @override
  Widget build(BuildContext context) {
    final filteredList = queueList
        .where((q) => q.customerName.contains(search))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('จองคิว'),
        actions: [
          Switch(
            value: widget.isDarkMode,
            onChanged: (_) => widget.onToggleTheme(),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'ค้นหาลูกค้า',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => setState(() => search = value),
            ),
          ),
          Expanded(
            child: ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex--;
                  final item = queueList.removeAt(oldIndex);
                  queueList.insert(newIndex, item);
                });
              },
              children: filteredList.map((queue) {
                return Dismissible(
                  key: ValueKey(queue.id),
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      setState(() => queueList.remove(queue));
                      return true;
                    } else if (direction == DismissDirection.startToEnd) {
                      // แก้ไขข้อมูล
                      final editedQueue = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddQueueScreen(queue: queue),
                        ),
                      );
                      if (editedQueue != null) {
                        setState(() {});
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QueueDetailScreen(queue: editedQueue),
                          ),
                        );
                      }
                      return false;
                    }
                    return false;
                  },
                  child: Card(
                    key: ValueKey(queue.id),
                    child: ListTile(
                      title: Text('คุณ${queue.customerName}'),
                      subtitle: Text(
                          '${queue.people} คน | คิวที่ ${queue.queueNumber}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                QueueDetailScreen(queue: queue),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final newQueue = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddQueueScreen()),
          );
          if (newQueue != null) {
            setState(() => queueList.add(newQueue));
          }
        },
      ),
    );
  }
}
