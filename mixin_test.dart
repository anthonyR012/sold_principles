abstract class Repository {}

abstract class Posgresql extends Repository {}

abstract class Sqlite extends Repository {}


mixin GetM {
  void get({required String name}) {
    print("gettting data $name");
  }
}

mixin CreateM {
  void create({required String name}) {
    print("creating data $name");
  }
}

mixin UpdateM {
  void update({required String name}) {
    print("Update data $name");
  }
}

class CategoryRemote extends Posgresql with GetM, CreateM {}
class UserRemote extends Posgresql with  CreateM {}
class UserLocal extends Sqlite with  CreateM {}

void main() {
  CategoryRemote().create(name: "CategoryRemote");
  CategoryRemote().get(name: "CategoryRemote");

  print("-----------------------------");

  UserRemote().create(name: "UserRemote");
  // UserRemote().get(name: "UserRemote"); This will throw an error since User does not have get Mixin

  UserLocal().create(name: "UserLocal");
  // print(UserLocal() is Repository); // true
}