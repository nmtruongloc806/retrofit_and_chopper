
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  static late SharedPreferences prefs;

  static innitAppSetting() async {
    prefs = await SharedPreferences.getInstance();
  }

  ///get dynamic
  static T getValue<T>(KeyAppSetting key) {
    try {
      return prefs.get(key.toString()) as T;
    } catch (error) {
      print(key);
      throw (error);
    }
  }

  ///set dynamic
  static setValue<T>(KeyAppSetting key, dynamic value) {
    try {
      if (value != null) {
        switch (T) {
          case int:
            prefs.setInt(key.toString(), value);
            break;
          case String:
            prefs.setString(key.toString(), value);
            break;
          case double:
            prefs.setDouble(key.toString(), value);
            break;
          case bool:
            prefs.setBool(key.toString(), value);
            break;
          default:
            prefs.setString(key.toString(), value);
            break;
        }
      }
    } catch (error) {
      throw (error);
    }
  }

  static void clearAllSharePref() {
    setValue<int>(KeyAppSetting.userPortalID, 0);
    setValue<int>(KeyAppSetting.userMasterID, 0);
    setValue<int>(KeyAppSetting.userID, 0);
    setValue<int>(KeyAppSetting.phongBanID, 0);
    setValue<int>(KeyAppSetting.phuongXaID, 0);
    setValue<int>(KeyAppSetting.quanHuyenID, 0);
    setValue<int>(KeyAppSetting.informationID, 0);

    setValue<int>(KeyAppSetting.donViID, 0);
    setValue<String>(KeyAppSetting.fullName, '');
    setValue<String>(KeyAppSetting.urlImage, '');
    setValue<String>(KeyAppSetting.userName, '');
    setValue<String>(KeyAppSetting.phone, '');
    setValue<String>(KeyAppSetting.email, '');
    setValue<String>(KeyAppSetting.tenChucVu, '');
    setValue<String>(KeyAppSetting.maDonVi, '');
    setValue<String>(KeyAppSetting.tenDonVi, '');
    setValue<String>(KeyAppSetting.maPhuongXa, '');
    setValue<String>(KeyAppSetting.tenPhuongXa, '');
    setValue<String>(KeyAppSetting.roleNameStr, '');
    setValue<String>(KeyAppSetting.token, '');

    setValue<int>(KeyAppSetting.informationID, 0);
    setValue<bool>(KeyAppSetting.isBiometric, false);
    setValue<bool>(KeyAppSetting.isTrusted, false);
    setValue<String>(KeyAppSetting.hashPassCode, '');
    //setValue<bool>(KeyAppSetting.isMobileLayout, true);
  }
}

enum KeyAppSetting {
  /// type: int
  userPortalID,

  /// type: int
  userMasterID,

  /// type: int
  userID,

  /// type: int
  phongBanID,

  /// type: int
  phuongXaID,

  /// type: int
  quanHuyenID,

  /// type: int
  donViID,

  /// type: String
  fullName,

  /// type: String
  urlImage,

  /// type: String
  userName,

  /// type: String
  phone,

  /// type: String
  email,

  /// type: String
  tenChucVu,

  /// type: String
  maDonVi,

  /// type: String
  tenDonVi,

  /// type: String
  maPhuongXa,

  /// type: String
  tenPhuongXa,

  /// type: String
  roleNameStr,

  /// type: String
  token,

  ///type: bool
  checkDSTaiKhoan,

  ///type: bool
  isCheckPhanAnhCu,

  ///type: String
  hashPassCode,

  ///type: bool
  isBiometric,

  ///type: bool
  isTrusted,

  ///type: int
  informationID,

  ///type: bool
  isMobileLayout,

  ///type: String
  jwtToken,

  ///type: String
  deviceID,

  /// type: int
  countLogOut
}
