import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../../data/models/story_model.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/story_service.dart';
import '../../../core/constants/app_constants.dart';

class ReadStoryScreen extends StatefulWidget {
  final int storyId;

  const ReadStoryScreen({super.key, required this.storyId});

  @override
  State<ReadStoryScreen> createState() => _ReadStoryScreenState();
}

class _ReadStoryScreenState extends State<ReadStoryScreen> {
  Story? _story;
  String? _textContent;
  Uint8List? _pdfBytes;
  bool _isLoadingStory = true;
  bool _isLoadingFile = false;
  String? _error;
  double _fontSize = 17.0;

  @override
  void initState() {
    super.initState();
    _loadStory();
  }

  Future<void> _loadStory() async {
    setState(() {
      _isLoadingStory = true;
      _error = null;
    });

    final story = await StoryService().getStory(widget.storyId);
    if (!mounted) return;

    if (story == null) {
      setState(() {
        _error = 'فشل في تحميل القصة';
        _isLoadingStory = false;
      });
      return;
    }

    setState(() {
      _story = story;
      _isLoadingStory = false;
    });

    await _loadFile(story);
  }

  Future<void> _loadFile(Story story) async {
    if (story.filePath == null) return;

    setState(() => _isLoadingFile = true);

    try {
      String url = story.filePath!;
      if (!url.startsWith('http')) {
        url = '${AppConstants.baseUrl}$url';
      }

      final bytes = await ApiService().downloadBytes(url);

      if (!mounted) return;
      if (story.isPdf) {
        setState(() {
          _pdfBytes = bytes;
          _isLoadingFile = false;
        });
      } else {
        setState(() {
          _textContent = utf8.decode(bytes);
          _isLoadingFile = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'فشل في تحميل الملف';
        _isLoadingFile = false;
      });
    }
  }

  void _showTranslateDialog(BuildContext context, String text) {
    String sourceLang = 'ar';
    String targetLang = 'en';
    String? result;
    bool translating = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          title: const Text('ترجمة'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontStyle: FontStyle.italic)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: sourceLang,
                        decoration: const InputDecoration(labelText: 'من'),
                        items: AppConstants.languageLabels.entries
                            .map((e) => DropdownMenuItem(
                                value: e.key, child: Text(e.value)))
                            .toList(),
                        onChanged: (v) => setS(() => sourceLang = v!),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: targetLang,
                        decoration: const InputDecoration(labelText: 'إلى'),
                        items: AppConstants.languageLabels.entries
                            .map((e) => DropdownMenuItem(
                                value: e.key, child: Text(e.value)))
                            .toList(),
                        onChanged: (v) => setS(() => targetLang = v!),
                      ),
                    ),
                  ],
                ),
                if (translating) ...[
                  const SizedBox(height: 16),
                  const Center(child: CircularProgressIndicator()),
                ],
                if (result != null) ...[
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(result!, style: const TextStyle(height: 1.6)),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx), child: const Text('إغلاق')),
            FilledButton(
              onPressed: translating
                  ? null
                  : () async {
                      setS(() => translating = true);
                      final translated = await StoryService()
                          .translateText(text, sourceLang, targetLang);
                      setS(() {
                        result = translated ?? 'فشلت الترجمة';
                        translating = false;
                      });
                    },
              child: const Text('ترجم'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingStory) {
      return Scaffold(
        appBar: AppBar(title: const Text('القراءة')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null && _story == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('القراءة')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text(_error!),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _loadStory,
                icon: const Icon(Icons.refresh),
                label: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_story?.title ?? 'القراءة'),
        actions: [
          IconButton(
            icon: const Icon(Icons.text_decrease),
            onPressed: () => setState(() => _fontSize = (_fontSize - 2).clamp(12.0, 32.0)),
          ),
          IconButton(
            icon: const Icon(Icons.text_increase),
            onPressed: () => setState(() => _fontSize = (_fontSize + 2).clamp(12.0, 32.0)),
          ),
        ],
      ),
      body: _isLoadingFile
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('جاري تحميل الملف...'),
                ],
              ),
            )
          : _story?.isPdf == true
              ? _buildPdfView()
              : _buildTextView(context),
    );
  }

  Widget _buildPdfView() {
    if (_pdfBytes == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.picture_as_pdf, size: 64),
            const SizedBox(height: 16),
            const Text('فشل في تحميل ملف PDF'),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _loadFile(_story!),
              icon: const Icon(Icons.refresh),
              label: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      );
    }

    return PDFView(
      pdfData: _pdfBytes!,
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: false,
      pageFling: false,
    );
  }

  Widget _buildTextView(BuildContext context) {
    if (_textContent == null) {
      return const Center(child: Text('لا يوجد محتوى للقراءة'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: SelectableText(
        _textContent!,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(height: 1.9, fontSize: _fontSize),
        contextMenuBuilder: (ctx, editableTextState) {
          final selection = editableTextState.textEditingValue.selection;
          final selected = selection.textInside(
              editableTextState.textEditingValue.text);
          final items = editableTextState.contextMenuButtonItems;
          if (selected.isNotEmpty) {
            items.add(
              ContextMenuButtonItem(
                label: 'ترجم',
                onPressed: () {
                  ContextMenuController.removeAny();
                  _showTranslateDialog(context, selected);
                },
              ),
            );
          }
          return AdaptiveTextSelectionToolbar.buttonItems(
            anchors: editableTextState.contextMenuAnchors,
            buttonItems: items,
          );
        },
      ),
    );
  }
}
