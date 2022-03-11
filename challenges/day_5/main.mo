import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Nat8 "mo:base/Nat8";
import Cycles "mo:base/ExperimentalCycles";
import Option "mo:base/Option";

actor {
    // Challenge 1
    public shared(msg) func whoami() : async Principal {
        let principal_caller = msg.caller;
        return(principal_caller);
    };

    public func is_anonymous() : async Bool {
        return(Principal.isAnonymous(await whoami()));
    };

    // Challenge 2
    let favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

    // Challenge 3
    /*
    public func add_favorite_number(n : Nat) : () {
        let fav_num_principal : Principal = await whoami();
        favoriteNumber.put(fav_num_principal, n);
    };
    */
    public func show_favorite_number() : async ?Nat {
        return(favoriteNumber.get(await whoami()));
    };

    // Challenge 4
    public func add_favorite_number(n : Nat) : async Text {
        let fav_num_principal : Principal = await whoami();
        if (favoriteNumber.get(fav_num_principal) == null) {
            favoriteNumber.put(fav_num_principal, n);
            return("You've successfully registered your number");
        };
        return("You've already registered your number");
    };

    // Challenge 5
    public func update_favorite_number(n : Nat) : async Text {
        let fav_num_principal : Principal = await whoami();
        favoriteNumber.put(fav_num_principal, n);
        return("You've successfully updated your number");
    };

    public func delete_favorite_number() : async ?Nat {
        let fav_num_principal : Principal = await whoami();
        return(favoriteNumber.remove(fav_num_principal));
    };

    // Challenge 6
    let cyclesHashMap = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);
 
    public func deposit_cycles() : async Nat {
        let principal : Principal = await whoami();
        let amount_to_pay : Nat = Cycles.available();

        cyclesHashMap.put(principal, Cycles.accept(amount_to_pay));

        let num : Nat = Option.unwrap(cyclesHashMap.get(principal));
        return(num);
    };

    // Challenge 7
    public func withdraw_cycles(n : Nat) : () {

    };

    // Challenge 8
    stable var counter : Nat = 0;
    stable var version : Nat = 0;

    public func get_version_upgrade_number() : async Nat {
        return version;
    };
    
    public func increment_counter(n : Nat) : async Nat {
        counter += n;
        return counter;
    };

    public func clear_counter() : async Nat {
        counter := 0;
        return counter;
    };

    system func postupgrade() {
        version += 1;
    };
};
