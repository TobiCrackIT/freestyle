class ItemModel{
  final String name, category;
  final double amount;
  final DateTime date;

  const ItemModel({required this.name,required this.category,required this.amount,required this.date});

  factory ItemModel.fromMap(Map<String,dynamic> map){
    final properties=map['properties'] as Map<String,dynamic>;
    final nameList = (properties['Name']?['title'] ?? []) as List;
    String category=properties['Category']?['select']?['name']??'Uncategorized';
    double amount=(properties['Price']?['number']??0).toDouble();
    var dateString=properties['Date']?['date']?['start'];
    DateTime date=dateString!=null?DateTime.parse(dateString):DateTime.now();


    return ItemModel(name: nameList.isNotEmpty ? nameList[0]['plain_text'] : 'Undefined', category: category, amount: amount, date: date);
  }
}