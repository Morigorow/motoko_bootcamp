import Nat8 "mo:base/Nat8";
import Char "mo:base/Char";
import Nat "mo:base/Nat";
import Array "mo:base/Array";
import Text "mo:base/Text";

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
        var new_char : Char = 'a';

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
        for (char in Text.toIter(t)) {
            
        };
    };
};