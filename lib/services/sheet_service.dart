import 'package:google_sheet/model/user_model.dart';
import 'package:gsheets/gsheets.dart';

class SheetsApi {
  static const credentials = r'''{
  "type": "service_account",
  "project_id": "healthy-kayak-442604-h3",
  "private_key_id": "c7f5c0e8318967018167b2df0df01723552da7b0",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDOMyIoRycQwg/s\nBYVxyoKET58CEQacOYU6J7TVmtCRSlNF4ZVWZfv02AMJi9l3+pIyEUurKetcO//V\npSJJcDNhwF/GsQU+tj3SnFGWBV/2on6YZ40iUL5o7zf3Y5hHbABC0UZA6Z3enAX3\nNu30XVYqrnzl4PP0z+W5/gCcPvh+GaKMa+ZPWU+pd2E2zsZV+99YLKq0e+GoepRF\n/DjI+tBhznRh9i2DLcKdXsZRz3vX5eE+jC4lj8KYQQxUTJn/f1iOHYUetncqXLSn\n6bLadZGUcPaeXUy/oCphh/XPD+l8FTa0PNpdMC1QPvd8vCQh3eejOF1+Egs/sqUB\nhsc8GKCbAgMBAAECggEAE1RQxeTRoS0H8BCeb0nUDVInbjqpW3i65/Yz6fguyAfn\nIXxhku1RfqTHOBxfgPNAxCfB56Qw138aXu0xdx/o+Sde8xHCE5xi1DzqGv2a/tRB\nuMiwPsDB8LVIEk1IR520so7Knqgnr+gBWSjRiqA7RRoBRE1foRniB5rrdLokcjGK\n4VDNq6/BE0ZtRW4xsSolnHgBC4O5Lm7/7PrtxRSpwI+e0u2OQDmXatdMPDR1zyww\nzjUPnLhQygnUf4AGJpAxE6tVeZYvEVyOIEIpnPHsc9aq7iO3q8TyhG9sdibtsodd\nEinfsNz/oa+2aQGeGmol7z7iMfZjmfHn0yBie3oTXQKBgQDv1g0uWLoNw5m0XNcU\ncg9alEAJkpp22StrgQo42YChrhujWbsMAg8YQzQzGTLDKywF+SjqQU7XCHp0zLVI\nCrcJJFG5KD7xfe3Xy2/x8pObYgQWfCBPT3GlT8gE3P9uqmBYYKGj4OtRvJNJOfYq\nNmIiLq8T3kaT//bVSq5IBJE1DQKBgQDcGL7PceKggjDowhI7zaMa9dHFwnHmZYsG\nLxsYyo92Qsx9dfleOg7d1qA02/NfqXR0uaxyAjel7+H9C4R/9M9TZgdWVN0gzy5G\nUKkYmI/q6g9rUdxoHTYyK/EdvNs1+2UWRHt8td60K4ssjbyTOQAJ0cKAx+tnO9ZS\nuTuldHgSRwKBgDFiu04a2RzydRkNsQA1yHGXa2RNOt9UMrutU6SHLRSd3HUTig+b\n8O3HEN2gx7ImlqcYOlOaZRikV0rryDxwcGZCg02EOwnRK4OvEXsZv0lUspDKuIB8\nVGN8/Sv7MeHg1Xv9UeuD6hDnqtB+TfE9R5HQWR7XO2NIZtRez2pm/luVAoGAKtGt\nnZIccvmhJkdLYNMa3k3gp8ayfg5XQ7a6YNJXorxQKEBhaVGGPuZYeLAp4vyGqYbN\n48hGp0PKBX7OIk6wXxtEZilQc+eaqxdaLmzP4vXyVgCxDphQSOZ/nDd3tkLYYcKk\n+5guYYLvKpXQkBvQxBhI7OD4DTd49NMQpZnJGlUCgYAb4n+oG+fUjr68Cye+YH5q\noK5TWkkB028xzlQNpqGei+Ux+wQhiEtrWED6LsZmfnwEHFS0FVXj3bK/pozmdSMV\nGpSHxyHKEp31VINylbfSTFUsBpM8S/K/jD1QWYoPGRiF1YfiOdXPXVsVU5Cng7H8\nzBMQOiuEmloznlAKTVHPEw==\n-----END PRIVATE KEY-----\n",
  "client_email": "google-sheets@healthy-kayak-442604-h3.iam.gserviceaccount.com",
  "client_id": "114131269673329969336",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/google-sheets%40healthy-kayak-442604-h3.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}''';

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
