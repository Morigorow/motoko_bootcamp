import Array "mo:base/Array";
import Iter "mo:base/Iter";

actor {
    // Challenge 1
    public func add(n : Nat, m : Nat) : async Nat {
        return (n + m);
    };

    // Challenge 2
    public func square(n: Nat) : async Nat {
        return (n * n);
    };

    // Challenge 3
    public func days_to_second(n: Nat) : async Nat {
        return (n * 24 * 60 * 60);
    };

    // Challenge 4
    var counter : Nat = 0;
    public func increment_counter(n: Nat) : async Nat {
        counter := counter + n;
        return (counter);
    };

    public func clear_counter() : async () {
        counter := 0;
    };

    // Challenge 5
    public func divide(n: Nat, m: Nat) : async Bool {
        if ((n % m) == 0) {
            return true;
        } else {
            return false;
        };
    };

    // Challenge 6
    public func is_even(n: Nat) : async Bool {
        if ((n % 2) == 0) {
            return true;
        } else {
            return false;
        };
    };

    // Challenge 7
    public func sum_of_array(array: [Nat]) : async Nat {
        var num : Nat = 0;
        for (value in array.vals()) {
            num += value;
        };
        return num;
    };

    // Challenge 8
    public func maximum(array: [Nat]) : async Nat {
        var max : Nat = 0;
        for (value in array.vals()) {
            if (value > max) {
                max := value;
            };
        };
        return max;
    };

    // Challenge 9
    public func remove_from_array(array: [Nat], n: Nat) : async [Nat] {
        var new_array : [Nat] = [];
        for (i in Iter.range(0, array.size() - 1)) {
            if (array[i] != n) {
                new_array := Array.append<Nat>(new_array, [array[i]]); 
            };
        };
        return new_array;
    };

    // Challenge 10
    public func selection_sort(array: [Nat]) : async [Nat] {
        var min : Nat = 0;
        var i : Nat = 0;
        var j : Nat = 0;
        var tmp : Nat = 0;
        var new_array : [var Nat] = Array.thaw<Nat>(array); 

        for (i in Iter.range(0, new_array.size() - 1)) {
            min := i;
            j := i + 1;
            for (j in Iter.range(i, new_array.size() - 1)) {
                if (new_array[min] > new_array[j]) {
                    min := j;
                };
            };
            tmp := new_array[i];
            new_array[i] := new_array[min];
            new_array[min] := tmp;
        };
        
        return Array.freeze<Nat>(new_array);
    };
};