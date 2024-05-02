/****_------------forma erronia Open-Closed Principle----------***/
class CarErr {
  final String brand;
  CarErr(this.brand);
}

void getAveragePriceErr(List<CarErr> cars) {
  for (var car in cars) {
    if (car.brand == "Ferarri") print(10000); //Is open for its edition (It cannot be)
    if (car.brand == "Tesla") print(20000);
  }
}

// void main() {
//   List<CarErr> cars = [CarErr("Ferarri"), CarErr("Tesla")];
//   getAveragePriceErr(cars);
// }

/****_------------forma correta Open-Closed Principle----------***/
abstract class Car {
  int averagePrince();
}

class Ferrari extends Car {
  @override
  int averagePrince() {
    return 10000;
  }
}

class Tesla extends Car {
  @override
  int averagePrince() {
    return 20000;
  }
}

void getAveragePrice(List<Car> cars) {
  for (var car in cars) {
    print(car.averagePrince());
  }
}

// void main() {
//   List<Car> cars = [Ferrari(), Tesla()];
//   getAveragePrice(cars);
// }

/****_------------forma erronia Liskov Principle----------***/

class Dog {
  void makeSound() {
    print("Bark");
  }
}

class Cat {
  void makeSound() {
    print("Meow");
  }
}

// void main() {
//   Dog dog = Dog();
//   Cat cat = Cat();
//   dog.makeSound();
//   cat.makeSound();
// }

/****_------------forma correta Liskov Principle----------***/

class Animal {
  void makeSound() {
    print("Sound");
  }
}

class Dog1 extends Animal {
  @override
  void makeSound() {
    print("Bark");
  }
}

class Cat1 extends Animal {
  @override
  void makeSound() {
    print("Meow");
  }
}

// void main() {
//   Animal myPet = Dog1();
//   myPet.makeSound();
// }

/****_------------forma erronia interface segregation Principle----------***/

abstract class Bird {
  void fly();
  void eat();
  void swim();
}

class Parrot implements Bird {
  @override
  void eat() {
    print("eat");
  }

  @override
  void fly() {
    print("fly");
  }

  @override
  void swim() {
    throw UnimplementedError(); // this is not needed, because Parrot does not swim
  }
}

class Penguin implements Bird {
  @override
  void eat() {
    print("eat");
  }

  @override
  void fly() {
    throw UnimplementedError(); // this is not needed, because Penguin does not fly
  }

  @override
  void swim() {
    print("swimming");
  }
}

// void main() {
//   Parrot parrot = Parrot();
//   parrot.eat();
//   parrot.fly();
//   parrot.swim(); // Parrot should not be able to swim
//   Penguin penguin = Penguin();
//   penguin.eat();
//   penguin.fly(); // Penguin should not be able to fly
//   penguin.swim();
// }

/****_------------forma correta interface segregation Principle----------***/

abstract class Bird1 {
  void eat();
}

abstract class Flying {
  void fly();
}

abstract class Swimmer {
  void swim();
}

abstract class Walker {
  void walk();
}

class Parrot1 implements Bird1, Flying, Walker {
  // Now we don't need to implement swim() since Parrot does not swim
  @override
  void eat() {
    print("eating");
  }

  @override
  void fly() {
    print("flying");
  }

  @override
  void walk() {
    print("walking");
  }
}

class Penguin1 implements Bird1, Walker, Swimmer {
  // Now we don't need to implement fly() since Penguin does not fly
  @override
  void eat() {
    print("eating");
  }

  @override
  void walk() {
    print("walking");
  }

  @override
  void swim() {
    print("swimming");
  }
}


// void main() {
//   Parrot1 parrot = Parrot1();
//   parrot.eat();
//   parrot.fly();
//   parrot.walk();
//   // parrot.swim(); It will throw an error
//   Penguin1 penguin = Penguin1();
//   penguin.eat();
//   penguin.walk();
//   // penguin.fly(); It will throw an error
// }



/****_------------forma erronia inversion dependency Principle----------***/

class Fireabase {
  Future<String> getData(){
    return Future.value("get from fireabase");
  }
}


class DatabaseRepository{
  Fireabase _fireabase;

  DatabaseRepository(this._fireabase);

  Future<void> getDataFromDb() async{
    final data = await _fireabase.getData();
    print("data: $data");
  }


}


// void main(){
//   final repository = DatabaseRepository(Fireabase());// It depends on Firebase, which is a key dependency. 
//   //Now, if we need to switch from Firebase to PostgreSQL, we'll have to make changes throughout the codebase where Firebase is currently utilized.
//   repository.getDataFromDb();
// }

/****_------------forma correcta inversion dependency Principle----------***/

abstract class DbService{
  Future<String> getData();
}

class FirebaseService implements DbService{
  @override
  Future<String> getData() {
    return Future.value("get from fireabase");
  }
}

class PostgreSQLService implements DbService{
  @override
  Future<String> getData() {
    return Future.value("get from PostgreSQL");
  }
}

class DbRepository{
  DbService _dbService;

  DbRepository(this._dbService);

  Future<void> getDataFromDb() async{
    final data = await _dbService.getData();
    print(data);
  }
}

void main(){
  final repository = DbRepository(FirebaseService());// now we can change easily from firebase to PostgreSQL
  repository.getDataFromDb();

  final repository2 = DbRepository(PostgreSQLService());
  repository2.getDataFromDb();
}


