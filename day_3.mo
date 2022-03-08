import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Option "mo:base/Option";
import Nat "mo:base/Nat";

actor day3 {

    //1
    public func swap(a : [Nat], i : Nat, j : Nat) : async [Nat] {
        var aux : Nat = a[i];
        var tmp : [var Nat] = Array.thaw(a);
        tmp[i] := tmp[j];
        tmp[j] := aux;
        return Array.freeze(tmp);
    };

    //2
    public func init_count(n : Nat) : async [Nat] {
        var array = Array.init<Nat>(n,0);
        for (i in Iter.range(0,n-1)){
            array[i] := i;
        };
        return Array.freeze(array);
    };

    //3
    public func seven(array : [Nat]) : async Text {
        for (i in array.vals()){
            if (i == 7){
                return "Seven is found";
            };
        };
        return "Seven not found";
    };

    //4
    public func nat_opt_to_nat (n : ?Nat, m : Nat) : async Nat {
        switch(n){
            // Case where n is null
            case(null) {
                return (m);
            };
            // Case where n is a nat
            case(?Nat){
                // still returns 0 when n is empty
                return (Option.get<Nat>(n, m));
            };
        };
    };

    //5
    public func day_of_the_week(n : Nat) : async ?Text {
        switch(n){
            case(1) {
                return Option.make<Text>("Monday");
            };
            case(2) {
                return Option.make<Text>("Tuesday");
            };
            case(3) {
                return Option.make<Text>("Wednesday");
            };
            case(4) {
                // Not sure if there is difference, both ways work and returns the same
                return ?"Thursday";
            };
            case(5) {
                return ?"Friday";
            };
            case(6) {
                return ?"Saturday";
            };
            case(7) {
                return ?"Sunday";
            };
            case(_) {
                return null;
            };
        };
        //return null;
    };

    //6
    public func populate_array(array : [?Nat]) : async [Nat] {
        let f = func (n : Nat) : Nat {
            return (Option.get<Nat>(array[n], 0));
        };
        return Array.tabulate<Nat>(array.size(), f);
    };

    //7
    public func sum_of_array(array : [Nat]) : async Nat {
        return Array.foldLeft(array, 0, Nat.add);
    };

    //8
    public func squared_array(array : [Nat]) : async [Nat] {
        let f = func (n : Nat) : Nat {
            return n*n;
        };
        return Array.map<Nat, Nat>(array, f);
    };

    //9
    public func increase_by_index(array : [Nat]) : async [Nat] {
        let f = func (n : Nat) : Nat {
            return array[n]+n;
        };
        return Array.tabulate<Nat>(array.size(), f);
    };

    //10
    // I guess I need more explanatory task, not sure what is required
};