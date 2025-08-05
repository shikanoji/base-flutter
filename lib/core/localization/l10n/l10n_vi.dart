// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class SVi extends S {
  SVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'Dự Án Flutter';

  @override
  String get hello => 'Xin chào';

  @override
  String welcome(String appName) {
    return 'Chào mừng đến với $appName';
  }

  @override
  String get login => 'Đăng nhập';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get email => 'Email';

  @override
  String get password => 'Mật khẩu';

  @override
  String get confirmPassword => 'Xác nhận mật khẩu';

  @override
  String get forgotPassword => 'Quên mật khẩu?';

  @override
  String get signUp => 'Đăng ký';

  @override
  String get signIn => 'Đăng nhập';

  @override
  String get save => 'Lưu';

  @override
  String get cancel => 'Hủy';

  @override
  String get ok => 'OK';

  @override
  String get yes => 'Có';

  @override
  String get no => 'Không';

  @override
  String get loading => 'Đang tải...';

  @override
  String get error => 'Lỗi';

  @override
  String get success => 'Thành công';

  @override
  String get warning => 'Cảnh báo';

  @override
  String get info => 'Thông tin';

  @override
  String get home => 'Trang chủ';

  @override
  String get profile => 'Hồ sơ';

  @override
  String get settings => 'Cài đặt';

  @override
  String get about => 'Giới thiệu';

  @override
  String get help => 'Trợ giúp';

  @override
  String get contactUs => 'Liên hệ';

  @override
  String get privacyPolicy => 'Chính sách bảo mật';

  @override
  String get termsOfService => 'Điều khoản sử dụng';

  @override
  String get darkMode => 'Chế độ tối';

  @override
  String get lightMode => 'Chế độ sáng';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get notifications => 'Thông báo';

  @override
  String get account => 'Tài khoản';

  @override
  String get security => 'Bảo mật';

  @override
  String get emailRequired => 'Email là bắt buộc';

  @override
  String get emailInvalid => 'Vui lòng nhập email hợp lệ';

  @override
  String get passwordRequired => 'Mật khẩu là bắt buộc';

  @override
  String get passwordTooShort => 'Mật khẩu phải có ít nhất 8 ký tự';

  @override
  String get passwordsDoNotMatch => 'Mật khẩu không khớp';

  @override
  String get loginSuccess => 'Đăng nhập thành công';

  @override
  String get loginFailed => 'Đăng nhập thất bại';

  @override
  String get logoutSuccess => 'Đăng xuất thành công';

  @override
  String get networkError => 'Lỗi mạng. Vui lòng kiểm tra kết nối.';

  @override
  String get serverError => 'Lỗi máy chủ. Vui lòng thử lại sau.';
}
