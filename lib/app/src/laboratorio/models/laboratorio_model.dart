class Laboratorio {
  int id;
  String name;
  String location;
  double latitude;
  double longitude;
  String status;
  int capacity;
  bool isDeleted;
  bool isNaosei;

  Laboratorio(
      {this.id,
      this.name,
      this.location,
      this.latitude,
      this.longitude,
      this.status,
      this.capacity,
      this.isDeleted,
      this.isNaosei});

  Laboratorio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    status = json['status'];
    capacity = json['capacity'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['status'] = this.status;
    data['capacity'] = this.capacity;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}