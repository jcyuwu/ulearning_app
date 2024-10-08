class AppConstants {
  static const String SERVER_API_URL = "https://kindly-fun-mouse.ngrok-free.app/"; //ngrok
  //static const String SERVER_API_URL = "http://127.0.0.1:8000/"; //ios
  //static const String SERVER_API_URL = "http://10.0.2.2:8000/"; //android
  static const String IMAGE_UPLOADS_PATH = "${SERVER_API_URL}uploads/";
  static const String VIDEO_STREAM_PATH = "${SERVER_API_URL}video/";
  static const String STORAGE_USER_PROFILE_KEY = "user_profile";
  static const String STORAGE_USER_TOKEN_KEY = "user_token";
  static const String STORAGE_DEVICE_OPEN_FIRST_KEY = "first_time";
}