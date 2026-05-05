import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/services/api_service.dart';
import '../../../core/constants/app_constants.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({super.key});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String _genre = 'fiction';
  String _language = 'ar';
  String? _filePath;
  String? _fileName;
  bool _isUploading = false;
  String? _error;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'txt'],
    );
    if (result != null) {
      setState(() {
        _filePath = result.files.first.path;
        _fileName = result.files.first.name;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_filePath == null) {
      setState(() => _error = 'يرجى اختيار ملف القصة (PDF أو TXT)');
      return;
    }

    setState(() {
      _isUploading = true;
      _error = null;
    });

    try {
      final response = await ApiService().multipartPost(
        ApiEndpoints.stories,
        fields: {
          'title': _titleCtrl.text.trim(),
          'description': _descCtrl.text.trim(),
          'genre': _genre,
          'language': _language,
        },
        fileField: 'file_path',
        filePath: _filePath!,
        fileName: _fileName!,
      );

      if (!mounted) return;

      if (response.statusCode == 201 || response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم رفع القصة بنجاح ✓')),
        );
        context.pop();
      } else {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final msg = data.values
            .whereType<List>()
            .expand((e) => e)
            .join(', ');
        setState(() {
          _error = msg.isNotEmpty ? msg : (data['detail']?.toString() ?? 'فشل في رفع القصة');
          _isUploading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'حدث خطأ: $e';
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('رفع قصة جديدة')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(
                    labelText: 'عنوان القصة *',
                    prefixIcon: Icon(Icons.title)),
                validator: (v) => (v == null || v.isEmpty) ? 'العنوان مطلوب' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(
                    labelText: 'وصف القصة',
                    prefixIcon: Icon(Icons.description_outlined)),
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _genre,
                decoration: const InputDecoration(labelText: 'التصنيف'),
                items: AppConstants.genres
                    .map((g) => DropdownMenuItem(
                          value: g,
                          child: Text(AppConstants.genreLabels[g] ?? g),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _genre = v!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _language,
                decoration: const InputDecoration(labelText: 'لغة القصة'),
                items: AppConstants.languages
                    .map((l) => DropdownMenuItem(
                          value: l,
                          child: Text(AppConstants.languageLabels[l] ?? l),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _language = v!),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.attach_file),
                label: Text(_fileName ?? 'اختر ملف القصة (PDF أو TXT)'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  alignment: Alignment.centerRight,
                ),
              ),
              if (_fileName != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(_fileName!,
                            style: theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
              if (_error != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(_error!,
                      style: TextStyle(color: theme.colorScheme.error)),
                ),
              ],
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _isUploading ? null : _submit,
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                child: _isUploading
                    ? const SizedBox(
                        height: 20, width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2,
                            color: Colors.white))
                    : const Text('رفع القصة'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
