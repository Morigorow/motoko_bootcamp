import Char "mo:base/Char";
import Nat "mo:base/Nat";
import Array "mo:base/Array";
import Text "mo:base/Text";
import Debug "mo:base/Debug";
import Blob "mo:base/Blob";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Option "mo:base/Option";

actor {
    // Challenge 1
    private func swap(mutable_array: [var Nat], j: Nat, i: Nat) : [var Nat] {
        var tmp : Nat = mutable_array[j];
        mutable_array[j] := mutable_array[i];
        mutable_array[i] := tmp;
        return(mutable_array);
    };

    // Challenge 2
    public func init_count(n : Nat) : async [Nat] {
        let array : [var Nat] = Array.init<Nat>(n, 0);
        for (i in Iter.range(0, n - 1)) {
            array[i] := i;
        };
        return(Array.freeze<Nat>(array));
    };

    // Challenge 3
    public func seven(array : [Nat]) : async Text {
        for(number in array.vals()) {
            if (number == 7) {
                return("Seven is found");
            };
        };
        return("Seven not found");
    };

    // Challenge 4
    public func nat_opt_to_nat(n : ?Nat, m : Nat) : async Nat {
        switch(n) {
            case(null) {
                return(m);
            };
            case(?something) {
                return(Option.unwrap<Nat>(n));
            };
        };
    };

    // Challenge 5
    public func day_of_the_week(n : ?Nat) : async ?Text {
        switch(n) {
            case(?1) {
                return(?"Monday");
            };
            case(?2) {
                return(?"Tuesday");
            };
            case(?3) {
                return(?"Wednesday");
            };
            case(?4) {
                return(?"Thursday");
            };
            case(?5) {
                return(?"Friday");
            };
            case(?6) {
                return(?"Saturday");
            };
            case(?7) {
                return(?"Sunday");
            };
            case(?something) {
                return(null);
            };
        };
    };

    // Challenge 6
    public func populate_array(array : [?Nat]) : async [Nat] {
        let null_to_zero_func = func (?n : ?Nat) : Nat {
            if (?n == null) {
                return(0);
            } else {
                return(n);
            };
        };
        return(Array.map(array, null_to_zero_func));
    };

    // Challenge 7
    public func sum_of_array(array : [Nat]) : async Nat {
        let add_func = func (num_a : Nat, num_b : Nat) : Nat {
            return(Nat.add(num_a, num_b));
        };
        return(Array.foldLeft(array, 0, add_func));
    };

    // Challenge 8
    public func squared_array(array : [Nat]) : async [Nat] {
        let squ_func = func (n : Nat) : Nat {
            return(n*n);
        };
        return(Array.map(array, squ_func));
    };

    // Challenge 9
    public func increase_by_index(array : [Nat]) : async [Nat] {
        let add_index_num_func = func (index : Nat, num : Nat) : Nat {
            return(Nat.add(index, num));
        };
        return(Array.mapEntries(array, add_index_num_func));
    };

    // Challenge 10
    func contains<A>(array : [A], a : A, f : (A,A) -> Bool) : async Bool {
        switch ((Array.find<A>(array, func (n : A) {f(n, a)}))) {
            case (?contains) true;
            case (null) false;
        };
    };
};