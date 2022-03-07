import Nat8 "mo:base/Nat8";
import Char "mo:base/Char";
import Text "mo:base/Text";
import Blob "mo:base/Blob";
import Array "mo:base/Array";
import Iter "mo:base/Iter";

actor {

    // 1
    public func nat_to_na8 (n : Nat) : async Nat8 {
        if (n <= 255 ) {
            return Nat8.fromNat(n);
        } else {
            return 0;
        }
    };

    //2
    public func max_number_with_n_bits (n : Nat) : async Nat {
        return((2 ** n) -1 );
    };

    // 3
    public func decimal_to_bits(n : Nat) : async Text {
        var result : Text = "";
        var counter : Nat = 0;
        var bits : Nat = n;

        while (bits > 0) {
            if (bits % 2 > 0) {
                result := "1" # result;
            } else {
                result := "0" # result;
            };
            bits /= 2;
        };
        return result;
    };

    //4 Char field in motoko playground only accepts integers, but otherwise should work
    public func capitalize_character(c : Char) : async Char {
        // get unicode scalar value of a character
        var n : Nat32 = Char.toNat32(c);
        
        if (n > 96 and n < 123){
            return Char.fromNat32(n - 32);
        };
        return c;
    };

    //5
    //public func capitalize_text(t : Text) : async Text {
    //    var result : Text = "";

    //    for(char in t.chars()){
    //        // This should work in my opinion, but motoko has some problem
    //        result #= Text.fromChar(capitalize_character(char));
    //    };
    //    return result;
    //}

    //6
    public func is_inside(t : Text, c : Char) : async Bool {
        for (char in t.chars()) {
            if (c == char) {
                return true;
            };
        };
        return false;
    };

    //7
    public func trim_whitespace(t : Text) : async Text {
        return Text.trim(t, #text(" "));
    };

    //8
    public func duplicated_character(t : Text) : async Text {
        var previous : Char = '0'; // how to initiate an empty char
        for (char in t.chars()) {
            if (char == previous){
                return Text.fromChar(char);
            };
            previous := char;
        };
        return t;
    };

    //9
    public func size_in_bytes(t : Text) : async Nat {
        return Blob.toArray(Text.encodeUtf8(t)).size();
    };

    //10
    public func bubble_sort(numbers : [Nat]) : async [Nat] {
        let tmp : [var Nat] = Array.thaw(numbers);
        let size : Nat = tmp.size();  
        for (i in Iter.range(0,size-1)){

            for (j in Iter.range(0, size-i-2)){
                if (tmp[j] > tmp[j+1]) {
                    var aux = tmp[j];
                    tmp[j] := tmp[j+1];
                    tmp[j+1] := aux;
                };
            };
        };
        return Array.freeze(tmp);
    }
} 