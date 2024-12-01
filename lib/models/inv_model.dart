class InvModel {
  /// -- VARIABLES --
  // headers
  static const String itemId = 'itemId';
  static const String itemName = 'itemName';
  static const String itemQty = 'quantity';
  static const String itemBp = 'buyingPrice';

  static List<String> getHeaders() {
    return [
      itemId,
      itemName,
      itemQty,
      itemBp,
    ];
  }
}
