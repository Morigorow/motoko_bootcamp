// Challenge 9

import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Nat8 "mo:base/Nat8";
import Cycles "mo:base/ExperimentalCycles";
import Option "mo:base/Option";

actor upgrade {
    stable var version : Nat = 0;
    stable var entries: [(Principal, Nat)] = [];


    public shared(msg) func whoami() : async Principal {
        let principal_caller = msg.caller;
        return(principal_caller);
    };

    public func is_anonymous() : async Bool {
        return(Principal.isAnonymous(await whoami()));
    };

    let favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

    public func show_favorite_number() : async ?Nat {
        return(favoriteNumber.get(await whoami()));
    };

    public func add_favorite_number(n : Nat) : async Text {
        let fav_num_principal : Principal = await whoami();
        if (favoriteNumber.get(fav_num_principal) == null) {
            favoriteNumber.put(fav_num_principal, n);
            return("You've successfully registered your number");
        };
        return("You've already registered your number");
    };

    public func update_favorite_number(n : Nat) : async Text {
        let fav_num_principal : Principal = await whoami();
        favoriteNumber.put(fav_num_principal, n);
        return("You've successfully updated your number");
    };

    public func delete_favorite_number() : async ?Nat {
        let fav_num_principal : Principal = await whoami();
        return(favoriteNumber.remove(fav_num_principal));
    };

    system func preupgrade() {
        entries := Iter.toArray(favoriteNumber.entries());
    };

    system func postupgrade() {
        entries := [];
        version += 1;
    };
};