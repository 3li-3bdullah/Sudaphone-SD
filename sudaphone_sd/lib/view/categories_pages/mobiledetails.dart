import 'package:flutter/material.dart';
import 'package:sudaphone_sd/view/categories_widgets/custom_textof_details.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';

// ignore: must_be_immutable
class MobileDetails extends StatelessWidget {
  String? namePhone;
  String? photo;

  MobileDetails({Key? key, required this.namePhone, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const CustomText(
              textAlign: TextAlign.center,
              text: 'التفاصيل',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            centerTitle: true,
          ),
          body: ListView(children: [
            SizedBox(
                height: 300,
                child: GridTile(
                    child: Image.asset(photo!),
                    footer: Container(
                        height: 80,
                        color: Colors.black.withOpacity(0.3),
                        child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    namePhone!,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )),
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "1200\$",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ))))),

            //End Header page

            Container(
              padding: const EdgeInsets.all(10),
              child: const CustomText(
                textAlign: TextAlign.right,
                text: "المواصفات",
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            //Start Column Specfiction

            Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    CustomTextOfDetails(
                      text1: "الموديل : ",
                      text2: "S20 Ultra",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "الشاشة : ",
                      text2: "Super Amoled 5.5",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "نظام التشغيل : ",
                      text2: "Android 10, One UI 2",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "الحماية  : ",
                      text2: " IP68 مقاوم للماء , Gorilla Glass 6",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "دقة الشاشة : ",
                      text2: "6.9 بوصة بدقة QHD + بها ثقب صغير",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "المعالج : ",
                      text2: "Snapdragon 865, Eiyons 990",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "البطارية : ",
                      text2: "5000 MAH " + "" + "شحن سريع w15",
                    ),
                    SizedBox(height: 2),
                  ],
                )),
            //start the second container
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: Center(
                child: CustomText(
                  textAlign: TextAlign.center,
                  text: "المميزات",
                  color: Colors.green.shade700,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 2),
            //Start Column Specfiction
            Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    CustomTextOfDetails(
                      text1: "التقريب : ",
                      text2: "يقرب حتي 100 مرة أثناء التصوير بالكاميرا الزوم",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "دعم التصوير : ",
                      text2: "يدعم تصوير الفيديوهات بجودة ال 8K",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "الذاكرة العشوائية : ",
                      text2:
                          "كبيرة جدا تعطيك مرونه في فتح الكثير من التطبيقات ولكن فعليا هل سنحتاج إلي كل هذه المساحة بالاخص مع قدومها من نوع LPDDR5",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "الكاميرا  : ",
                      text2:
                          "كامبرا قوية جدا قادرة علي المنافسة وكاد تكون الأفضل في 2020 ... مع كاميرا سيلفي مميزة 40 ميجا بيكسل",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "الشاشة  : ",
                      text2: "ممتازة وكبيرة و بدقة عالية ومعدل تحديث 120 هرتز",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "البطارية : ",
                      text2:
                          "كبيرة جدا والتي يتم توفيرها لأول مرة يهذه السعة في سلسلة ال S",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "الشحن : ",
                      text2:
                          "يدعم الشحن السريع بقوة 45 واط حيث ستتمكن من شحن هاتفك من 0% إلي 100% خلال 74 دقيقة بالكامل",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "أداء المعالج : ",
                      text2: "قوي و يمتاز بأنه قوي من حيث الأداء",
                    ),
                    SizedBox(height: 2),
                  ],
                )),
            //End second container
            //Start three container
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: Center(
                  child: CustomText(
                textAlign: TextAlign.center,
                text: "العيوب",
                color: Colors.orange.shade800,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
            ),
            const SizedBox(height: 2),
            //Start Column Specfiction
            Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    CustomTextOfDetails(
                      text1: "السعر : ",
                      text2: "مرتفع وحجمة ثقيل",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "المنافذ : ",
                      text2: "لا يوجد منفذ 3.5 ملم",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "لمبة إشعارات : ",
                      text2: "لا توجد به لمبه إشعارات",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "الشبكة : ",
                      text2: "لا توجد به لمبه إشعارات",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "الكاميرا : ",
                      text2: "بروز كبير في الشكل",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "الألوان : ",
                      text2: "محددة",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "الشرايح : ",
                      text2:
                          "لا يمكن استخدام شريحتين و كارت ميموري في نفس الوقت",
                    ),
                    SizedBox(height: 2),
                    CustomTextOfDetails(
                      text1: "الشاشة : ",
                      text2:
                          "كبيرة جدا في اليد وستحتاج إلي بعض الوقت للاعتياد عليها",
                    ),
                    SizedBox(height: 2),
                  ],
                )),
          ]),
        ));
  }
}