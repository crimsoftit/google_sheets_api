class TxnModel {
  /// -- VARIABLES --
  // headers
  static const String txnId = 'txnId';
  static const String txnName = 'txnName';
  static const String txnQty = 'quantity';
  static const String txnAmount = 'amount';

  static List<String> getHeaders() {
    return [
      txnId,
      txnName,
      txnQty,
      txnAmount,
    ];
  }
}
