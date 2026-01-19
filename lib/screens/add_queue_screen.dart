import 'package:flutter/material.dart';
import '../models/queue_item.dart';
import 'queue_detail_screen.dart';

class AddQueueScreen extends StatefulWidget {
  final QueueItem? queue; // ⭐ ถ้ามี = แก้ไข

  const AddQueueScreen({super.key, this.queue});

  @override
  State<AddQueueScreen> createState() => _AddQueueScreenState();
}

class _AddQueueScreenState extends State<AddQueueScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameCtrl;
  late TextEditingController peopleCtrl;
  late TextEditingController phoneCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.queue?.customerName ?? '');
    peopleCtrl =
        TextEditingController(text: widget.queue?.people.toString() ?? '');
    phoneCtrl = TextEditingController(text: widget.queue?.phone ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.queue != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'แก้ไขข้อมูลคิว' : 'เพิ่มคิวใหม่'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'ชื่อลูกค้า'),
                validator: (v) =>
                    v!.isEmpty ? 'กรุณากรอกชื่อ' : null,
              ),
              TextFormField(
                controller: peopleCtrl,
                decoration: const InputDecoration(labelText: 'จำนวนคน'),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v!.isEmpty ? 'กรุณากรอกจำนวนคน' : null,
              ),
              TextFormField(
                controller: phoneCtrl,
                decoration: const InputDecoration(labelText: 'เบอร์โทร'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: Text(isEdit ? 'บันทึกการแก้ไข' : 'เพิ่มคิว'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (isEdit) {
                      // ✏️ แก้ไขข้อมูลเดิม
                      widget.queue!.customerName = nameCtrl.text;
                      widget.queue!.people =
                          int.parse(peopleCtrl.text);
                      widget.queue!.phone = phoneCtrl.text;
                      Navigator.pop(context, widget.queue);
                    } else {
                      // ➕ เพิ่มใหม่
                      Navigator.pop(
                        context,
                        QueueItem(
                          id: DateTime.now().toString(),
                          customerName: nameCtrl.text,
                          people: int.parse(peopleCtrl.text),
                          phone: phoneCtrl.text,
                          queueNumber: DateTime.now().millisecondsSinceEpoch % 100,
                        ),
                      );
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
