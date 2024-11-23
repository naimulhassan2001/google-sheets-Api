import 'package:google_sheet/model/user_model.dart';
import 'package:gsheets/gsheets.dart';

class SheetsApi {
  static const credentials = r'''{
  "type": "service_account",
  "project_id": "healthy-kayak-442604-h3",
  "private_key_id": "48532c8ad97b8dc166f136132760673a1918a4d5",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCm9EAQR095SttQ\nCE7Y2pVabpCf/ynpcHmD37vFDqzE0QJvEIeRutRa6cTcbhhyqYXBVz2W+Arw9dOq\nxY2fAyqVn+6EG2aCpBfLJYpE+chtGAu3wic04vEk5hzN/UuO0V8jMxCuwuHCoWzv\nCrHudRiMyEBSBQsz2Rq0vCNFk0M5ehSIrnmTmDI6aEIqZf6GdcLU84iqw+pXFwkW\nj3nEisz3CH/RKHvqQpZoMIPygUueN0fcgmolxt/OoVBfEYKOk/rHtdFTU/tNQfrD\nl1O8/dtcqEMT9gG4X1aMu0scwMapVwk+aGzUmPQYeMfffeZ2IBGIYncyMKNjVX+j\nsWQf0LQ9AgMBAAECggEADDZR7f7msNF0G7Vn3b6WGIXS6BPYQyjvh+EYkTsCvJN/\nUT7NHoX4h5KRoarJ+K/ZcVbffJ4LNYH90tWIMklJ1vpaY5PE2qnZywnQGeiIK8wL\npgw6evNeE/FjH6w3V9c31XwkQcGj6u03lIAHRjvkKP7IOa0AcJv2XfcPFhqbWxD/\nxfgsSp51kQLuNKV8EPlQD+SBXqVEvLAI920vFRpR3UMZ+F4YCX71aAHCNXva0KR4\ncBnTMoL2RQ1tpIH238Ido5hpZ5YIFFP2os0eBzTALi59H1WTZOtIPW1dtB19ZxIz\nmeBVrs0LZUbeho4qXlvQU3/5WdLb1LgdmorVKaFuoQKBgQDkBQnh25Y1qyITvQZh\nrXdWJeTQP0Tv8auoixjalkSX4VWxV3CGrl2LbRRkQau96tWQLBnmzhhyHmzlwfQk\nRzfg40HWS40iwrombO8EU2f9+Kk1Fm+o4cwd1w4BAWOqxhLzGSyDD1jcWA7lJue5\nlcesyRFODjJnmeUUtSOW4gse8QKBgQC7cOkev29e2z0S2ZUVV6kqmxKazzLuXYKk\nq38ac+XWH3I2oPKiS8Oi5LnDgY1h9K1STTxXtoPDWmdp7owF/lMCr9csuJN//YwT\nqwBO01eKul+yKEe/bHAubXHz8+g6m8FU4THKU8txjDCvVaiBT/swOkJL1gGUqU2L\n+q33J6ZCDQKBgQDEagayNFn2zvxirlAB8c+7OJcaP3XdjnqEi5UULZ7WibcsNRrs\nGOThhkurdNpAlTnzn9mL9HogS08YtvLcETD0Gi6LLrdbewuor+tP+Zy5q+ntne7/\nNcmC5s3cVdsJrueB2mx6VM0BuSTThajUN04x611ptFb84RbwuHv4q6xSsQKBgHu9\nyZhr5tknQQVtsNb7HQmsgDbFLKliADo3oVxUQNn/voXD8QolnEywVNZ1c2HEhpt7\ns6dwLUJNL1ImkjfustxmO1Yhr/Zh6xSc4kInkXZbHYvevaborpJn3D+huKDgbFxd\nomIguYEHfKhzkx9zLq+i9ltcN4Tt0+ziG/C7My4NAoGAKUaGeraQ5SnXYXWNffbU\nzb9X8DsnqOPhlpSIgN1pjFiukQ3xLDVORbXsdmS2ERzjSN7lIAP31knkUv+8pSxr\nvwKgwuiXx0XaxUfoN9tus3Hf1XaCd/8XwFMOe1I7aeSTelmFiupVIADimFjnawEc\nWVhGRX74opKLJurJxYOROO4=\n-----END PRIVATE KEY-----\n",
  "client_email": "google-sheet@healthy-kayak-442604-h3.iam.gserviceaccount.com",
  "client_id": "118056912411566717715",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/google-sheet%40healthy-kayak-442604-h3.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

  static const sheetId = "1gJ0qc63AX24KrDRspy5myp3uJpNVzVDx7R9dkX5otNU";

  static final gSheet = GSheets(credentials);
  static Worksheet? userSheet;

  static Future init() async {
    try {
      final spreadsheet = await gSheet.spreadsheet(sheetId);

      userSheet = await _getWorkSheet(spreadsheet, title: "Users");

      final firstRow = UserFields.getFields();
      userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      pragma("error $e");
    }
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return userSheet = await spreadsheet.addWorksheet(title);
    } catch (e) {
      print(e);
      return userSheet = spreadsheet.worksheetByTitle(title)!;
    }
  }
}
