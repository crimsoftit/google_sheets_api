import 'package:google_sheets_api/models/inv_model.dart';
import 'package:gsheets/gsheets.dart';

class InvSheetsApi {
  static const gsheetCredentials = r'''
    {
      "type": "service_account",
      "project_id": "duara-977ea",
      "private_key_id": "904a8f8fefe8287c9c746584629f4c172611310e",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCsoulWn6cG7+KV\nCol95lcRGv/GhPyGu9iSTjFyGNrr8XlsOIb7U93BE78r2OetJpdTUtEVS0tqQl+A\n3fxaBpuagRAiryI39750bq53PQOu7PmJkqknJulJwfNXj5eGFQt/i7a+1M3uaC8J\nJAPcBFTPmG6pKvIXiRnBTR2F4eJlSVhSApKkOPmT3HwGDbQ81mEGhClfYRmq0Lsu\nftGlsn9GuX5pbazYZIxKHHoNw6AiYGJGToR1/uOytG4mI0JxlxtMEnOE6Z0K2i99\nfQJgv88XZP9tfawpCXAR9CLGKV8DtZ84yDKhkyUL6S66OIWYGNCYX20Sk++LsrDM\nYwUYHqCrAgMBAAECggEABBDtcG4TBj80L2p8hPI3iF5obXAu1BJfx+JlMiWS7A4k\nW//HPh6VkVMG8Uakl+SmzJgD9xc7T+XMT6hRP0jHwkKnJj0vXL4bE3osspl45e/Z\nWMiTIpCKDupG8jME0J9CRav9KLV+b2hIybntbvGZkpVc73yxdj7ZoNhRVhi7g/Zf\nLd7MVMtDapncngaDtGL7OZj0e29K6aNdgt8sNhZlE6ebQhG/qbo3uIkJczVt69zV\nUwLN7ewheF4CwQLS0nDmvw9jhwdNK9m12E2KbChYEkg+qQhAV7MhEmWZjNA8taXy\n3BA1reIwHn6QwyJiQjz+1liAkl6wOhNZagoajPWZ8QKBgQDXQkW4ZYIEKP7pAWrN\nfDfAecfyKYxCaGb14+52J9OBriWQWLIYf9y9bxwPeiqcoAdq2PeMCt8SDj6xcBYS\nLicHS/Rh+EaFbF1vh5vcBac2xXcV6ozBGeLpokOGA0mpOFBdEM5DVcKwYzCv86Dw\nR7lD/HqfxvRMXBe6hEt7Bsu69wKBgQDNT34hGIEwjCeJ4dHp635Ah0P/Secos4pZ\n6pdoneDaoJ/JKyrfmBo9+urb14PdBILUBzk6PQJVLN8YfJsuMjxWFHYAkFjki+Yl\nUsnxmbmgcTBLFSHpzo7hVQsKWaFMZtmZH7SnXq0pyFEha8ikRQU3iiiDlNnqknQb\nImzipvVG7QKBgQCXnvShB87mw0GaOgdSqdZTWvQ9XIqRFBzBwkTrMO5H/7Qx0mfP\n3fBL9oFbXX+6RvYyipUDLX0mqKX8Mak6MQwIlbWTdF+oB0ZhErHz7n9zku9onod6\nVJOCYWsScCpoaWQhyX6f6z5xI8zdgsuvs7WJb8On22mkh5GnLRxFkenazQKBgERf\nQbDB2VwSgKRRWLee3hedNE7TDLEoQV26WxvS3+vO7AdxYcC+hZa4dfgqaFZ1RyBX\nG37CjIFTBSTBcmhLAH7mJ3n+mCvcTxOE442a1Q+SQjPu4LFdQYXW7WtP+ABajAKL\nZX0LcX1loWcQ3uudtKQPVXikXIHareHPcBV25l3tAoGAJvgU9PcJX1SQF4Arh3Vt\njJFhBPEBUtoUh46FvF1FW5mSqHn9wtUEkOalU8Pd7jOrNcLatyLejeATWGe5I/9k\nQbsV6cvSJhGOfFdos3+dLvOg9AdrdPTr6LTI+8bPukZRE2t2xGEhpyEqsurbQ0XK\nBL/lnhNin2F6EhAGN/wwmHA=\n-----END PRIVATE KEY-----\n",
      "client_email": "gsheets-487@duara-977ea.iam.gserviceaccount.com",
      "client_id": "103689853256596973389",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets-487%40duara-977ea.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    }
  ''';
  static const spreadsheetId = '1Igy_g38DTIZ7LkNUF1aOKu63cD5Ilxx6SU_I71YEtss';
  static final gsheets = GSheets(gsheetCredentials);
  static Worksheet? invSheet;

  static Future init() async {
    try {
      final spreadsheet = await gsheets.spreadsheet(spreadsheetId);

      invSheet = await getWorkSheet(
        spreadsheet,
        title: 'InvSheet',
      );

      final headers = InvModel.getHeaders();
      invSheet!.values.insertRow(1, headers);
      print('HEADERS SET!!');
    } catch (e) {
      //ScaffoldMessenger.of(context).
      print('gsheet api init error: $e');
    }
  }

  static Future<Worksheet?> getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title);
    }
  }
}
