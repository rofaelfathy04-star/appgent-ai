import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';
  bool _loading = false;

  Future<void> _generateApp() async {
    setState(() { _loading = true; _response = ''; });
    const apiKey = String.fromEnvironment('OPENAI_API_KEY');

    if (apiKey.isEmpty) {
      setState(() { _response = 'حط مفتاح OpenAI في GitHub Secrets'; _loading = false; });
      return;
    }

    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $apiKey'},
        body: jsonEncode({
          'model': 'gpt-4o-mini',
          'messages': [{'role': 'user', 'content': 'اعملي كود Flutter لهذه الفكرة: ${_controller.text}'}],
        }),
      );
      setState(() {
        _response = res.statusCode == 200
         ? jsonDecode(res.body)['choices'][0]['message']['content']
          : 'خطأ: ${res.statusCode}';
        _loading = false;
      });
    } catch (e) {
      setState(() { _response = 'خطأ: $e'; _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI App Builder')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _controller, decoration: const InputDecoration(labelText: 'اكتب فكرة التطبيق', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _loading? null : _generateApp, child: _loading? const CircularProgressIndicator() : const Text('إنشاء')),
            const SizedBox(height: 16),
            Expanded(child: SingleChildScrollView(child: Text(_response))),
          ],
        ),
      ),
    );
  }
}
