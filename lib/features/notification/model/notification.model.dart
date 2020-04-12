class DataModel {
  String image;
  String collapseKey;
  String googleOriginalPriority;
  String quizId;
  String targetScore;
  String gameMode;
  String googleDeliveredPriority;
  String userSenderUsername;
  String clickAction;
  String googleMessageId;
  String scoreId;

  DataModel({
    this.image,
    this.collapseKey,
    this.googleOriginalPriority,
    this.quizId,
    this.targetScore,
    this.gameMode,
    this.googleDeliveredPriority,
    this.userSenderUsername,
    this.clickAction,
    this.googleMessageId,
    this.scoreId,
  });

  DataModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    collapseKey = json['collapse_key'];
    googleOriginalPriority = json['google.original_priority'];
    quizId = json['quizId'];
    targetScore = json['targetScore'];
    gameMode = json['gameMode'];
    googleDeliveredPriority = json['google.delivered_priority'];
    userSenderUsername = json['userSenderUsername'];
    clickAction = json['click_action'];
    googleMessageId = json['google.message_id'];
    scoreId = json['scoreId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['image'] = image;
    data['collapse_key'] = collapseKey;
    data['google.original_priority'] = googleOriginalPriority;
    data['quizId'] = quizId;
    data['targetScore'] = targetScore;
    data['gameMode'] = gameMode;
    data['google.delivered_priority'] = googleDeliveredPriority;
    data['userSenderUsername'] = userSenderUsername;
    data['click_action'] = clickAction;
    data['google.message_id'] = googleMessageId;
    data['scoreId'] = scoreId;
    return data;
  }
}
