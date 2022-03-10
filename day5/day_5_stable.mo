import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";


actor {
    private stable var stableFavourites : [(Principal, Nat)] = [];


    //2
    private var favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

    //3 & 4
    public shared(msg) func add_favorite_number(n : Nat) : async Text {
        if (favoriteNumber.get(msg.caller) != null) {
            return "You've already registered your number"
        };

        favoriteNumber.put(msg.caller, n);
        return "You've successfully registered your number"
    };

    public shared(msg) func show_favorite_number() : async ?Nat {
        return favoriteNumber.get(msg.caller);
    };

    //5
    public shared({caller}) func update_favorite_number(n : Nat) {
        favoriteNumber.put(caller, n);
    };

    public shared({caller}) func delete_favorite_number() {
        ignore favoriteNumber.remove(caller);
    };

    system func preupgrade() {
		stableFavourites := Iter.toArray(favoriteNumber.entries());	
	};
	
	system func postupgrade() {
		favoriteNumber := HashMap.fromIter<Principal, Nat>(stableFavourites.vals(), 10, Principal.equal, Principal.hash);
        stableFavourites := [];
	};
};    