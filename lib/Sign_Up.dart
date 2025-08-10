import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'عوالمنا - إنشاء حساب',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[700],
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
      home: const RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DateTime? _birthDate;
  String? _selectedGender;
  String? _selectedAccountType;
  String? _selectedCountry;

  final List<String> _genders = ['ذكر', 'أنثى'];
  final List<String> _accountTypes = ['كاتب', 'قارئ'];
  final List<String> _countries = [
    "أفغانستان",
    "ألبانيا",
    "الجزائر",
    "أندورا",
    "أنغولا",
    "الأرجنتين",
    "أرمينيا",
    "أستراليا",
    "النمسا",
    "أذربيجان",
    "جزر البهاما",
    "البحرين",
    "بنغلاديش",
    "باربادوس",
    "بيلاروسيا",
    "بلجيكا",
    "بليز",
    "بنين",
    "بوتان",
    "بوليفيا",
    "البوسنة والهرسك",
    "بوتسوانا",
    "البرازيل",
    "بروناي",
    "بلغاريا",
    "بوركينا فاسو",
    "بوروندي",
    "الرأس الأخضر",
    "كمبوديا",
    "الكاميرون",
    "كندا",
    "جمهورية أفريقيا الوسطى",
    "تشاد",
    "تشيلي",
    "الصين",
    "كولومبيا",
    "جزر القمر",
    "جمهورية الكونغو الديمقراطية",
    "جمهورية الكونغو",
    "كوستاريكا",
    "كرواتيا",
    "كوبا",
    "قبرص",
    "جمهورية التشيك",
    "الدنمارك",
    "جيبوتي",
    "دومينيكا",
    "جمهورية الدومينيكان",
    "الإكوادور",
    "مصر",
    "السلفادور",
    "غينيا الاستوائية",
    "إريتريا",
    "إستونيا",
    "إسواتيني",
    "إثيوبيا",
    "فيجي",
    "فنلندا",
    "فرنسا",
    "الغابون",
    "غامبيا",
    "جورجيا",
    "ألمانيا",
    "غانا",
    "اليونان",
    "غرينادا",
    "غواتيمالا",
    "غينيا",
    "غينيا بيساو",
    "غيانا",
    "هايتي",
    "هندوراس",
    "المجر",
    "آيسلندا",
    "الهند",
    "إندونيسيا",
    "إيران",
    "العراق",
    "أيرلندا",
    "إسرائيل",
    "إيطاليا",
    "جامايكا",
    "اليابان",
    "الأردن",
    "كازاخستان",
    "كينيا",
    "كيريباتي",
    "الكويت",
    "قيرغيزستان",
    "لاوس",
    "لاتفيا",
    "لبنان",
    "ليسوتو",
    "ليبيريا",
    "ليبيا",
    "ليختنشتاين",
    "ليتوانيا",
    "لوكسمبورغ",
    "مدغشقر",
    "مالاوي",
    "ماليزيا",
    "المالديف",
    "مالي",
    "مالطا",
    "جزر مارشال",
    "ميكرونيزيا",
    "مولدوفا",
    "موناكو",
    "منغوليا",
    "الجبل الأسود",
    "المغرب",
    "موزمبيق",
    "ميانمار (بورما سابقًا)",
    "ناميبيا",
    "ناورو",
    "نيبال",
    "هولندا",
    "نيوزيلندا",
    "نيكاراغوا",
    "النيجر",
    "نيجيريا",
    "كوريا الشمالية",
    "مقدونيا الشمالية (مقدونيا سابقًا)",
    "النرويج",
    "عمان",
    "باكستان",
    "بالاو",
    "فلسطين",
    "بنما",
    "بابوا غينيا الجديدة",
    "باراغواي",
    "بيرو",
    "الفلبين",
    "بولندا",
    "البرتغال",
    "قطر",
    "رومانيا",
    "روسيا",
    "رواندا",
    "سانت كيتس ونيفيس",
    "سانت لوسيا",
    "سانت فنسنت والغرينادين",
    "ساموا",
    "سان مارينو",
    "ساو تومي وبرينسيب",
    "المملكة العربية السعودية",
    "السنغال",
    "صربيا",
    "سيشل",
    "سيراليون",
    "سنغافورة",
    "سلوفاكيا",
    "سلوفينيا",
    "جزر سليمان",
    "الصومال",
    "جنوب أفريقيا",
    "كوريا الجنوبية",
    "جنوب السودان",
    "إسبانيا",
    "سريلانكا",
    "السودان",
    "سورينام",
    "السويد",
    "سويسرا",
    "سوريا",
    "تايوان",
    "طاجيكستان",
    "تنزانيا",
    "تايلاند",
    "تيمور الشرقية",
    "توجو",
    "تونغا",
    "ترينيداد وتوباغو",
    "تونس",
    "تركيا",
    "تركمانستان",
    "توفالو",
    "أوغندا",
    "أوكرانيا",
    "الإمارات العربية المتحدة",
    "المملكة المتحدة",
    "الولايات المتحدة",
    "أوروغواي",
    "أوزبكستان",
    "فانواتو",
    "مدينة الفاتيكان",
    "فنزويلا",
    "فيتنام",
    "اليمن",
    "زامبيا",
    "زيمبابوي",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء حساب جديد'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // اسم المستخدم
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'اسم المستخدم',
                ),
              ),
              const SizedBox(height: 16),

              // اسم الحساب
              TextField(
                controller: _accountNameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'الاسم الحساب',
                ),
              ),
              const SizedBox(height: 16),

              // البريد الإلكتروني
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'البريد الإلكتروني',
                ),
              ),
              const SizedBox(height: 16),

              // كلمة المرور
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'كلمة المرور',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),

              // تاريخ الميلاد
              Row(
                children: [
                  Expanded(
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'تاريخ الميلاد',
                      ),
                      child: Text(
                        _birthDate == null
                            ? 'اختر تاريخ الميلاد'
                            : '${_birthDate!.day}-${_birthDate!.month}-${_birthDate!.year}',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _birthDate = pickedDate;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // الجنس
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'الجنس',
                ),
                value: _selectedGender,
                items: _genders
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // نوع الحساب
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'نوع الحساب',
                ),
                value: _selectedAccountType,
                items: _accountTypes
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAccountType = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // البلد
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'البلد',
                ),
                value: _selectedCountry,
                items: _countries
                    .map((country) => DropdownMenuItem(
                          value: country,
                          child: Text(country),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // زر إنشاء حساب
              ElevatedButton(
                onPressed: () {
                  // منطق التحقق أو الإرسال
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.lightBlue[300],
                ),
                child: const Text('تسجيل الحساب'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
