import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Settings',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProfileSettingsPage(),
    );
  }
}

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  String _name = "أحمد محمد"; // Example name
  String _lastPasswordChange = "2024-01-15"; // Example date
  bool _twoFactorEnabled = false;
  bool _isEducationalCenter = false;

  Null get value => null;

  void _showEditNameDialog() {
    String newName = _name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تعديل الاسم'),
        content: TextField(
          textAlign: TextAlign.right,
          decoration: InputDecoration(hintText: 'أدخل الاسم الجديد'),
          onChanged: (value) => newName = value,
        ),
        actions: [
          TextButton(
            child: Text('إلغاء'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('حفظ'),
            onPressed: () {
              setState(() => _name = newName);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تغيير كلمة المرور'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              textAlign: TextAlign.right,
              obscureText: true,
              decoration: InputDecoration(hintText: 'كلمة المرور الحالية'),
            ),
            SizedBox(height: 8),
            TextField(
              textAlign: TextAlign.right,
              obscureText: true,
              decoration: InputDecoration(hintText: 'كلمة المرور الجديدة'),
              onChanged: (value),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('إلغاء'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('تغيير'),
            onPressed: () {
              setState(() => _lastPasswordChange =
                  DateTime.now().toString().split(' ')[0]);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإعدادات'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Card(
              child: ListTile(
                title: Text('الاسم'),
                subtitle: Text(_name),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: _showEditNameDialog,
                ),
              ),
            ),
            SizedBox(height: 8),
            Card(
              child: ListTile(
                title: Text('كلمة المرور'),
                subtitle: Text('آخر تغيير: $_lastPasswordChange'),
                trailing: IconButton(
                  icon: Icon(Icons.lock),
                  onPressed: _showChangePasswordDialog,
                ),
              ),
            ),
            SizedBox(height: 8),
            SwitchListTile(
              title: Text('التحقق بخطوتين'),
              value: _twoFactorEnabled,
              onChanged: (value) => setState(() => _twoFactorEnabled = value),
            ),
            SizedBox(height: 8),
            ElevatedButton.icon(
              icon: Icon(Icons.person_add),
              label: Text('إضافة متابع'),
              onPressed: () {
                // Add follower logic
              },
            ),
            SizedBox(height: 8),
            SwitchListTile(
              title: Text('مركز تعليمي'),
              value: _isEducationalCenter,
              onChanged: (value) =>
                  setState(() => _isEducationalCenter = value),
            ),
            if (_isEducationalCenter) ...[
              SizedBox(height: 8),
              ElevatedButton.icon(
                icon: Icon(Icons.school),
                label: Text('إضافة معلم'),
                onPressed: () {
                  // Add teacher logic
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
