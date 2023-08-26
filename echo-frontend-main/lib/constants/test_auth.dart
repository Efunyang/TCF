import 'package:echo_frontend/models/auth.dart';
import 'package:echo_frontend/models/user.dart';

final kAuths = [
  Auth(
    uid: '1',
    token: '123',
    refresh: '123',
  )
];

final kUsers = [
  User(
    uid: '1',
    avatar: 'https://cdn.pixabay.com/photo/2022/08/09/16/19/sea-7375377_1280.jpg',
    email: 'test1@gmail.com',
    displayName: 'Test User',
    emailActive: true,
    carbonReduction: 20.0,
    point: 56,
  )
];
