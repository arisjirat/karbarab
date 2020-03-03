

import 'package:karbarab/helper/model_quiz.dart';

List<QuizModel> getQuizData () {
  var listQuiz = <QuizModel>[];
  listQuiz.add(
    QuizModel(
      arab: 'طاولة',
      arabVoice: 'Arab Voice',
      bahasa: 'Meja',
      date: DateTime.now(),
      id: '1',
      image: 'https://pngimg.com/uploads/table/table_PNG7005.png',
    ),
  );
  listQuiz.add(
    QuizModel(
      arab: 'الكرسي',
      arabVoice: 'Arab Voice',
      bahasa: 'Bangku',
      date: DateTime.now(),
      id: '2',
      image: 'https://pngimg.com/uploads/chair/chair_PNG6862.png',
    ),
  );
  listQuiz.add(
    QuizModel(
      arab: 'الباب',
      arabVoice: 'Voice 3',
      bahasa: 'Pintu',
      date: DateTime.now(),
      id: '3',
      image:
          'https://img.favpng.com/22/1/21/door-download-png-favpng-rgjhMmpYzLEFQXefNmWurpGUg.jpg',
    ),
  );
  listQuiz.add(
    QuizModel(
      arab: 'خزانة',
      arabVoice: 'Voice 4',
      bahasa: 'Lemari',
      date: DateTime.now(),
      id: '4',
      image:
          'https://p7.hiclipart.com/preview/379/769/121/cupboard-cabinetry-clip-art-cupboard-png-thumbnail.jpg',
    ),
  );
  listQuiz.add(
    QuizModel(
      arab: 'زهرة',
      arabVoice: 'Voice 2',
      bahasa: 'Bunga',
      date: DateTime.now(),
      id: '5',
      image:
          'https://pluspng.com/img-png/flower-png-dahlia-flower-png-transparent-image-1644.png',
    ),
  );
  listQuiz.add(
    QuizModel(
      arab: 'منزل',
      arabVoice: 'Voice 2',
      bahasa: 'Rumah',
      date: DateTime.now(),
      id: '6',
      image:
          'https://www.freeiconspng.com/uploads/description-crystal-project-folder-home-8.png',
    ),
  );
  listQuiz.add(
    QuizModel(
      arab: 'الشجرة',
      arabVoice: 'Voice 2',
      bahasa: 'Pohon',
      date: DateTime.now(),
      id: '7',
      image:
          'https://www.freepnglogos.com/uploads/tree-plan-png/tree-plan-tree-png-image-purepng-transparent-png-image-12.png',
    ),
  );
  listQuiz.add(
    QuizModel(
      arab: 'الكتاب',
      arabVoice: 'Voice 2',
      bahasa: 'Buku',
      date: DateTime.now(),
      id: '8',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Gambar_Buku.png/464px-Gambar_Buku.png',
    ),
  );
  listQuiz.add(
    QuizModel(
      arab: 'قلم',
      arabVoice: 'Voice 2',
      bahasa: 'Pulpen',
      date: DateTime.now(),
      id: '9',
      image: 'https://pngimg.com/uploads/pen/pen_PNG7415.png',
    ),
  );
  return listQuiz;

}