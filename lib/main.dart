import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/*
  قائمة المهام المستقبلية للتطبيق:
  ✓ 1- إضافة app bar مع Drawer في الجهة اليمنى
  ✓ 2- إضافة أيقونة التصفية (Filter)
  3- إضافة ميزة Hot Reload (ميزة بيئة التطوير)
  ✓ 4- إضافة الوضع المظلم (Dark Mode)
  5- ربط التطبيق مع API
  6- إضافة تشفير للبيانات
  ✓ 7- تحسين الوصولية (Accessibility)
  ✓ 8- إضافة أزرار التفاعل (إعجاب، مشاركة، حفظ)
  9- إضافة زر لعرض حسابات المشروع
  ✓ 10- تحسين التنقل بين الصفحات
*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // دعم اللغة العربية
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // الثيم الفاتح
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        chipTheme: ChipThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // الثيم المظلم
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        chipTheme: ChipThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      themeMode: _themeMode,

      home: HomePage(onToggleTheme: _toggleTheme),
    );
  }
}

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const HomePage({super.key, required this.onToggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

// الفئات
final List<String> categories = [
  'الكل',
  'كوميديا',
  'خيال علمي',
  'خيال',
  'رومانسي',
  'جريمة وتحقيق',
  'رعب',
  'مغامرة',
  'دراما',
  'تاريخي',
  'سرقة',
  'حرب',
  'فانتازي',
  'أطفال',
];

class _HomePageState extends State<HomePage> {
  String _selectedFilter = 'الكل';

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تصفية القصص'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: categories.map((filter) {
              return RadioListTile<String>(
                title: Text(filter),
                value: filter,
                // ignore: deprecated_member_use
                groupValue: _selectedFilter,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    _selectedFilter = value!;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.primaryContainer,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: theme.colorScheme.surface,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'عوالمنا',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('الصفحة الرئيسية'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('قائمة القراءة لاحقاً'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('قريباً: قائمة القراءة')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('الحساب'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('قريباً: صفحة الحساب')),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Theme.of(context).brightness == Brightness.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              title: Text(
                Theme.of(context).brightness == Brightness.light
                    ? 'الوضع المظلم'
                    : 'الوضع الفاتح',
              ),
              onTap: () {
                widget.onToggleTheme();
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('الإعدادات'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('قريباً: الإعدادات')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('حول التطبيق'),
              onTap: () {
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationName: 'عوالمنا',
                  applicationVersion: '1.0.0',
                  applicationIcon: const Icon(Icons.book, size: 48),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("عوالمنا"),
        actions: [
          IconButton(
            onPressed: _showFilterDialog,
            icon: const Icon(Icons.filter_list),
            tooltip: "تصفية",
          ),
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: StorySearchDelegate(),
              );
            },
            icon: const Icon(Icons.search),
            tooltip: "بحث",
          ),
        ],
      ),
      body: SafeArea(
        child: _selectedFilter == 'الكل'
            ? const StoryList()
            : StoryList(filterCategory: _selectedFilter),
      ),
    );
  }
}

// محرك البحث
class StorySearchDelegate extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'ابحث عن قصة...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_forward),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(child: Text('نتائج البحث ستظهر هنا'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('ابدأ الكتابة للبحث...'));
  }
}

// قائمة القصص
class StoryList extends StatelessWidget {
  final String? filterCategory;

  const StoryList({super.key, this.filterCategory});

  static const List<Map<String, dynamic>> stories = [
    // القصة الأولى
    {
      'title': 'رحلة بين العوالم',
      'author': 'أسامة الحضيف',
      'description':
          'قصة خيالية تدور حول مغامر يدخل عوالم مختلفة ويواجه تحديات غامضة.',
      'categories': ['خيال', 'مغامرة', 'دراما'],
      'likes': 245,
      'views': 1520,
    },
    // القصة الثانية
    {
      'title': 'المدينة المفقودة',
      'author': 'حسام الحضيف',
      'description':
          'قصة تدور حول مدينة مفقودة يتم البحث عنها وتكشف أسراراً غامضة.',
      'categories': ['رومانسي', 'مغامرة', 'دراما'],
      'likes': 189,
      'views': 980,
    },
    // القصة الثالثة
    {
      'title': 'الظل الأخير',
      'author': 'محمد الحضيف',
      'description':
          'قصة إثارة وتشويق حول شخصية تحاول الهروب من ماضيها المظلم.',
      'categories': ['رومانسي', 'دراما'],
      'likes': 312,
      'views': 2100,
    },
    // القصة الرابعة
    {
      'title': 'أسرار الغابة',
      'author': 'صلاح الحضيف',
      'description':
          'قصة مغامرة تدور في غابة مليئة بالأسرار والمخلوقات الغامضة.',
      'categories': ['رومانسي', 'مغامرة', 'دراما'],
      'likes': 156,
      'views': 670,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredStories = filterCategory == null
        ? stories
        : stories.where((story) {
            final categories = story['categories'] as List<String>;
            return categories.contains(filterCategory);
          }).toList();

    if (filteredStories.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'لا توجد قصص في هذا التصنيف',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: filteredStories.length,
      itemBuilder: (context, index) {
        final story = filteredStories[index];
        return StoryCard(
          title: story['title'] as String,
          author: story['author'] as String,
          description: story['description'] as String,
          categories: List<String>.from(story['categories'] as List),
          likes: story['likes'] as int,
          views: story['views'] as int,
        );
      },
    );
  }
}

// بطاقة القصة
class StoryCard extends StatefulWidget {
  final String title;
  final String author;
  final String description;
  final List<String> categories;
  final int likes;
  final int views;

  const StoryCard({
    super.key,
    required this.title,
    required this.author,
    required this.description,
    required this.categories,
    required this.likes,
    required this.views,
  });

  @override
  State<StoryCard> createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard> {
  bool _isLiked = false;
  bool _isSaved = false;
  late int _currentLikes;

  @override
  void initState() {
    super.initState();
    _currentLikes = widget.likes;
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _currentLikes += _isLiked ? 1 : -1;
    });
  }

  void _toggleSave() {
    setState(() {
      _isSaved = !_isSaved;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            _isSaved ? 'تمت الإضافة للقراءة لاحقاً' : 'تمت الإزالة من القائمة'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _shareStory() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('قريباً: مشاركة القصة'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('فتح قصة: ${widget.title}')),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // العنوان والمؤلف
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: 16,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.author,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // زر الحفظ
                  IconButton(
                    onPressed: _toggleSave,
                    icon: Icon(
                      _isSaved ? Icons.bookmark : Icons.bookmark_border,
                      color: _isSaved ? theme.colorScheme.primary : null,
                    ),
                    tooltip:
                        _isSaved ? 'إزالة من القائمة' : 'حفظ للقراءة لاحقاً',
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // الوصف
              Text(
                widget.description,
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 12),

              // التصنيفات
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.categories.map((cat) {
                  return Chip(
                    label: Text(cat),
                    labelStyle: theme.textTheme.labelMedium,
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 8),

              // أزرار التفاعل
              Row(
                children: [
                  // زر الإعجاب
                  IconButton(
                    onPressed: _toggleLike,
                    icon: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      color: _isLiked ? Colors.red : null,
                    ),
                    tooltip: 'إعجاب',
                  ),
                  Text('$_currentLikes'),

                  const SizedBox(width: 16),

                  // عدد المشاهدات
                  Icon(
                    Icons.visibility,
                    size: 20,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${widget.views}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),

                  const Spacer(),

                  // زر المشاركة
                  IconButton(
                    onPressed: _shareStory,
                    icon: const Icon(Icons.share),
                    tooltip: 'مشاركة',
                  ),

                  // زر القراءة
                  FilledButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('قراءة: ${widget.title}')),
                      );
                    },
                    icon: const Icon(Icons.book, size: 18),
                    label: const Text('اقرأ الآن'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
