import 'package:karbarab/core/helper/utils.dart';
import 'package:karbarab/features/quiz/model/quiz.dart';

List<QuizModel> getQuizData() {
  final listQuiz = <QuizModel>[
    QuizModel(
      arab: 'طاولة',
      voice: 'meja.mp3',
      bahasa: 'Meja',
      date: DateTime.now(),
      cardCategory: CardCategory.Animal,
      level: 1,
      id: '1',
      image: 'https://pngimg.com/uploads/table/table_PNG7005.png',
    ),
    QuizModel(
      arab: 'الكرسي',
      voice: 'kursi.mp3',
      bahasa: 'Bangku',
      date: DateTime.now(),
      cardCategory: CardCategory.Animal,
      level: 1,
      id: '2',
      image: 'https://pngimg.com/uploads/chair/chair_PNG6862.png',
    ),
    QuizModel(
      arab: 'الباب',
      voice: 'meja.mp3',
      bahasa: 'Pintu',
      date: DateTime.now(),
      cardCategory: CardCategory.Animal,
      level: 1,
      id: '3',
      image:
          'https://img.favpng.com/22/1/21/door-download-png-favpng-rgjhMmpYzLEFQXefNmWurpGUg.jpg',
    ),
    QuizModel(
      arab: 'خزانة',
      voice: 'meja.mp3',
      bahasa: 'Lemari',
      date: DateTime.now(),
      cardCategory: CardCategory.Animal,
      level: 1,
      id: '4',
      image:
          'https://p7.hiclipart.com/preview/379/769/121/cupboard-cabinetry-clip-art-cupboard-png-thumbnail.jpg',
    ),
    QuizModel(
      arab: 'زهرة',
      voice: 'bunga.mp3',
      bahasa: 'Bunga',
      date: DateTime.now(),
      cardCategory: CardCategory.Animal,
      level: 1,
      id: '5',
      image:
          'https://pluspng.com/img-png/flower-png-dahlia-flower-png-transparent-image-1644.png',
    ),
    QuizModel(
      arab: 'منزل',
      voice: 'meja.mp3',
      bahasa: 'Rumah',
      date: DateTime.now(),
      cardCategory: CardCategory.Animal,
      level: 1,
      id: '6',
      image:
          'https://www.freeiconspng.com/uploads/description-crystal-project-folder-home-8.png',
    ),
    QuizModel(
      arab: 'الشجرة',
      voice: 'meja.mp3',
      bahasa: 'Pohon',
      date: DateTime.now(),
      cardCategory: CardCategory.Animal,
      level: 1,
      id: '7',
      image:
          '',
    ),
    QuizModel(
      arab: 'الكتاب',
      voice: 'meja.mp3',
      bahasa: 'Buku',
      date: DateTime.now(),
      cardCategory: CardCategory.Animal,
      level: 1,
      id: '8',
      image: '',
      // image:
      //     'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Gambar_Buku.png/464px-Gambar_Buku.png',
    ),
    QuizModel(
      arab: 'قلم',
      voice: 'meja.mp3',
      bahasa: 'Pulpen',
      date: DateTime.now(),
      cardCategory: CardCategory.Animal,
      level: 1,
      id: '9',
      image: '',
      // image: 'https://pngimg.com/uploads/pen/pen_PNG7415.png',
    ),
  ];
  return listQuiz;
}
