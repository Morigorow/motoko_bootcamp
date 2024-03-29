import Nat8 "mo:base/Nat8";
import Char "mo:base/Char";
import Nat "mo:base/Nat";
import Array "mo:base/Array";
import Text "mo:base/Text";
import Debug "mo:base/Debug";
import Blob "mo:base/Blob";
import Int "mo:base/Int";
import Iter "mo:base/Iter";

actor {
    // Challenge 1
    public func nat_to_nat8(n : Nat) : async Nat8 {
        return(Nat8.fromNat(n));
    };

    // Challenge 2
    public func max_number_with_n_bits(n : Nat) : async Nat {
        return((2**n) - 1);
    };

    // Challenge 3
    public func decimal_to_bits(n : Nat) : async Text {
        var bits : Nat = 0;
        var exp : Nat = 0;
        var num : Nat = n;

        // Multiplier check (2 digits)
        label m_check loop {
            if ((2**exp) > n) {
                break m_check;
            };
            exp += 1;
        };
        
        // Calculate the weight of each digit
        while (num > 0) {
            if ((2**exp) <= num) {
                bits += 10**exp;
                num -= 2**exp;
            };
            if (exp != 0) {
                exp -= 1;
            };
        };

        return(Nat.toText(bits));
    };

    // Challenge 4
    func private_capitalize_character(c : Char) : Char {
        var ascii_code_num : Nat32 = Char.toNat32(c);
        ascii_code_num -= 32;

        return(Char.fromNat32(ascii_code_num));
    };

    public func capitalize_character(c : Char) : async Char {
        return(private_capitalize_character(c));
    };

    // Challenge 5
    public func capitalize_text(t : Text) : async Text {
        var cap_text : Text = "";
        var new_char : Char = '_';

        for (char in t.chars()) {
            if (Char.isLowercase(char)) {
                new_char := private_capitalize_character(char);
                cap_text := Text.concat(cap_text, Char.toText(new_char));
            } else {
                cap_text := Text.concat(cap_text, Char.toText(char));
            };
        };

        return(cap_text);
    };

    // Challenge 6
    public func is_inside(t: Text, c: Char) : async Bool {
        let p : Text.Pattern = #char(c);
        return(Text.contains(t, p));
    };

    // Challenge 7
    public func trim_whitespace(t: Text) : async Text {
        let p : Text.Pattern = #char(' ');
        return(Text.trim(t, p));
    };

    // Challenge 8
    public func duplicated_character(t: Text) : async Text {
        var trimed_text : Text = "";

        label dup_check for (c in Text.toIter(t)) {
            var target : Text.Pattern = #char(c);

            if (Text.contains(trimed_text, target)) {
                return(Char.toText(c));
            };
            trimed_text := Text.concat(trimed_text, Char.toText(c));
        };
        // Duplicated_character is not found.
        return(t);
    };

    // Challenge 9
    public func size_in_bytes(t : Text) : async Nat {
        let utf8_text : Blob = Text.encodeUtf8(t);
        return(utf8_text.size());
    };

    // Challenge 10
    private func _swap(array : [Nat], i : Nat, j : Nat) : [Nat] {
        let array_mutable = Array.thaw<Nat>(array);
        let tmp = array_mutable[i];

        array_mutable[i] := array_mutable[j];
        array_mutable[j] := tmp;

        return(Array.freeze<Nat>(array_mutable));
    };

    public func buble_sort(array : [Nat]) : async [Nat] {
        var sorted_array : [Nat] = array;
        var size = array.size() - 1;

        for (i in Iter.range(0, size)) {
            for (j in Iter.range(1, size - i)) {
                if (sorted_array[j - 1] > sorted_array[j]) {
                    sorted_array := _swap(sorted_array, j - 1, j);
                };
            };
        };
        return(sorted_array);
    };
};
