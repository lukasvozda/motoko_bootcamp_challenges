import Array "mo:base/Array";
import I "mo:base/Iter";

actor Day1 {
    var counter : Int = 0;

    //1
    public func add(n : Nat, m : Nat) : async Nat {
        return n + m;
    };

    //2
    public func square(n : Nat) : async Nat {
        return n*n;
    };

    //3
    public func days_to_second(n : Nat) : async Nat {
        return n*24*60*60;
    };

    //4
    public func increment_counter(n : Int) : async Int {
        counter += n;
        return counter
    };
 
    // 4
    public func clear_counter(n : Int) : async Int {
        counter := 0;
        return counter
    };
    
    // 5 only returns true if division is possible
    public func divide(n : Nat, m : Nat) : async Bool {
        if (m == 0) {
            // divisions by zero
            return false;
        } else {
            return true;
        };
    };
    
    //  6
    public func is_even(n : Nat) : async Bool {
        if (n % 2 != 0) {
            return false;
        } else {
            return true;
        };
    };

    // 7
    public func sum_of_array(n : [Nat]) : async Nat {
        var sum = 0;
        for (i in n.vals()) {
            sum += i;
        };
        return sum;
    };

    // 8
    public func maximum(n : [Nat]) : async Nat {
        var max = 0;
        for (i in n.vals()) {
            if (i > max) {
            max := i;
            };
        };
        return max;
    };

    // 9
    public func remove_from_array(m : [Nat], n : Nat) : async [Nat] {
        var cleaned : [Nat] = [];
        for (i in m.vals()) {
            if (i != n) {
            // probably not the best solution, filtering in array/list would be better, but can't make it working
            cleaned := Array.append<Nat>(cleaned, [i]);
            };
        };
        return cleaned;
    };

    // 10
    public func selection_sort(m : [Nat]) : async [Nat] {
        let tmp : [var Nat] = Array.thaw(m);
        let size : Nat = tmp.size();  
        for (i in I.range(0, size)) {
            var min_index = i;  
            for (j in I.range(i+1, size-1)){
                if (tmp[j] < tmp[min_index]){
                    min_index := j;
                };
            // aux variable for swapping
            var aux = tmp[i];    
            // swap items
            tmp[i] := tmp[min_index];
            tmp[min_index] := aux;
            };
        };
        return Array.freeze(tmp);
    };
};

