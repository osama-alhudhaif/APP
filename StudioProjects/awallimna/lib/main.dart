import 'package:flutter/material.dart';

/*
1- اضيف app bar و يمين فيه ثلاث خطوط , داخلها (1-الاعدادات و 2-الحساب نفسه و 3-قائمة القصص الي راح اقراهن بعدين)    []
2-احط باليسار ايموجي الفلاتر عشان احدد وش يطلع لي   []
3-اضيف انه يتحدث كل مره اسوي حفظ    []
4-اضافة وضع الظلام  []
5-اضافة API []
6-اضافة تشفير   []
7-تعريف كل زر باسم مخصص   []
8-اضافة ازرار التفاعل[]
9-اضافة زر يطلع له حسابات المشروع او حسابات الشخص الي دخل حسابه   []
10-اضافة تحويل الصفحة الي اللي تحددونها   []
*/

void main() {
  runApp(const MaterialApp(home: Scaffold(body: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: AppBar(
            title: const Text("عوالمنا", style: TextStyle(color: Colors.black)),
            centerTitle: true,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.account_circle)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            ],
          ),
        ),
      ),
    );
  }
}
