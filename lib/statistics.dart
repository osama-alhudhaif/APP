// const String statisticsHtml = r'''
// {% extends 'base.html' %}
// {% block content %}
// <!-- الجداول والإحصائيات هنا -->
// <div class="tables">
//     <br><br><br>
//     <table>
//         <tr>
//             <th colspan="21">القصص</th>
//             <tr>
//                 <th>نوع القصة</th>
//                 <th>العدد</th>
//                 <th>النسبة المئوية</th>
//                 <th>نوع القصة</th>
//                 <th>العدد</th>
//                 <th>النسبة المئوية</th>
//                 <th>نوع القصة</th>
//                 <th>العدد</th>
//                 <th>النسبة المئوية</th>
//                 <th>نوع القصة</th>
//                 <th>العدد</th>
//                 <th>النسبة المئوية</th>
//                 <th>نوع القصة</th>
//                 <th>العدد</th>
//                 <th>النسبة المئوية</th>
//                 <th>نوع القصة</th>
//                 <th>العدد</th>
//                 <th>النسبة المئوية</th>
//                 <th>نوع القصة</th>
//                 <th>العدد</th>
//                 <th>النسبة المئوية</th>
//             </tr>
//             <tr>
//             </tr>
//             <tr>
//                 <th>التاريخ</th>
//                 <td id="date-count"></td>
//                 <td id="date-percentage"></td>
//                 <th>الجريمة والتحقيق</th>
//                 <td id="crime-count"></td>
//                 <td id="crime-percentage"></td>
//                 <th>الخيال العلمي</th>
//                 <td id="sci-fi-count"></td>
//                 <td id="sci-fi-percentage"></td>
//                 <th>الخيال</th>
//                 <td id="fantasy-count"></td>
//                 <td id="fantasy-percentage"></td>
//                 <th>الرعب</th>
//                 <td id="horror-count"></td>
//                 <td id="horror-percentage"></td>
//                 <th>الرومانسية</th>
//                 <td id="romance-count"></td>
//                 <td id="romance-percentage"></td>
//                 <th>الفانتازي</th>
//                 <td id="fantasy-count-2"></td>
//                 <td id="fantasy-percentage-2"></td>
//             </tr>
//             <tr>
//                 <th>الكوميديا</th>
//                 <td id="comedy-count"></td>
//                 <td id="comedy-percentage"></td>
//                 <th>المغامرة</th>
// <!DOCTYPE html>
// <html lang="ar" dir="rtl">

// <head>
//     <meta charset="UTF-8">
//     <meta name="viewport" content="width=device-width, initial-scale=1.0">
//     <title>عوالمنا</title>
//     <link rel="icon" href="../static/Website.jpg">
//     <link rel="stylesheet" href="style.css">
//     <script src="script.js"></script>
// </head>

// <body>
//     <header>
//         <div class="location" style="text-align: center;">
//             <a href="الموقع.html" style="text-decoration: none; color: inherit;">
//                 <img src="Website.jpg" alt="صورة الموقع" height="50" width="50">
//                 <h1 style="display: inline; margin: 0;">عوالمنا</h1>
//             </a>
//         </div>
//     </header>
//     <br><br><br>
//     <!-- القصص -->
//     <div class="tables">
//         <br><br><br>
//         <table>
//             <tr>
//                 <th colspan="21">القصص</th>
//                 <tr>
//                     <th>نوع القصة</th>
//                     <th>العدد</th>
//                     <th>النسبة المئوية</th>
//                     <th>نوع القصة</th>
//                     <th>العدد</th>
//                     <th>النسبة المئوية</th>
//                     <th>نوع القصة</th>
//                     <th>العدد</th>
//                     <th>النسبة المئوية</th>
//                     <th>نوع القصة</th>
//                     <th>العدد</th>
//                     <th>النسبة المئوية</th>
//                     <th>نوع القصة</th>
//                     <th>العدد</th>
//                     <th>النسبة المئوية</th>
//                     <th>نوع القصة</th>
//                     <th>العدد</th>
//                     <th>النسبة المئوية</th>
//                     <th>نوع القصة</th>
//                     <th>العدد</th>
//                     <th>النسبة المئوية</th>
//                 </tr>
//                 <tr>
//                 </tr>
//                 <tr>
//                     <th>التاريخ</th>
//                     <td id="date-count"></td>
//                     <td id="date-percentage"></td>
//                     <th>الجريمة والتحقيق</th>
//                     <td id="crime-count"></td>
//                     <td id="crime-percentage"></td>
//                     <th>الخيال العلمي</th>
//                     <td id="sci-fi-count"></td>
//                     <td id="sci-fi-percentage"></td>
//                     <th>الخيال</th>
//                     <td id="fantasy-count"></td>
//                     <td id="fantasy-percentage"></td>
//                     <th>الرعب</th>
//                     <td id="horror-count"></td>
//                     <td id="horror-percentage"></td>
//                     <th>الرومانسية</th>
//                     <td id="romance-count"></td>
//                     <td id="romance-percentage"></td>
//                     <th>الفانتازي</th>
//                     <td id="fantasy-count-2"></td>
//                     <td id="fantasy-percentage-2"></td>
//                 </tr>
//                 <tr>
//                     <th>الكوميديا</th>
//                     <td id="comedy-count"></td>
//                     <td id="comedy-percentage"></td>
//                     <th>المغامرة</th>
//                     <td id="adventure-count"></td>
//                     <td id="adventure-percentage"></td>
//                     <th>حرب</th>
//                     <td id="war-count"></td>
//                     <td id="war-percentage"></td>
//                     <th>دراما</th>
//                     <td id="drama-count"></td>
//                     <td id="drama-percentage"></td>
//                     <th>سرقة</th>
//                     <td id="heist-count"></td>
//                     <td id="heist-percentage"></td>
//                     <th>أطفال</th>
//                     <td id="kids-count"></td>
//                     <td id="kids-percentage"></td>
//                     <th>عدد القصص الكلي</th>
//                     <td id="total-count"></td>
//                     <td id="total-percentage"></td>
//                 </tr>
//         </table>
//     </div>

//     <br>

//     <!-- الحسابات -->
//     <div class="tables-2">
//         <table>
//             <tr>
//                 <th colspan="15">الحسابات</th>

//             </tr>
//             <th>نوع الحساب</th>
//             <th>العدد</th>
//             <th>النسبة المئوية</th>
//             <th>نوع الحساب</th>
//             <th>العدد</th>
//             <th>النسبة المئوية</th>
//             <th>نوع الحساب</th>
//             <th>العدد</th>
//             <th>النسبة المئوية</th>
//             <th>نوع الحساب</th>
//             <th>العدد</th>
//             <th>النسبة المئوية</th>
//             <tr>
//                 <td>حسابات الكتاب</td>
//                 <td id="book-count"></td>
//                 <td id="book-percentage"></td>
//                 <td>حسابات القراء</td>
//                 <td id="reader-count"></td>
//                 <td id="reader-percentage"></td>
//                 <td>حسابات الادمن العادي</td>
//                 <td id="admin-count"></td>
//                 <td id="admin-percentage"></td>
//                 <td>حسابات الادمن العالي</td>
//                 <td id="super-admin-count"></td>
//                 <td id="super-admin-percentage"></td>
//             </tr>
//             <tr>
//                 <td>المراكز التعليمية</td>
//                 <td id="school-count"></td>
//                 <td id="school-percentage"></td>
//                 <td>حسابات الاشتراك الشهري</td>
//                 <td id="monthly-subscription-count"></td>
//                 <td id="monthly-subscription-percentage"></td>
//                 <td>حسابات الاشتراك السنوي</td>
//                 <td id="yearly-subscription-count"></td>
//                 <td id="yearly-subscription-percentage"></td>
//                 <td>حسابات الاشتراك الملغاة</td>
//                 <td id="cancelled-subscription-count"></td>
//                 <td id="cancelled-subscription-percentage"></td>
//             </tr>
//         </table>
//     </div>
//     <br>
//     <!-- البيانات العامه -->
//     <!-- الدول -->
//     <div class="Tables-3">
//         <table>
//             <tr>
//                 <th>الدول</th>
//                 <th>العدد</th>
//                 <th>النسبة المئوية</th>
//                 <th>الدول</th>
//                 <th>العدد</th>
//                 <th>النسبة المئوية</th>
//                 <th>الدول</th>
//                 <th>العدد</th>
//                 <th>النسبة المئوية</th>
//                 <th>الدول</th>
//                 <th>العدد</th>
//                 <th>النسبة المئوية</th>
//                 <th>الدول</th>
//                 <th>العدد</th>
//                 <th>النسبة المئوية</th>
//             </tr>
//             <tr>
//                 <td>أفغانستان</td>
//                 <td id="Afghanistan-count"></td>
//                 <td id="Afghanistan-percentage"></td>
//                 <td>جزر آلاند</td>
//                 <td id="Aland-Islands-count"></td>
//                 <td id="Aland-Islands-percentage"></td>
//                 <td>ألبانيا</td>
//                 <td id="Albania-count"></td>
//                 <td id="Albania-percentage"></td>
//                 <td>الجزائر</td>
//                 <td id="Algeria-count"></td>
//                 <td id="Algeria-percentage"></td>
//                 <td>ساموا الأمريكية</td>
//                 <td id="American-Samoa-count"></td>
//                 <td id="American-Samoa-percentage"></td>
//             </tr>
//             <tr>
//                 <td>أندورا</td>
//                 <td id="Andorra-count"></td>
//                 <td id="Andorra-percentage"></td>
//                 <td>أنغولا</td>
//                 <td id="Angola-count"></td>
//                 <td id="Angola-percentage"></td>
//                 <td>أنغويلا</td>
//                 <td id="Anguilla-count"></td>
//                 <td id="Anguilla-percentage"></td>
//                 <td>أنتاركتيكا</td>
//                 <td id="Antarctica-count"></td>
//                 <td id="Antarctica-percentage"></td>
//                 <td>أنتيغوا وبربودا</td>
//                 <td id="Antigua-and-Barbuda-count"></td>
//                 <td id="Antigua-and-Barbuda-percentage"></td>
//             </tr>
//             <tr>
//                 <td>الأرجنتين</td>
//                 <td id="Argentina-count"></td>
//                 <td id="Argentina-percentage"></td>
//                 <td>أرمينيا</td>
//                 <td id="Armenia-count"></td>
//                 <td id="Armenia-percentage"></td>
//                 <td>أروبا</td>
//                 <td id="Aruba-count"></td>
//                 <td id="Aruba-percentage"></td>
//                 <td>أستراليا</td>
//                 <td id="Australia-count"></td>
//                 <td id="Australia-percentage"></td>
//                 <td>النمسا</td>
//                 <td id="Austria-count"></td>
//                 <td id="Austria-percentage"></td>
//             </tr>
//             <tr>
//                 <td>أذربيجان</td>
//                 <td id="Azerbaijan-count"></td>
//                 <td id="Azerbaijan-percentage"></td>
//                 <td>الباهاماس</td>
//                 <td id="Bahamas-count"></td>
//                 <td id="Bahamas-percentage"></td>
//                 <td>البحرين</td>
//                 <td id="Bahrain-count"></td>
//                 <td id="Bahrain-percentage"></td>
//                 <td>بنغلاديش</td>
//                 <td id="Bangladesh-count"></td>
//                 <td id="Bangladesh-percentage"></td>
//                 <td>باربادوس</td>
//                 <td id="Barbados-count"></td>
//                 <td id="Barbados-percentage"></td>
//             </tr>
//             <tr>
//                 <td>بيلاروسيا</td>
//                 <td id="Belarus-count"></td>
//                 <td id="Belarus-percentage"></td>
//                 <td>بلجيكا</td>
//                 <td id="Belgium-count"></td>
//                 <td id="Belgium-percentage"></td>
//                 <td>بليز</td>
//                 <td id="Belize-count"></td>
//                 <td id="Belize-percentage"></td>
//                 <td>بنين</td>
//                 <td id="Benin-count"></td>
//                 <td id="Benin-percentage"></td>
//                 <td>برمودا</td>
//                 <td id="Bermuda-count"></td>
//                 <td id="Bermuda-percentage"></td>
//             </tr>
//             <tr>
//                 <td>بوتان</td>
//                 <td id="Bhutan-count"></td>
//                 <td id="Bhutan-percentage"></td>
//                 <td>بوليفيا</td>
//                 <td id="Bolivia-count"></td>
//                 <td id="Bolivia-percentage"></td>
//                 <td>البوسنة والهرسك</td>
//                 <td id="Bosnia-and-Herzegovina-count"></td>
//                 <td id="Bosnia-and-Herzegovina-percentage"></td>
//                 <td>بوتسوانا</td>
//                 <td id="Botswana-count"></td>
//                 <td id="Botswana-percentage"></td>
//                 <td>جزيرة بوفيه</td>
//                 <td id="Bouvet-Island-count"></td>
//                 <td id="Bouvet-Island-percentage"></td>
//             </tr>
//             <tr>
//                 <td>البرازيل</td>
//                 <td id="Brazil-count"></td>
//                 <td id="Brazil-percentage"></td>
//                 <td>إقليم المحيط الهندي البريطاني</td>
//                 <td id="British-Indian-Ocean-Territory-count"></td>
//                 <td id="British-Indian-Ocean-Territory-percentage"></td>
//                 <td>بروناي</td>
//                 <td id="Brunei-Darussalam-count"></td>
//                 <td id="Brunei-Darussalam-percentage"></td>
//                 <td>بلغاريا</td>
//                 <td id="Bulgaria-count"></td>
//                 <td id="Bulgaria-percentage"></td>
//                 <td>بوركينا فاسو</td>
//                 <td id="Burkina-Faso-count"></td>
//                 <td id="Burkina-Faso-percentage"></td>
//             </tr>
//             <tr>
//                 <td>بوروندي</td>
//                 <td id="Burundi-count"></td>
//                 <td id="Burundi-percentage"></td>
//                 <td>كمبوديا</td>
//                 <td id="Cambodia-count"></td>
//                 <td id="Cambodia-percentage"></td>
//                 <td>الكاميرون</td>
//                 <td id="Cameroon-count"></td>
//                 <td id="Cameroon-percentage"></td>
//                 <td>كندا</td>
//                 <td id="Canada-count"></td>
//                 <td id="Canada-percentage"></td>
//                 <td>الرأس الأخضر</td>
//                 <td id="Cape-Verde-count"></td>
//                 <td id="Cape-Verde-percentage"></td>
//             </tr>
//             <tr>
//                 <td>جزر كايمان</td>
//                 <td id="Cayman-Islands-count"></td>
//                 <td id="Cayman-Islands-percentage"></td>
//                 <td>جمهورية أفريقيا الوسطى</td>
//                 <td id="Central-African-Republic-count"></td>
//                 <td id="Central-African-Republic-percentage"></td>
//                 <td>تشاد</td>
//                 <td id="Chad-count"></td>
//                 <td id="Chad-percentage"></td>
//                 <td>تشيلي</td>
//                 <td id="Chile-count"></td>
//                 <td id="Chile-percentage"></td>
//                 <td>الصين</td>
//                 <td id="China-count"></td>
//                 <td id="China-percentage"></td>
//             </tr>
//             <tr>
//                 <td>جزيرة عيد الميلاد</td>
//                 <td id="Christmas-Island-count"></td>
//                 <td id="Christmas-Island-percentage"></td>
//                 <td>جزر كوكوس</td>
//                 <td id="Cocos-Islands-count"></td>
//                 <td id="Cocos-Islands-percentage"></td>
//                 <td>كولومبيا</td>
//                 <td id="Colombia-count"></td>
//                 <td id="Colombia-percentage"></td>
//                 <td>جزر القمر</td>
//                 <td id="Comoros-count"></td>
//                 <td id="Comoros-percentage"></td>
//                 <td>جمهورية الكونغو</td>
//                 <td id="Congo-count"></td>
//                 <td id="Congo-percentage"></td>
//             </tr>
//             <tr>
//                 <td>جمهورية الكونغو الديمقراطية</td>
//                 <td id="Democratic-Republic-of-the-Congo-count"></td>
//                 <td id="Democratic-Republic-of-the-Congo-percentage"></td>
//                 <td>جزر كوك</td>
//                 <td id="Cook-Islands-count"></td>
//                 <td id="Cook-Islands-percentage"></td>
//                 <td>كرواتيا</td>
//                 <td id="Croatia-count"></td>
//                 <td id="Croatia-percentage"></td>
//                 <td>كوبا</td>
//                 <td id="Cuba-count"></td>
//                 <td id="Cuba-percentage"></td>
//                 <td>قبرص</td>
//                 <td id="Cyprus-count"></td>
//                 <td id="Cyprus-percentage"></td>
//             </tr>
//             <tr>
//                 <td>جمهورية التشيك</td>
//                 <td id="Czech-Republic-count"></td>
//                 <td id="Czech-Republic-percentage"></td>
//                 <td>الدنمارك</td>
//                 <td id="Denmark-count"></td>
//                 <td id="Denmark-percentage"></td>
//                 <td>جيبوتي</td>
//                 <td id="Djibouti-count"></td>
//                 <td id="Djibouti-percentage"></td>
//                 <td>دومينيكا</td>
//                 <td id="Dominica-count"></td>
//                 <td id="Dominica-percentage"></td>
//                 <td>جمهورية الدومينيكان</td>
//                 <td id="Dominican-Republic-count"></td>
//                 <td id="Dominican-Republic-percentage"></td>
//             </tr>
//             <tr>
//                 <td>تيمور الشرقية</td>
//                 <td id="East-Timor-count"></td>
//                 <td id="East-Timor-percentage"></td>
//                 <td>الإكوادور</td>
//                 <td id="Ecuador-count"></td>
//                 <td id="Ecuador-percentage"></td>
//                 <td>مصر</td>
//                 <td id="Egypt-count"></td>
//                 <td id="Egypt-percentage"></td>
//                 <td>السلفادور</td>
//                 <td id="El-Salvador-count"></td>
//                 <td id="El-Salvador-percentage"></td>
//                 <td>غينيا الاستوائية</td>
//                 <td id="Equatorial-Guinea-count"></td>
//                 <td id="Equatorial-Guinea-percentage"></td>
//             </tr>
//             <tr>
//                 <td>إريتريا</td>
//                 <td id="Eritrea-count"></td>
//                 <td id="Eritrea-percentage"></td>
//                 <td>إستونيا</td>
//                 <td id="Estonia-count"></td>
//                 <td id="Estonia-percentage"></td>
//                 <td>أسواتيني</td>
//                 <td id="Eswatini-count"></td>
//                 <td id="Eswatini-percentage"></td>
//                 <td>إثيوبيا</td>
//                 <td id="Ethiopia-count"></td>
//                 <td id="Ethiopia-percentage"></td>
//                 <td>جزر فوكلاند</td>
//                 <td id="Falkland-Islands-count"></td>
//                 <td id="Falkland-Islands-percentage"></td>
//             </tr>
//             <tr>
//                 <td>جزر فاروس</td>
//                 <td id="Faroe-Islands-count"></td>
//                 <td id="Faroe-Islands-percentage"></td>
//                 <td>فجي</td>
//                 <td id="Fiji-count"></td>
//                 <td id="Fiji-percentage"></td>
//                 <td>فنلندا</td>
//                 <td id="Finland-count"></td>
//                 <td id="Finland-percentage"></td>
//                 <td>فرنسا</td>
//                 <td id="France-count"></td>
//                 <td id="France-percentage"></td>
//                 <td>غابون</td>
//                 <td id="Gabon-count"></td>
//                 <td id="Gabon-percentage"></td>
//             </tr>
//             <tr>
//                 <td>غامبيا</td>
//                 <td id="Gambia-count"></td>
//                 <td id="Gambia-percentage"></td>
//                 <td>جورجيا</td>
//                 <td id="Georgia-count"></td>
//                 <td id="Georgia-percentage"></td>
//                 <td>ألمانيا</td>
//                 <td id="Germany-count"></td>
//                 <td id="Germany-percentage"></td>
//                 <td>غانا</td>
//                 <td id="Ghana-count"></td>
//                 <td id="Ghana-percentage"></td>
//                 <td>غرينلاند</td>
//                 <td id="Greenland-count"></td>
//                 <td id="Greenland-percentage"></td>
//             </tr>
//             <tr>
//                 <td>غرينادا</td>
//                 <td id="Grenada-count"></td>
//                 <td id="Grenada-percentage"></td>
//                 <td>غينيا</td>
//                 <td id="Guinea-count"></td>
//                 <td id="Guinea-percentage"></td>
//                 <td>غينيا بيساو</td>
//                 <td id="Guinea-Bissau-count"></td>
//                 <td id="Guinea-Bissau-percentage"></td>
//                 <td>غيانا</td>
//                 <td id="Guyana-count"></td>
//                 <td id="Guyana-percentage"></td>
//                 <td>هايتي</td>
//                 <td id="Haiti-count"></td>
//                 <td id="Haiti-percentage"></td>
//             </tr>
//             <tr>
//                 <td>هولندا</td>
//                 <td id="Netherlands-count"></td>
//                 <td id="Netherlands-percentage"></td>
//                 <td>هندوراس</td>
//                 <td id="Honduras-count"></td>
//                 <td id="Honduras-percentage"></td>
//                 <td>هنغاريا</td>
//                 <td id="Hungary-count"></td>
//                 <td id="Hungary-percentage"></td>
//                 <td>آيسلندا</td>
//                 <td id="Iceland-count"></td>
//                 <td id="Iceland-percentage"></td>
//                 <td>الهند</td>
//                 <td id="India-count"></td>
//                 <td id="India-percentage"></td>
//             </tr>
//             <tr>
//                 <td>إندونيسيا</td>
//                 <td id="Indonesia-count"></td>
//                 <td id="Indonesia-percentage"></td>
//                 <td>إيران</td>
//                 <td id="Iran-count"></td>
//                 <td id="Iran-percentage"></td>
//                 <td>العراق</td>
//                 <td id="Iraq-count"></td>
//                 <td id="Iraq-percentage"></td>
//                 <td>إيرلندا</td>
//                 <td id="Ireland-count"></td>
//                 <td id="Ireland-percentage"></td>
//                 <td>إسرائيل</td>
//                 <td id="Israel-count"></td>
//                 <td id="Israel-percentage"></td>
//             </tr>
//             <tr>
//                 <td>إيطاليا</td>
//                 <td id="Italy-count"></td>
//                 <td id="Italy-percentage"></td>
//                 <td>جامايكا</td>
//                 <td id="Jamaica-count"></td>
//                 <td id="Jamaica-percentage"></td>
//                 <td>يابان</td>
//                 <td id="Japan-count"></td>
//                 <td id="Japan-percentage"></td>
//                 <td>الأردن</td>
//                 <td id="Jordan-count"></td>
//                 <td id="Jordan-percentage"></td>
//                 <td>كازاخستان</td>
//                 <td id="Kazakhstan-count"></td>
//                 <td id="Kazakhstan-percentage"></td>
//             </tr>
//             <tr>
//                 <td>كينيا</td>
//                 <td id="Kenya-count"></td>
//                 <td id="Kenya-percentage"></td>
//                 <td>كيريباتي</td>
//                 <td id="Kiribati-count"></td>
//                 <td id="Kiribati-percentage"></td>
//                 <td>كوريا الشمالية</td>
//                 <td id="North-Korea-count"></td>
//                 <td id="North-Korea-percentage"></td>
//                 <td>كوريا الجنوبية</td>
//                 <td id="South-Korea-count"></td>
//                 <td id="South-Korea-percentage"></td>
//                 <td>الكويت</td>
//                 <td id="Kuwait-count"></td>
//                 <td id="Kuwait-percentage"></td>
//             </tr>
//             <tr>
//                 <td>قرغيزستان</td>
//                 <td id="Kyrgyzstan-count"></td>
//                 <td id="Kyrgyzstan-percentage"></td>
//                 <td>لاوس</td>
//                 <td id="Laos-count"></td>
//                 <td id="Laos-percentage"></td>
//                 <td>لاتفيا</td>
//                 <td id="Latvia-count"></td>
//                 <td id="Latvia-percentage"></td>
//                 <td>لبنان</td>
//                 <td id="Lebanon-count"></td>
//                 <td id="Lebanon-percentage"></td>
//                 <td>ليسوتو</td>
//                 <td id="Lesotho-count"></td>
//                 <td id="Lesotho-percentage"></td>
//             </tr>
//             <tr>
//                 <td>ليبيريا</td>
//                 <td id="Liberia-count"></td>
//                 <td id="Liberia-percentage"></td>
//                 <td>ليبيا</td>
//                 <td id="Libya-count"></td>
//                 <td id="Libya-percentage"></td>
//                 <td>ليتوانيا</td>
//                 <td id="Lithuania-count"></td>
//                 <td id="Lithuania-percentage"></td>
//                 <td>لوكسمبورغ</td>
//                 <td id="Luxembourg-count"></td>
//                 <td id="Luxembourg-percentage"></td>
//                 <td>مدغشقر</td>
//                 <td id="Madagascar-count"></td>
//                 <td id="Madagascar-percentage"></td>
//             </tr>
//             <tr>
//                 <td>مالاوي</td>
//                 <td id="Malawi-count"></td>
//                 <td id="Malawi-percentage"></td>
//                 <td>ماليزيا</td>
//                 <td id="Malaysia-count"></td>
//                 <td id="Malaysia-percentage"></td>
//                 <td>مالطا</td>
//                 <td id="Malta-count"></td>
//                 <td id="Malta-percentage"></td>
//                 <td>ماروكو</td>
//                 <td id="Morocco-count"></td>
//                 <td id="Morocco-percentage"></td>
//                 <td>موزمبيق</td>
//                 <td id="Mozambique-count"></td>
//                 <td id="Mozambique-percentage"></td>
//             </tr>
//             <tr>
//                 <td>ميانمار</td>
//                 <td id="Myanmar-count"></td>
//                 <td id="Myanmar-percentage"></td>
//                 <td>ناميبيا</td>
//                 <td id="Namibia-count"></td>
//                 <td id="Namibia-percentage"></td>
//                 <td>ناورو</td>
//                 <td id="Nauru-count"></td>
//                 <td id="Nauru-percentage"></td>
//                 <td>نيبال</td>
//                 <td id="Nepal-count"></td>
//                 <td id="Nepal-percentage"></td>
//                 <td>هولندا</td>
//                 <td id="Netherlands-count"></td>
//                 <td id="Netherlands-percentage"></td>
//             </tr>
//             <tr>
//                 <td>نيوزيلندا</td>
//                 <td id="New-Zealand-count"></td>
//                 <td id="New-Zealand-percentage"></td>
//                 <td>نيكاراغوا</td>
//                 <td id="Nicaragua-count"></td>
//                 <td id="Nicaragua-percentage"></td>
//                 <td>النيجر</td>
//                 <td id="Niger-count"></td>
//                 <td id="Niger-percentage"></td>
//                 <td>نيجيريا</td>
//                 <td id="Nigeria-count"></td>
//                 <td id="Nigeria-percentage"></td>
//                 <td>أوسلو</td>
//                 <td id="Norway-count"></td>
//                 <td id="Norway-percentage"></td>
//             </tr>
//             <tr>
//                 <td>عمان</td>
//                 <td id="Oman-count"></td>
//                 <td id="Oman-percentage"></td>
//                 <td>باكستان</td>
//                 <td id="Pakistan-count"></td>
//                 <td id="Pakistan-percentage"></td>
//                 <td>بالاو</td>
//                 <td id="Palau-count"></td>
//                 <td id="Palau-percentage"></td>
//                 <td>فلسطين</td>
//                 <td id="Palestine-count"></td>
//                 <td id="Palestine-percentage"></td>
//                 <td>بنما</td>
//                 <td id="Panama-count"></td>
//                 <td id="Panama-percentage"></td>
//             </tr>
//             <tr>
//                 <td>بابوا غينيا الجديدة</td>
//                 <td id="Papua-New-Guinea-count"></td>
//                 <td id="Papua-New-Guinea-percentage"></td>
//                 <td>باراغواي</td>
//                 <td id="Paraguay-count"></td>
//                 <td id="Paraguay-percentage"></td>
//                 <td>هندوراس</td>
//                 <td id="Honduras-count"></td>
//                 <td id="Honduras-percentage"></td>
//                 <td>رومانيا</td>
//                 <td id="Romania-count"></td>
//                 <td id="Romania-percentage"></td>
//                 <td>روسيا</td>
//                 <td id="Russia-count"></td>
//                 <td id="Russia-percentage"></td>
//             </tr>
//             <tr>
//                 <td>رواي</td>
//                 <td id="Rwanda-count"></td>
//                 <td id="Rwanda-percentage"></td>
//                 <td>سان مارينو</td>
//                 <td id="San-Marino-count"></td>
//                 <td id="San-Marino-percentage"></td>
//                 <td>ساو تومي وبرينسيبي</td>
//                 <td id="Sao-Tome-and-Principe-count"></td>
//                 <td id="Sao-Tome-and-Principe-percentage"></td>
//                 <td>المملكة العربية السعودية</td>
//                 <td id="Saudi-Arabia-count"></td>
//                 <td id="Saudi-Arabia-percentage"></td>
//                 <td>سنغافورة</td>
//                 <td id="Singapore-count"></td>
//                 <td id="Singapore-percentage"></td>
//             </tr>
//             <tr>
//                 <td>سلوفاكيا</td>
//                 <td id="Slovakia-count"></td>
//                 <td id="Slovakia-percentage"></td>
//                 <td>سلوفينيا</td>
//                 <td id="Slovenia-count"></td>
//                 <td id="Slovenia-percentage"></td>
//                 <td>جزر سليمان</td>
//                 <td id="Solomon-Islands-count"></td>
//                 <td id="Solomon-Islands-percentage"></td>
//                 <td>جنوب إفريقيا</td>
//                 <td id="South-Africa-count"></td>
//                 <td id="South-Africa-percentage"></td>
//                 <td>كوريا الجنوبية</td>
//                 <td id="South-Korea-count"></td>
//                 <td id="South-Korea-percentage"></td>
//             </tr>
//             <tr>
//                 <td>إسبانيا</td>
//                 <td id="Spain-count"></td>
//                 <td id="Spain-percentage"></td>
//                 <td>سريلانكا</td>
//                 <td id="Sri-Lanka-count"></td>
//                 <td id="Sri-Lanka-percentage"></td>
//                 <td>السويد</td>
//                 <td id="Sweden-count"></td>
//                 <td id="Sweden-percentage"></td>
//                 <td>سويسرا</td>
//                 <td id="Switzerland-count"></td>
//                 <td id="Switzerland-percentage"></td>
//                 <td>سوريا</td>
//                 <td id="Syria-count"></td>
//                 <td id="Syria-percentage"></td>
//             </tr>
//             <tr>
//                 <td>طاجيكستان</td>
//                 <td id="Tajikistan-count"></td>
//                 <td id="Tajikistan-percentage"></td>
//                 <td>تنزانيا</td>
//                 <td id="Tanzania-count"></td>
//                 <td id="Tanzania-percentage"></td>
//                 <td>تيفوي</td>
//                 <td id="Togo-count"></td>
//                 <td id="Togo-percentage"></td>
//                 <td>تونس</td>
//                 <td id="Tunisia-count"></td>
//                 <td id="Tunisia-percentage"></td>
//                 <td>تركيا</td>
//                 <td id="Turkey-count"></td>
//                 <td id="Turkey-percentage"></td>
//             </tr>
//             <tr>
//                 <td>تركمانستان</td>
//                 <td id="Turkmenistan-count"></td>
//                 <td id="Turkmenistan-percentage"></td>
//                 <td>توفالو</td>
//                 <td id="Tuvalu-count"></td>
//                 <td id="Tuvalu-percentage"></td>
//                 <td>أوغندا</td>
//                 <td id="Uganda-count"></td>
//                 <td id="Uganda-percentage"></td>
//                 <td>أوكرانيا</td>
//                 <td id="Ukraine-count"></td>
//                 <td id="Ukraine-percentage"></td>
//                 <td>الإمارات العربية المتحدة</td>
//                 <td id="United-Arab-Emirates-count"></td>
//                 <td id="United-Arab-Emirates-percentage"></td>
//             </tr>
//             <tr>
//                 <td>المملكة المتحدة</td>
//                 <td id="United-Kingdom-count"></td>
//                 <td id="United-Kingdom-percentage"></td>
//                 <td>الولايات المتحدة الأمريكية</td>
//                 <td id="United-States-count"></td>
//                 <td id="United-States-percentage"></td>
//                 <td>أوروغواي</td>
//                 <td id="Uruguay-count"></td>
//                 <td id="Uruguay-percentage"></td>
//                 <td>أوزبكستان</td>
//                 <td id="Uzbekistan-count"></td>
//                 <td id="Uzbekistan-percentage"></td>
//                 <td>فنزويلا</td>
//                 <td id="Venezuela-count"></td>
//                 <td id="Venezuela-percentage"></td>
//             </tr>
//             <tr>
//                 <td>فيتنام</td>
//                 <td id="Vietnam-count"></td>
//                 <td id="Vietnam-percentage"></td>
//                 <td>اليمن</td>
//                 <td id="Yemen-count"></td>
//                 <td id="Yemen-percentage"></td>
//                 <td>زامبيا</td>
//                 <td id="Zambia-count"></td>
//                 <td id="Zambia-percentage"></td>
//                 <td>زيمبابوي</td>
//                 <td id="Zimbabwe-count"></td>
//                 <td id="Zimbabwe-percentage"></td>
//             </tr>
//         </table>

//     </div>
//     <br><br>

// </body>

// </html>
// <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
// <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
// ''';
