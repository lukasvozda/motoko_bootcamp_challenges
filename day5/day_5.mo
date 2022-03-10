import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Cycles "mo:base/ExperimentalCycles";

actor {
    
    //1
    public shared(msg) func is_anonymous() : async Bool {
        if (Principal.isAnonymous(msg.caller)) {
            return true;
        };
        return false;
    };

    //2
    let favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

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

    //6
    public func deposit_cycles() : async Nat {
        let received = Cycles.accept(Cycles.available());
        return received;
    };

    //7 SKIP

    //8
     stable var counter : Nat = 0;
     stable var counter_version : Nat = 0;

    public func counter_increment() : async Nat {
        counter += 1;
        return counter;
    };

    public func get_counter() : async Nat {
        return counter;
    };

    public func get_counter_version() : async Nat {
        return counter_version;
    };

    system func postupgrade() {
		counter_version += 1;
	};
};