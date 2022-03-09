module {
    public type Animal = {
        specie: Text;
        energy: Nat;
    };

    //3
    public func animal_sleep(a: Animal): Animal {
        return {
            specie = a.specie;
            energy = a.energy + 10;
        };
    }
}