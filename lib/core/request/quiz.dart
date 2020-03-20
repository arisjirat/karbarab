import 'package:karbarab/features/quiz/model/quiz.dart';

List<QuizModel> getQuizData() {
  final listQuiz = <QuizModel>[
    QuizModel(
      arab: 'طاولة',
      arabVoice: 'meja.mp3',
      bahasa: 'Meja',
      date: DateTime.now(),
      id: '1',
      image: 'https://pngimg.com/uploads/table/table_PNG7005.png',
    ),
    QuizModel(
      arab: 'الكرسي',
      arabVoice: 'kursi.mp3',
      bahasa: 'Bangku',
      date: DateTime.now(),
      id: '2',
      image: 'https://pngimg.com/uploads/chair/chair_PNG6862.png',
    ),
    QuizModel(
      arab: 'الباب',
      arabVoice: 'meja.mp3',
      bahasa: 'Pintu',
      date: DateTime.now(),
      id: '3',
      image:
          'https://img.favpng.com/22/1/21/door-download-png-favpng-rgjhMmpYzLEFQXefNmWurpGUg.jpg',
    ),
    QuizModel(
      arab: 'خزانة',
      arabVoice: 'meja.mp3',
      bahasa: 'Lemari',
      date: DateTime.now(),
      id: '4',
      image:
          'https://p7.hiclipart.com/preview/379/769/121/cupboard-cabinetry-clip-art-cupboard-png-thumbnail.jpg',
    ),
    QuizModel(
      arab: 'زهرة',
      arabVoice: 'bunga.mp3',
      bahasa: 'Bunga',
      date: DateTime.now(),
      id: '5',
      image:
          'https://pluspng.com/img-png/flower-png-dahlia-flower-png-transparent-image-1644.png',
    ),
    QuizModel(
      arab: 'منزل',
      arabVoice: 'meja.mp3',
      bahasa: 'Rumah',
      date: DateTime.now(),
      id: '6',
      image:
          'https://www.freeiconspng.com/uploads/description-crystal-project-folder-home-8.png',
    ),
    QuizModel(
      arab: 'الشجرة',
      arabVoice: 'meja.mp3',
      bahasa: 'Pohon',
      date: DateTime.now(),
      id: '7',
      image:
          'https://www.freepnglogos.com/uploads/tree-plan-png/tree-plan-tree-png-image-purepng-transparent-png-image-12.png',
    ),
    QuizModel(
      arab: 'الكتاب',
      arabVoice: 'meja.mp3',
      bahasa: 'Buku',
      date: DateTime.now(),
      id: '8',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Gambar_Buku.png/464px-Gambar_Buku.png',
    ),
    QuizModel(
      arab: 'قلم',
      arabVoice: 'meja.mp3',
      bahasa: 'Pulpen',
      date: DateTime.now(),
      id: '9',
      image: 'https://pngimg.com/uploads/pen/pen_PNG7415.png',
    ),
  ];
  return listQuiz;
}
