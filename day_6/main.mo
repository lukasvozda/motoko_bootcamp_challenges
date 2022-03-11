import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import Result "mo:base/Result";
import Principal "mo:base/Principal";

actor {

    //1
    public type TokenIndex = Nat;

    stable var nextTokenIndex: TokenIndex = 0;

    public type Error = {
        #internal_error;
        #not_found;
        #unauthorized;
    };

    //2
    stable var entries: [(TokenIndex, Principal)] = [];

    let registry = HashMap.fromIter<TokenIndex, Principal>(entries.vals(), entries.size(), Nat.equal, Hash.hash);

    //3
    let anonymousPrincipal = Principal.fromText("2vxsx-fae");

    public shared({caller}) func mint(): async Result.Result<(), Error> {
        return if (caller == anonymousPrincipal) {
            #err(#unauthorized);
        } else {
            registry.put(nextTokenIndex, caller);
            nextTokenIndex+=1;
            #ok();
        }
    };

    //4
    public shared({caller}) func transfer(to: Principal, index: TokenIndex): async Result.Result<(), Error> {
        let owner = registry.get(index);
        return switch(owner) {
            case(null) {
                #err(#not_found);
            }; case(?owner) {
                if (owner == caller) {
                    registry.put(index, to);
                    #ok();
                } else {
                    #err(#unauthorized);
                }
            };
        }
    };

    //5-10 sorry no time :( focus on finishing core project
    
}    
