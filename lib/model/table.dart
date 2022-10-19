class Table {
  String? tableUID;
  String? tableName;
  String? tableAvatarUrl;
  String? tableEmail;
  Table({this.tableUID, this.tableName, this.tableAvatarUrl, this.tableEmail});
  Table.fromJson(Map<String, dynamic> json) {
    tableUID = json['sellerUID'];
    tableName = json['sellerName'];
    tableAvatarUrl = json['sellerAvatarUrl'];
    tableEmail = json['sellerEmail'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tableUID'] = this.tableUID;
    data['tableName'] = this.tableName;
    data['tableAvatarUrl'] = this.tableAvatarUrl;
    data['tableEmail'] = this.tableEmail;
    return data;
  }
}
