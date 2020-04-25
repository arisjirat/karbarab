# Karbarab

is a guessing arab card game for 🇮🇩 people. this project is a starting with Flutter. IOS not ready for now,
I don't when I will paid to apple $99 💰

### Feature: 🥳🥳🥳🥳
- Google Signin
- Guess Signin
- Sync with google after signup
- Choose card game mode
- Answer, there is 4 options and 1 is right answer. for initial you have 30 points, and decrease when you choose the wrong answer. then if you get right answer you will get that points.
- Hint with ads admob rewards video
- Save score on account
- Send card to they friend or unknown user, and answer the question, if they friend get wrong answer, you will have points. initial user have 15 chance.
- Notification when send card, and answer quiz
- Global Score (Watch ads first)
- Admob For Hint, Global Score 15minutes, Request Limit send card (15 chance)

##### Next Feature: 😎
- Quiz Sentence
- Nearby

##### Todo: 👻👻
- Add quiz
- IOS sync 😴😴
- Cleaning! 👻👻
- Request from api with firebase function

### Run with flavor
Run develop with flavor
```flutter run --flavor development -t lib/main_dev.dart```

```flutter run --flavor staging -t lib/stag.dart```

```flutter run --flavor production -t lib/prod.dart```

### Release with flavor
Run develop with flavor
```flutter run --release --flavor development -t lib/main_dev.dart```

```flutter run --release --flavor staging -t lib/stag.dart```

```flutter run --release --flavor production -t lib/prod.dart```

### Release app bundle with flavor 🤘
🤘 don't forget to update version 🤘
```flutter build appbundle --release --flavor production -t lib/main_prod.dart```


### CLI on development

Icon generator to main ```flutter pub run flutter_launcher_icons:main```

Watch to generte from model *.g.dart ```flutter pub run build_runner watch```