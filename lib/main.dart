import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:nisan_photo_app/firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reyhan 💖 Ubeyd',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MultiImageUpload(),
    );
  }
}

// class MultiImageUpload extends StatefulWidget {
//   const MultiImageUpload({super.key});

//   @override
//   _MultiImageUploadState createState() => _MultiImageUploadState();
// }

// class _MultiImageUploadState extends State<MultiImageUpload> {
//   List<Uint8List> images = []; // Seçilen resimler
//   double totalProgress = 0; // Toplam ilerleme
//   List<String> uploadedUrls = []; // Yüklenen resimlerin URL'leri

//   Future<void> chooseImages() async {
//     List<Uint8List>? pickedImages = await ImagePickerWeb.getMultiImagesAsBytes(); // Birden fazla resim seçimi
//     if (pickedImages != null) {
//       setState(() {
//         images = pickedImages;
//         totalProgress = 0; // Yükleme yüzdesini sıfırlama
//       });
//       await uploadImages(); // Toplu yükleme işlemi
//     }
//   }

//   Future<void> uploadImages() async {
//     FirebaseStorage firebaseStorage = FirebaseStorage.instance;
//     int totalBytes = images.length;
//     int uploadedImages = 0; // Tamamlanan dosya sayısını takip edeceğiz

//     // Yükleme işlemlerini toplu başlatıyoruz
//     List<Future<void>> uploadTasks = images.map((image) {
//       Reference reference = firebaseStorage.ref().child('images/${Random().nextInt(256000)}.jpg');

//       UploadTask uploadTask = reference.putData(
//         image,
//         SettableMetadata(contentType: 'image/jpeg'),
//       );

//       // Yükleme ilerlemesi
//       uploadTask.snapshotEvents.listen((event) {
//         if (event.state == TaskState.success) {
//           setState(() {
//             uploadedImages += 1; // Her başarılı yüklemede 1 dosya arttır
//             totalProgress = (uploadedImages / totalBytes) * 100; // İlerleme yüzdesi
//           });
//         }
//       });

//       // Yükleme tamamlanınca URL al ve kaydet
//       return uploadTask.whenComplete(() async {
//         String url = await reference.getDownloadURL();
//         setState(() {
//           uploadedUrls.add(url);
//         });
//       });
//     }).toList();

//     // Tüm yükleme görevlerini bekle
//     await Future.wait(uploadTasks);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Multi Image Upload")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: chooseImages,
//               child: const Text("Select Images"),
//             ),
//             const SizedBox(height: 10),
//             Stack(
//               alignment: Alignment.center, // Stack'teki resimleri ortalar
//               children: images
//                   .map(
//                     (e) => Transform.rotate(
//                       angle: e == images.first
//                           ? 0
//                           : images.indexOf(e) % 2 == 0
//                               ? -pi / 12 * images.indexOf(e)
//                               : pi / 12 * images.indexOf(e),
//                       child: Image.memory(
//                         e,
//                         height: 200,
//                         width: 200,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   )
//                   .toList(),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               width: 200,
//               height: 20,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.grey[300],
//               ),
//               child: Stack(
//                 children: [
//                   Container(
//                     width: (totalProgress / 100) * 200,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "Total Progress: ${totalProgress.toStringAsFixed(2)}%",
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//* *** */

// class MultiImageUpload extends StatefulWidget {
//   const MultiImageUpload({super.key});

//   @override
//   _MultiImageUploadState createState() => _MultiImageUploadState();
// }

// class _MultiImageUploadState extends State<MultiImageUpload> with TickerProviderStateMixin {
//   List<Uint8List> images = [];
//   double totalProgress = 0;
//   List<String> uploadedUrls = [];
//   List<AnimationController> _rotationControllers = [];
//   List<Animation<double>> _rotationAnimations = [];
//   List<bool> imageUploadStatus = []; // Yükleme durumu takibi için

//   @override
//   void dispose() {
//     for (var controller in _rotationControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   Future<void> chooseImages() async {
//     List<Uint8List>? pickedImages = await ImagePickerWeb.getMultiImagesAsBytes();
//     if (pickedImages != null) {
//       setState(() {
//         images = pickedImages;
//         totalProgress = 0;
//         uploadedUrls = [];
//         _rotationControllers = List.generate(
//           images.length,
//           (_) => AnimationController(
//             vsync: this,
//             duration: const Duration(seconds: 3), // Dönme süresi
//           ),
//         );
//         _rotationAnimations = List.generate(images.length, (index) {
//           return Tween<double>(begin: 0, end: 2 * pi).animate(
//             CurvedAnimation(
//               parent: _rotationControllers[index],
//               curve: Curves.linear,
//             ),
//           );
//         });
//         imageUploadStatus = List.generate(images.length, (_) => false);
//       });
//       startRotatingImages();
//       await uploadImages();
//     }
//   }

//   Future<void> uploadImages() async {
//     FirebaseStorage firebaseStorage = FirebaseStorage.instance;
//     int totalBytes = images.length;
//     int uploadedImages = 0;

//     List<Future<void>> uploadTasks = images.asMap().entries.map((entry) {
//       int index = entry.key;
//       Uint8List image = entry.value;
//       Reference reference = firebaseStorage.ref().child('images/${Random().nextInt(256000)}.jpg');

//       UploadTask uploadTask = reference.putData(
//         image,
//         SettableMetadata(contentType: 'image/jpeg'),
//       );

//       uploadTask.snapshotEvents.listen((event) {
//         if (event.state == TaskState.success) {
//           setState(() {
//             uploadedImages += 1;
//             totalProgress = (uploadedImages / totalBytes) * 100;
//             imageUploadStatus[index] = true; // Yükleme tamamlandı işareti

//             // Yükleme tamamlandığında smooth bir şekilde durdur
//             _rotationControllers[index].animateTo(1, duration: const Duration(seconds: 1), curve: Curves.easeOut).then((_) {
//               _rotationControllers[index].stop(); // Dönmeyi tamamen durdur
//             });
//           });
//         }
//       });

//       return uploadTask.whenComplete(() async {
//         String url = await reference.getDownloadURL();
//         setState(() {
//           uploadedUrls.add(url);
//         });
//       });
//     }).toList();

//     await Future.wait(uploadTasks);
//   }

//   void startRotatingImages() {
//     for (int i = 0; i < _rotationControllers.length; i++) {
//       _startImageRotation(i);
//     }
//   }

//   void _startImageRotation(int index) {
//     _rotationControllers[index].repeat(); // Sürekli döndürmeye başla

//     // Döngü bittiğinde, 0 noktasında kontrol et
//     _rotationControllers[index].addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _rotationControllers[index].reset();
//         if (!imageUploadStatus[index]) {
//           _rotationControllers[index].repeat(); // Henüz yüklenmediyse döndürmeye devam et
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Multi Image Upload")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: chooseImages,
//               child: const Text("Select Images"),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               width: 200,
//               height: 20,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.grey[300],
//               ),
//               child: Stack(
//                 children: [
//                   Container(
//                     width: (totalProgress / 100) * 200,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "Total Progress: ${totalProgress.toStringAsFixed(2)}%",
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             Expanded(
//               child: Wrap(
//                 alignment: WrapAlignment.center,
//                 children: images.asMap().entries.map((entry) {
//                   int index = entry.key;
//                   Uint8List image = entry.value;

//                   return AnimatedBuilder(
//                     animation: _rotationControllers[index],
//                     builder: (context, child) {
//                       double angle = _rotationAnimations[index].value;

//                       return Transform.rotate(
//                         angle: angle,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Image.memory(
//                             image,
//                             height: 200,
//                             width: 200,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }).toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class MultiImageUpload extends StatefulWidget {
  const MultiImageUpload({super.key});

  @override
  _MultiImageUploadState createState() => _MultiImageUploadState();
}

class _MultiImageUploadState extends State<MultiImageUpload> {
  List<Uint8List> images = [];
  double totalProgress = 0;
  List<String> uploadedUrls = [];
  bool isUploading = false;

  final ScrollController _scrollController = ScrollController();

  Future<void> chooseImages() async {
    // Resim seçimi yapılmadan önce listeyi sıfırla
    setState(() {
      images.clear();
      uploadedUrls.clear();
      totalProgress = 0;
    });

    List<Uint8List>? pickedImages = await ImagePickerWeb.getMultiImagesAsBytes();
    if (pickedImages != null) {
      setState(() {
        images = pickedImages;
      });
    }

    _scrollToSelectedImages();
  }

  void _scrollToSelectedImages() {
    _scrollController
        .animateTo(
      _scrollController.position.pixels + 50,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    )
        .then((_) {
      // Ardından eski haline dön
      _scrollController.animateTo(
        _scrollController.position.pixels - 50,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> uploadImages() async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    setState(() {
      isUploading = true;
    });

    int totalBytes = images.length;
    int uploadedImages = 0;

    List<Future<void>> uploadTasks = images.map((image) {
      Reference reference = firebaseStorage.ref().child('images/${(DateTime.now().millisecondsSinceEpoch * Random().nextInt(1000) / 1000).ceil()}.jpg');

      UploadTask uploadTask = reference.putData(
        image,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      // Yükleme ilerlemesi
      uploadTask.snapshotEvents.listen((event) {
        if (event.state == TaskState.success) {
          setState(() {
            uploadedImages += 1;
            totalProgress = (uploadedImages / totalBytes) * 100;
          });
        }
      });

      return uploadTask.whenComplete(() async {
        String url = await reference.getDownloadURL();
        setState(() {
          uploadedUrls.add(url);
        });
      });
    }).toList();

    await Future.wait(uploadTasks);

    setState(() {
      isUploading = false;
      resetImages();
    });
  }

  void resetImages() {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        setState(() {
          images.clear();
          uploadedUrls.clear();
          totalProgress = 0;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 32),
              Image.asset(
                'assets/images/title.png',
                width: MediaQuery.sizeOf(context).width * 0.7,
              ),
              const SizedBox(height: 32),
              Image.asset(
                'assets/images/flower.png',
                height: MediaQuery.sizeOf(context).height * 0.1,
              ),
              const SizedBox(height: 32),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/image_upload_bg.png',
                        width: MediaQuery.sizeOf(context).width * 0.9,
                      ),
                      Container(
                        child: images.isEmpty
                            ? Container(
                                decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(40)),
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                child: GestureDetector(
                                  onTap: chooseImages,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Fotoğrafları Seç & Yükle",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(width: 16),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: Image.asset(
                                          'assets/images/camera.png',
                                          width: 32,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: images.map((image) {
                                      int index = images.indexOf(image);
                                      return Container(
                                        margin: const EdgeInsets.all(8),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.memory(
                                            image,
                                            height: MediaQuery.sizeOf(context).width * 0.2,
                                            width: MediaQuery.sizeOf(context).width * 0.2,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  if (images.isNotEmpty && totalProgress == 0 && uploadedUrls.isEmpty)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: resetImages,
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(color: Colors.black),
                            backgroundColor: Colors.white70,
                          ),
                          child: const Text("Seçimleri Kaldır"),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: isUploading
                              ? null
                              : uploadedUrls.isEmpty
                                  ? uploadImages
                                  : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white70,
                            textStyle: const TextStyle(color: Colors.black),
                          ),
                          child: isUploading
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : const Text("Resimleri Yükle"),
                        ),
                      ],
                    ),
                  const SizedBox(height: 10),
                  Container(
                    child: totalProgress == 0
                        ? const SizedBox.shrink()
                        : totalProgress == 100
                            ? Container(
                                decoration: const BoxDecoration(color: Colors.white60, shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.check_rounded, color: Colors.green[800], size: 32),
                                ),
                              )
                            : Text(
                                "Yükleniyor... ${totalProgress.toStringAsFixed(2)}%",
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Nişanımızda bizleri yalnız bırakmadığınız için teşekkürler ",
                      style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "💫",
                      style: TextStyle(color: Colors.amber),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
