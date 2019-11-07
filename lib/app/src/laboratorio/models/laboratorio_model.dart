class Laboratorio {
  int id;
  String name;
  String location;
  String status;
  int capacity;
  bool isDeleted;
  bool active;

  Laboratorio(
      {this.id,
      this.name,
      this.location,
      this.status,
      this.capacity,
      this.isDeleted,
      this.active});

  Laboratorio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    status = json['status'];
    capacity = json['capacity'];
    isDeleted = json['isDeleted'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['status'] = this.status;
    data['capacity'] = this.capacity;
    data['isDeleted'] = this.isDeleted;
    data['active'] = this.active;
    return data;
  }
}