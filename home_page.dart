import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'generate/generate_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _ideaController = TextEditingController();
  final List<String> _examples = [
    "تطبيق متجر إلكتروني لبيع العطور",
    "تطبيق مذكرات يومية مع تذكير",
    "تطبيق حجز مواعيد لصالون حلاقة",
  ];

  void _startGenerating() {
    if (_ideaController.text.trim().isEmpty) return;
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => GeneratePage(idea: _ideaController.text.trim()),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AppGen AI')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('اكتب فكرتك وحولها لتطبيق حقي',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold))
            .animate().fadeIn().slideY(begin: -0.2),
          const SizedBox(height: 20),
          TextField(
            controller: _ideaController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'مثال: أريد تطبيق لمحل ورد مع الدفع الإلكتروني',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              filled: true,
            ),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _startGenerating,
              child: const Text('ابدأ التوليد', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ).animate().fadeIn(delay: 400.ms),
        ]),
      ),
    );
  }
}