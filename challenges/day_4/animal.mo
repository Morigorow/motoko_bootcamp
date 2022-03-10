module {
    // Challenge 2
    public type Animal = {
        specie : Text;
        energy : Nat;
    };

    // Challenge 3
    public func animal_sleep(animal : Animal) : Animal {
        let sleeping_animal : Animal = {
            specie = animal.specie;
            energy = animal.energy + 10;
        };
        return sleeping_animal;
    };
};