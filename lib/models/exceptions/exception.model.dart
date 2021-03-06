import 'dart:convert';

class CleanExeptionModel {
  int statusCode;
  String error;
  List<Message> message;

  CleanExeptionModel({
    this.statusCode,
    this.error,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'error': error,
      'message': message?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory CleanExeptionModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CleanExeptionModel(
      statusCode: map['statusCode'],
      error: map['error'],
      message:
          List<Message>.from(map['message']?.map((x) => Message.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CleanExeptionModel.fromJson(String source) =>
      CleanExeptionModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'Autogenerated(statusCode: $statusCode, error: $error, message: $message)';
}

class Message {
  List<Messages> messages;

  Message({
    this.messages,
  });

  Map<String, dynamic> toMap() {
    return {
      'messages': messages?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Message(
      messages:
          List<Messages>.from(map['messages']?.map((x) => Messages.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));

  @override
  String toString() => 'Message(messages: $messages)';
}

class Messages {
  String id;
  String message;

  Messages({
    this.id,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
    };
  }

  factory Messages.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Messages(
      id: map['id'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Messages.fromJson(String source) =>
      Messages.fromMap(json.decode(source));

  @override
  String toString() => 'Messages(id: $id, message: $message)';
}
