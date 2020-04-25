import 'package:karbarab/model/quiz.dart';
/*
=== quiz template ===
Quiz((u) => u
  ..arab = ''
  ..voice = ''
  ..bahasa = ''
  ..date = DateTime.now()
  ..cardCategory = CardCategory.Object
  ..voice = ''
  ..level = 1
  ..id = 'nomor',
  ..image = '',
),

*/
List<Quiz> getQuizData() {
  return [
    Quiz((u) => u
      ..arab = 'دَرَجَة'
      ..bahasa = 'Tangga'
      ..image = 'tangga.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '1'
    ),
    Quiz((u) => u
      ..arab = 'بَاب'
      ..bahasa = 'Pintu'
      ..image = 'pintu.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '2'
    ),
    Quiz((u) => u
      ..arab = 'كَنَّاسَة'
      ..bahasa = 'Sapu'
      ..image = 'sapu.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '3'
    ),
    Quiz((u) => u
      ..arab = 'سَجَّادَة'
      ..bahasa = 'Karpet'
      ..image = 'karpet.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '4'
    ),
    Quiz((u) => u
      ..arab = 'كُرْسِيّ'
      ..bahasa = 'Kursi'
      ..image = 'kursi.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '5'
    ),
    Quiz((u) => u
      ..arab = 'كَنَبَة'
      ..bahasa = 'Sofa'
      ..image = 'sofa.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '6'
    ),
    Quiz((u) => u
      ..arab = 'طَرَبِيْزَة'
      ..bahasa = 'Meja'
      ..image = 'meja.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '7'
    ),
    Quiz((u) => u
      ..arab = 'حَقِيْبَة'
      ..bahasa = 'Tas'
      ..image = 'tas.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '8'
    ),
    Quiz((u) => u
      ..arab = 'أَلْبِسَة'
      ..bahasa = 'Baju'
      ..image = 'baju.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '9'
    ),
    Quiz((u) => u
      ..arab = 'بُرْنَيطَة'
      ..bahasa = 'Topi'
      ..image = 'topi.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '10'
    ),
    Quiz((u) => u
      ..arab = 'تِلِفْزِيُون'
      ..bahasa = 'Televisi'
      ..image = 'televisi.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '11'
    ),
    Quiz((u) => u
      ..arab = 'بَيْت'
      ..bahasa = 'Rumah'
      ..image = 'rumah.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '12'
    ),
    Quiz((u) => u
      ..arab = 'نَافِذَة'
      ..bahasa = 'Jendela'
      ..image = 'jendela.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '13'
    ),
    Quiz((u) => u
      ..arab = 'جَزْمَة'
      ..bahasa = 'Sepatu'
      ..image = 'sepatu.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '14'
    ),
    Quiz((u) => u
      ..arab = 'شِبْشِب'
      ..bahasa = 'Sandal'
      ..image = 'sandal.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '15'
    ),
    Quiz((u) => u
      ..arab = 'سَاعَة'
      ..bahasa = 'Jam Dinding'
      ..image = 'jam-dinding.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '16'
    ),
    Quiz((u) => u
      ..arab = 'كَسْتَك'
      ..bahasa = 'Jam Tangan'
      ..image = 'jam-tangan.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '17'
    ),
    Quiz((u) => u
      ..arab = 'وَجْه'
      ..bahasa = 'Wajah'
      ..image = ''
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '18'
    ),Quiz((u) => u
      ..arab = 'أنْف'
      ..bahasa = 'Hidung'
      ..image = 'hidung.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '19'
    ),
    Quiz((u) => u
      ..arab = 'عَيْن'
      ..bahasa = 'Mata'
      ..image = 'mata.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '20'
    ),
    Quiz((u) => u
      ..arab = 'أُذُن'
      ..bahasa = 'Telinga'
      ..image = 'telinga.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '21'
    ),
    Quiz((u) => u
      ..arab = 'يَد'
      ..bahasa = 'Tangan'
      ..image = ''
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '22'
    ),Quiz((u) => u
      ..arab = 'صَحْفَة'
      ..bahasa = 'Piring'
      ..image = 'piring.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '23'
    ),
    Quiz((u) => u
      ..arab = 'جَرْدَل'
      ..bahasa = 'Ember'
      ..image = 'ember.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '24'
    ),
    Quiz((u) => u
      ..arab = 'مِظَلَّة'
      ..bahasa = 'Payung'
      ..image = 'payung.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '25'
    ),
    Quiz((u) => u
      ..arab = 'طَاسِ'
      ..bahasa = 'Gelas'
      ..image = 'gelas.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '26'
    ),
    Quiz((u) => u
      ..arab = 'سَيَّارَة'
      ..bahasa = 'Mobil'
      ..image = 'mobil.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '27'
    ),
    Quiz((u) => u
      ..arab = 'قَاطِرَة'
      ..bahasa = 'Kereta Api'
      ..image = 'kereta-api.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '28'
    ),
    Quiz((u) => u
      ..arab = 'سَفِيْنَة'
      ..bahasa = 'Kapal Laut'
      ..image = 'kapal-laut.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '29'
    ),
    Quiz((u) => u
      ..arab = 'لِلطَّائِرَات'
      ..bahasa = 'Pesawat Terbang'
      ..image = 'pesawat-terbang.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '30'
    ),
    Quiz((u) => u
      ..arab = 'بِسْكِلِيت'
      ..bahasa = 'Sepeda'
      ..image = 'sepeda.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '31'
    ),
    Quiz((u) => u
      ..arab = 'مُوتُوسِيكل'
      ..bahasa = 'Sepeda Motor'
      ..image = 'sepeda-motor.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '32'
    ),
    Quiz((u) => u
      ..arab = 'أمْطَرَ'
      ..bahasa = 'Hujan'
      ..image = ''
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '33'
    ),Quiz((u) => u
      ..arab = 'كُرَة'
      ..bahasa = 'Bola'
      ..image = 'bola.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '34'
    ),
    Quiz((u) => u
      ..arab = 'مَسْطَرَة'
      ..bahasa = 'Penggaris'
      ..image = 'penggaris.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '35'
    ),
    Quiz((u) => u
      ..arab = 'عَجَلَة'
      ..bahasa = 'Roda'
      ..image = 'roda.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '36'
    ),
    Quiz((u) => u
      ..arab = 'مُعَلِّم'
      ..bahasa = 'Guru'
      ..image = ''
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '37'
    ),Quiz((u) => u
      ..arab = 'مَدْرَسَة'
      ..bahasa = 'Sekolah'
      ..image = ''
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '38'
    ),Quiz((u) => u
      ..arab = 'مَكْتَب'
      ..bahasa = 'Kantor'
      ..image = ''
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '39'
    ),Quiz((u) => u
      ..arab = 'سُوْق'
      ..bahasa = 'Pasar'
      ..image = 'pasar.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '40'
    ),
    Quiz((u) => u
      ..arab = 'كِتَاب'
      ..bahasa = 'Buku'
      ..image = 'buku.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '41'
    ),
    Quiz((u) => u
      ..arab = 'قِنِّيْنَة'
      ..bahasa = 'Botol'
      ..image = 'botol.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '42'
    ),
    Quiz((u) => u
      ..arab = 'خِزَانَة'
      ..bahasa = 'Lemari'
      ..image = 'lemari.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '43'
    ),
    Quiz((u) => u
      ..arab = 'فِرَاش'
      ..bahasa = 'Kasur'
      ..image = 'kasur.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '44'
    ),
    Quiz((u) => u
      ..arab = 'مِفْتَاح'
      ..bahasa = 'Kunci'
      ..image = 'kunci.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '45'
    ),
    Quiz((u) => u
      ..arab = 'الأضواء'
      ..bahasa = 'Lampu'
      ..image = 'lampu.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '46'
    ),
    Quiz((u) => u
      ..arab = 'دَجَاجَة'
      ..bahasa = 'Ayam'
      ..image = 'ayam.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '47'
    ),
    Quiz((u) => u
      ..arab = 'بَعِيْر'
      ..bahasa = 'Unta'
      ..image = 'unta.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '48'
    ),
    Quiz((u) => u
      ..arab = 'حِصَان'
      ..bahasa = 'Kuda'
      ..image = 'kuda.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '49'
    ),
    Quiz((u) => u
      ..arab = 'نَظَّارَات'
      ..bahasa = 'Kacamata'
      ..image = 'kacamata.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '50'
    ),
    Quiz((u) => u
      ..arab = 'بُرْتُقَال'
      ..bahasa = 'Buah Jeruk'
      ..image = 'buah-jeruk.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '51'
    ),
    Quiz((u) => u
      ..arab = 'تُفَّاحَة'
      ..bahasa = 'Buah Apel'
      ..image = 'buah-apel.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '52'
    ),
    Quiz((u) => u
      ..arab = 'عِنَب'
      ..bahasa = 'Buah Anggur'
      ..image = 'buah-anggur.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '53'
    ),
    Quiz((u) => u
      ..arab = 'مَانْجَا'
      ..image = 'buah-mangga.jpg'
      ..bahasa = 'Buah Mangga'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '54'
    ),
    Quiz((u) => u
      ..arab = 'بَطَّة'
      ..bahasa = 'Bebek'
      ..image = 'bebek.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '55'
    ),
    Quiz((u) => u
      ..arab = 'وَزَّة'
      ..bahasa = 'Angsa'
      ..image = 'angsa.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '56'
    ),
    Quiz((u) => u
      ..arab = 'أرْنَب'
      ..bahasa = 'Kelinci'
      ..image = 'kelinci.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '57'
    ),
    Quiz((u) => u
      ..arab = 'مِعْز'
      ..bahasa = 'Kambing'
      ..image = 'kambing.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '58'
    ),
    Quiz((u) => u
      ..arab = 'بَقَرَة'
      ..bahasa = 'Sapi'
      ..image = 'sapi.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '59'
    ),
    Quiz((u) => u
      ..arab = 'جَامُوْس'
      ..bahasa = 'Kerbau'
      ..image = 'kerbau.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '60'
    ),
    Quiz((u) => u
      ..arab = 'مَوْز'
      ..bahasa = 'Buah Pisang'
      ..image = 'buah-pisang.jpg'
      ..date = DateTime.now()
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '61'
    ),
    Quiz((u) => u
      ..arab = 'مَاء'
      ..bahasa = 'Air'
      ..date = DateTime.now()
      ..image = ''
      ..cardCategory = CardCategory.Object
      ..voice = ''
      ..level = 1
      ..id = '62'
    ),
  ];
}
