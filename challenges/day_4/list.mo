import Array "mo:base/Array";

module {
    public type List<T> = ?(T, List<T>);

    // Challenge 7
    public func is_null<T>(l : List<T>) : Bool {
        switch l {
            case null { true };
            case _ { false };
        }
    };

    // Challenge 8
    public func last<T>(l : List<T>) : ?T {
        switch l {
            case null { null };
            case (?(x, null)) { ?x };
            case (?(_, t)) { last<T>(t) };
        }
    };

    // Challenge 9
    public func size<T>(l : List<T>) : Nat {
        func recursive_func(l : List<T>, n : Nat) : Nat {
            switch l {
                case null { n };
                case (?(_, t)) { recursive_func(t, n + 1) }
            }
        };
        recursive_func(l, 0)
    };

    // Challenge 10
    public func get(l : List<T>, n : Nat) : ?T {
        switch (n, l) {
            case (0, (?(h, _))) { ?h };
            case (_, null) { null };
            case (_, (?(_, t))) { get(t, n - 1) };
        }
    };

    // Challenge 11
    public func reverse(l : List<T>) : List<T> {
        func recursive_func(l : List<T>, r : List<T>) : List<T> {
            switch l {
                case null { r };
                case (?(h, t)) { recursive_func(t, ?(h, r)) };
            }
        };
        recursive_func(l, null)
    };
};