import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const PriceCompareApp());
}

class PriceCompareApp extends StatelessWidget {
  const PriceCompareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
        ),
        cardColor: const Color(0xFF2C2C2C),
        dialogBackgroundColor: const Color(0xFF3D3D3D),
        colorScheme: const ColorScheme.dark(
          primary: Colors.teal,
          secondary: Colors.amber,
          surface: Color(0xFF2C2C2C),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1E1E1E),
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: const CompareScreen(),
    );
  }
}

class ShopPrice {
  final String shopName;
  final double normalizedPriceSAR;
  final double originalPrice;
  final String currency;
  final String note; // 🆕 خانة الملاحظات الجديدة

  ShopPrice({
    required this.shopName,
    required this.normalizedPriceSAR,
    required this.originalPrice,
    required this.currency,
    this.note = "",
  });

  Map<String, dynamic> toJson() => {
    'shopName': shopName,
    'normalizedPriceSAR': normalizedPriceSAR,
    'originalPrice': originalPrice,
    'currency': currency,
    'note': note,
  };

  factory ShopPrice.fromJson(Map<String, dynamic> json) {
    return ShopPrice(
      shopName: json['shopName'],
      normalizedPriceSAR: (json['normalizedPriceSAR'] ?? 0.0).toDouble(),
      originalPrice: (json['originalPrice'] ?? 0.0).toDouble(),
      currency: json['currency'] ?? 'SAR',
      note: json['note'] ?? "",
    );
  }
}

class CompareScreen extends StatefulWidget {
  const CompareScreen({super.key});

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  int _selectedIndex = 0; // للتحكم في التبويبات

  final Map<String, double> basePricesSAR = {
    // >> قطع الـ PC
    "AMD Ryzen 7 9800X3D": 2382.0,
    "MSI MAG X870 TOMAHAWK WIFI": 1727.0,
    "MSI RTX 5090 Gaming Trio": 10500.0,
    "Samsung 990 Pro 4TB": 2144.0,
    "Corsair HX1200i (2025) PSU": 1632.0,
    "Lian Li LANCOOL III RGB": 750.0,
    "Lian Li Galahad II Trinity 360": 750.0,
    "PNY XLR8 DDR5-6000 32GB": 550.0,

    // >> الشاشات والملحقات
    "Samsung Odyssey OLED G9 (G93SD)": 5099.0,
    "Meta Quest 3 512GB": 2363.0,
    "Kiwi Design Battery Strap (Quest 3)": 299.0,
    "JSaux Link Cable 5m (Quest 3)": 86.0,
    "Carrying Case (Quest 3)": 110.0,
    "UPS 1200VA Evo DSP Plus": 970.0,
    "ACT Power Cable C13-C14 (3m) x2": 52.0,
    "Ugreen HDMI 2.1 Cable (2m)": 77.0,
    "Cougar Gaming Chair (Reclining)": 798.0,
    "Twisted Minds L-Shape Desk (160cm)": 972.0,
    "Logitech MX Keys S Combo": 837.0,
    "Logitech MX Master 3S Mouse": 379.0,
    "NB RGB Monitor Arm": 249.0,
  };

  List<String> get myParts => basePricesSAR.keys.toList();

  Map<String, List<ShopPrice>> collectedPrices = {};
  Set<String> purchasedItems = {};
  bool isLoading = true;

  final Map<String, double> exchangeRates = {
    'SAR': 1.0,
    'QAR': 1.03,
    'BHD': 9.95,
    'USD': 3.75,
  };

  @override
  void initState() {
    super.initState();
    for (var part in myParts) {
      collectedPrices[part] = [];
    }
    _loadData();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> exportMap = {};
    collectedPrices.forEach((key, value) {
      exportMap[key] = value.map((e) => e.toJson()).toList();
    });
    await prefs.setString('saved_prices_v6', jsonEncode(exportMap));
    await prefs.setStringList('purchased_items', purchasedItems.toList());
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();

    // محاولة تحميل V6، ثم V5، ثم V4
    String? encodedData = prefs.getString('saved_prices_v6') ??
        prefs.getString('saved_prices_v5') ??
        prefs.getString('saved_prices_v4');

    if (encodedData != null) {
      try {
        Map<String, dynamic> decodedMap = jsonDecode(encodedData);
        setState(() {
          decodedMap.forEach((key, value) {
            if (collectedPrices.containsKey(key)) {
              var list = value as List;
              collectedPrices[key] = list.map((e) => ShopPrice.fromJson(e)).toList();
            }
          });
        });
      } catch (e) {
        debugPrint("Error: $e");
      }
    }

    List<String>? loadedPurchases = prefs.getStringList('purchased_items');
    if (loadedPurchases != null) {
      setState(() {
        purchasedItems = loadedPurchases.toSet();
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  void _togglePurchased(String partName) {
    setState(() {
      if (purchasedItems.contains(partName)) {
        purchasedItems.remove(partName);
      } else {
        purchasedItems.add(partName);
      }
      _saveData();
    });
  }

  void _deletePrice(String partName, ShopPrice priceObj) {
    setState(() {
      collectedPrices[partName]!.remove(priceObj);
      _saveData();
    });
  }

  // --- 🆕 Helper Functions للملخصات ---
  double _calculateTotalEstimated() {
    return basePricesSAR.values.fold(0, (sum, price) => sum + price);
  }

  double _calculateSpentSoFar() {
    double total = 0;
    for (var item in purchasedItems) {
      if (collectedPrices[item] != null && collectedPrices[item]!.isNotEmpty) {
        // إذا شريته وعندك أسعار مسجلة، نفترض أنك شريت "الأرخص"
        // (أو أول واحد في القائمة المرتبة)
        total += collectedPrices[item]!.first.normalizedPriceSAR;
      } else {
        // إذا شريته بس ما سجلت سعر، نحسب السعر المرجعي
        total += basePricesSAR[item] ?? 0;
      }
    }
    return total;
  }

  // --- 🆕 Widgets ---

  Widget _buildDashboard() {
    double estimatedTotal = _calculateTotalEstimated();
    double currentSpent = _calculateSpentSoFar();
    double progress = purchasedItems.length / myParts.length;

    // حساب الفرق في القطع المشتراة فقط (للمعرفة هل وفرنا أم لا)
    double estimatedForBought = 0;
    for(var item in purchasedItems) estimatedForBought += (basePricesSAR[item] ?? 0);
    double savings = estimatedForBought - currentSpent;

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade900, Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.teal.withOpacity(0.3), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStat("الميزانية التقديرية", "${estimatedTotal.toStringAsFixed(0)} SAR", Colors.grey),
              _buildStat("المصروف الفعلي", "${currentSpent.toStringAsFixed(0)} SAR", Colors.white),
            ],
          ),
          const SizedBox(height: 15),
          // شريط التقدم
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("تم شراء ${purchasedItems.length} من ${myParts.length}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  Text("${(progress * 100).toStringAsFixed(0)}%", style: const TextStyle(fontSize: 12, color: Colors.tealAccent)),
                ],
              ),
              const SizedBox(height: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade800,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.teal),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (purchasedItems.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: savings >= 0 ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                savings >= 0
                    ? "كفو! وفرت ${savings.toStringAsFixed(0)} SAR حتى الآن 🤑"
                    : "انتبه! تجاوزت المتوقع بـ ${(savings * -1).toStringAsFixed(0)} SAR 💸",
                style: TextStyle(
                  color: savings >= 0 ? Colors.greenAccent : Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _getPriceEvaluation(String partName, double priceSAR) {
    double base = basePricesSAR[partName] ?? 0.0;
    if (base == 0.0) return const SizedBox();
    double ratio = priceSAR / base;

    String text; Color color; IconData icon;
    if (ratio <= 0.98) { text = "لقطة"; color = Colors.greenAccent; icon = Icons.local_offer; }
    else if (ratio <= 1.05) { text = "ممتاز"; color = Colors.lightGreen; icon = Icons.check_circle; }
    else if (ratio <= 1.20) { text = "مقبول"; color = Colors.amber; icon = Icons.thumb_up; }
    else { text = "غالي"; color = Colors.redAccent; icon = Icons.warning; }

    return Row(children: [
      Icon(icon, color: color, size: 12),
      const SizedBox(width: 4),
      Text(text, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
    ]);
  }

  void _addPrice(String partName) {
    String shop = "";
    String priceStr = "";
    String selectedCurrency = "SAR";
    String note = ""; // خانة الملاحظات

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(partName, style: const TextStyle(fontSize: 13), maxLines: 2),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: "اسم المحل", hintText: "Store974", prefixIcon: Icon(Icons.store)),
                      onChanged: (val) => shop = val,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(labelText: "السعر", prefixIcon: Icon(Icons.attach_money)),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            onChanged: (val) => priceStr = val,
                          ),
                        ),
                        const SizedBox(width: 8),
                        DropdownButton<String>(
                          value: selectedCurrency,
                          dropdownColor: const Color(0xFF4A4A4A),
                          items: exchangeRates.keys.map((String value) {
                            return DropdownMenuItem<String>(value: value, child: Text(value));
                          }).toList(),
                          onChanged: (newValue) => setStateDialog(() => selectedCurrency = newValue!),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(labelText: "ملاحظات (اختياري)", hintText: "ضمان، مفتوح..", prefixIcon: Icon(Icons.note)),
                      onChanged: (val) => note = val,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text("إلغاء")),
                ElevatedButton(
                  onPressed: () {
                    if (shop.isNotEmpty && priceStr.isNotEmpty) {
                      double originalPrice = double.tryParse(priceStr) ?? 0.0;
                      double normalizedPrice = originalPrice * (exchangeRates[selectedCurrency] ?? 1.0);
                      setState(() {
                        collectedPrices[partName]!.add(ShopPrice(
                          shopName: shop,
                          normalizedPriceSAR: normalizedPrice,
                          originalPrice: originalPrice,
                          currency: selectedCurrency,
                          note: note,
                        ));
                        collectedPrices[partName]!.sort((a, b) => a.normalizedPriceSAR.compareTo(b.normalizedPriceSAR));
                        _saveData();
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("حفظ"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // --- صفحة قائمة المحلات (Optimization) ---
  Widget _buildShopSummaryView() {
    Map<String, List<Map<String, dynamic>>> shopsMap = {};

    collectedPrices.forEach((partName, pricesList) {
      if (!purchasedItems.contains(partName)) {
        for (var price in pricesList) {
          if (!shopsMap.containsKey(price.shopName)) {
            shopsMap[price.shopName] = [];
          }
          shopsMap[price.shopName]!.add({
            'part': partName,
            'priceObj': price,
          });
        }
      }
    });

    if (shopsMap.isEmpty) {
      // هنا كان الخطأ، شلنا const وغيرنا الأيقونة
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.remove_shopping_cart, size: 50, color: Colors.grey), // استبدلنا الأيقونة
            SizedBox(height: 10),
            Text("لم تسجل أسعار بعد، أو اشتريت كل شيء!", style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView(
        padding: const EdgeInsets.all(12),
        children: shopsMap.entries.map((entry) {
          String shopName = entry.key;
          var items = entry.value;
          double totalAtShop = items.fold(0, (sum, item) => sum + (item['priceObj'] as ShopPrice).normalizedPriceSAR);

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              leading: const CircleAvatar(child: Icon(Icons.shopping_bag)),
              title: Text(shopName, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("${items.length} قطع متوفرة - المجموع: ${totalAtShop.toStringAsFixed(0)} SAR"),
              children: items.map((item) {
                ShopPrice p = item['priceObj'];
                return ListTile(
                  dense: true,
                  title: Text(item['part']),
                  subtitle: Text(p.note.isNotEmpty ? p.note : "---"),
                  trailing: Text("${p.normalizedPriceSAR.toStringAsFixed(0)} SAR", style: const TextStyle(color: Colors.greenAccent)),
                );
              }).toList(),
            ),
          );
        }).toList(),
    );
  }


  // --- صفحة القائمة الرئيسية ---
  Widget _buildMainListView() {
    final activeItems = myParts.where((item) => !purchasedItems.contains(item)).toList();
    final doneItems = myParts.where((item) => purchasedItems.contains(item)).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          _buildDashboard(), // 1. لوحة القيادة

          if (activeItems.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(alignment: Alignment.centerRight, child: Text("📌 المطلوب:", style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold))),
            ),
            ...activeItems.map((part) => _buildItemCard(part, isDone: false)),
          ],

          if (doneItems.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(alignment: Alignment.centerRight, child: Text("✅ المكتمل:", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))),
            ),
            ...doneItems.map((part) => _buildItemCard(part, isDone: true)),
          ],
        ],
      ),
    );
  }

  Widget _buildItemCard(String partName, {required bool isDone}) {
    final prices = collectedPrices[partName]!;
    ShopPrice? bestDeal = prices.isNotEmpty ? prices.first : null;

    IconData itemIcon = Icons.devices;
    if (partName.contains("Quest")) itemIcon = Icons.headset_mic;
    else if (partName.contains("Monitor")) itemIcon = Icons.monitor;

    return Card(
      elevation: isDone ? 0 : 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: isDone ? Colors.grey.withOpacity(0.05) : const Color(0xFF2C2C2C),
      child: ExpansionTile(
        leading: IconButton(
          icon: Icon(isDone ? Icons.check_circle : Icons.circle_outlined, color: isDone ? Colors.green : Colors.grey),
          onPressed: () => _togglePurchased(partName),
        ),
        title: Text(
          partName,
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.bold,
              decoration: isDone ? TextDecoration.lineThrough : null,
              color: isDone ? Colors.grey : Colors.white
          ),
        ),
        subtitle: isDone
            ? const Text("تم الشراء", style: TextStyle(color: Colors.green, fontSize: 10))
            : bestDeal != null
            ? Row(
          children: [
            Text("${bestDeal.normalizedPriceSAR.toStringAsFixed(0)} SAR", style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            _getPriceEvaluation(partName, bestDeal.normalizedPriceSAR),
          ],
        )
            : Text("تقريباً: ${basePricesSAR[partName]?.toStringAsFixed(0)} SAR", style: const TextStyle(color: Colors.grey, fontSize: 11)),
        children: [
          if (!isDone)
            Container(
              color: const Color(0xFF222222),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _addPrice(partName),
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text("إضافة سعر"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey.shade700),
                    ),
                  ),
                  ...prices.map((deal) => ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    title: Text(deal.shopName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${deal.originalPrice} ${deal.currency}", style: const TextStyle(fontSize: 11, color: Colors.grey)),
                        if(deal.note.isNotEmpty) Text("📝 ${deal.note}", style: const TextStyle(fontSize: 11, color: Colors.amber)),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${deal.normalizedPriceSAR.toStringAsFixed(0)} SAR", style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent, size: 18),
                          onPressed: () => _deletePrice(partName, deal),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? "قائمة المقاضي 🛒" : "ملخص المحلات 🏪"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              // زر الطوارئ للمسح
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              setState(() {
                for (var part in myParts) collectedPrices[part] = [];
                purchasedItems.clear();
              });
            },
          )
        ],
      ),
      body: _selectedIndex == 0 ? _buildMainListView() : _buildShopSummaryView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "القائمة"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "المحلات"),
        ],
      ),
    );
  }
}