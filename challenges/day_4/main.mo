import Custom "custom";
import Animal "animal";
import List "mo:base/List";
import Iter "mo:base/Iter";
import Array "mo:base/Array";

actor {
    // Challenge 1
    // (Check files: main.mo , custom.mo)
    public type Customer = Custom.Customer;
    public func fun() : async Customer {
        let test_customer : Customer = {
            name = "Yamada";
            age = 30;
        };
        return test_customer;
    };

    // Challenge 2
    // (Check files: main.mo , animal.mo)
    public type Animal = Animal.Animal;
    var first_animal : Animal = {
        specie = "dog";
        energy = 42;
    };

    // Challenge 3
    // (Check file: animal.mo)

    // Challenge 4
    public func create_animal_then_takes_a_break(specie_of_type : Text, energy_point : Nat) : async Animal {
        let new_animal : Animal = {
            specie = specie_of_type;
            energy = energy_point;
        };
        return(Animal.animal_sleep(new_animal));
    };

    // Challenge 5
    public type List<Animal> = ?(Animal, List<Animal>);
    var animals : List<Animal> = List.nil<Animal>();

    // Challenge 6
    public func push_animal(animal : Animal) {
        animals := List.push<Animal>(animal, animals);
    };

    public func get_animals() : async [Animal] {
        return List.toArray<Animal>(animals);
    };
};
