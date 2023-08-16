class MessageModel {
  String? SnederId;
  String? ReceiverId;
  String? DataTime;
  String? Text;

  MessageModel({
    this.SnederId,
    this.ReceiverId,
    this.DataTime,
    this.Text,
  });

  MessageModel.fromJson(Map<String, dynamic>? json) {
    SnederId = json?['SnederId'];
    ReceiverId = json?['ReceiverId'];
    DataTime = json?['DataTime'];
    Text = json?['Text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'SnederId': SnederId,
      'ReceiverId': ReceiverId,
      'DataTime': DataTime,
      'Text': Text,
    };
  }
}
