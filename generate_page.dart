import 'package:flutter/material.dart';
import '../../core/ai_service.dart';

class GeneratePage extends StatefulWidget {
  final String idea;
  const GeneratePage({super.key, required this.idea});
  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  final AiService _aiService = AiService();
  String _status = "جاري توليد الكود...";
  String _generatedCode = "";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _generate();
  }

  Future<void> _generate() async {
    try {
      final result = await _aiService.generateAppCode(widget.idea);
      setState(() {
        _generatedCode = result;
        _status = "تم التوليد بنجاح!";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _status = "حدث خطأ: $e";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('توليد التطبيق')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Text('الفكرة: ${widget.idea}', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(children: [
            if (_isLoading) const CircularProgressIndicator(),
            const SizedBox(width: 10),
            Expanded(child: Text(_status)),
          ]),
          const SizedBox(height: 20),
          if (!_isLoading)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(12)),
                child: SingleChildScrollView(
                  child: SelectableText(_generatedCode,
                      style: const TextStyle(fontFamily: 'monospace', color: Colors.greenAccent, fontSize: 12)),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}