import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import Result "mo:base/Result";
import Debug "mo:base/Debug";
import Option "mo:base/Option";
import List "mo:base/List";
import HTTP "http";
import Text "mo:base/Text";
import Iter "mo:base/Iter";

actor {
    // Challenge 1
    type Error = {
        #Unauthorized;
        #OwnerNotFound;
        #OperatorNotFound;
        #TokenNotFound;
        #ExistedNFT;
        #SelfApprove;
        #SelfTransfer;
        #TxNotFound;
        #Other : Text;
    };
    type TokenIndex = Nat;

    // Challenge 2
    stable var entries : [(TokenIndex, Principal)] = [];
    let registry = HashMap.fromIter<TokenIndex, Principal>(entries.vals(), 0, Nat.equal, Hash.hash);

    // Challenge 3
    var nextTokenIndex : Nat = 0;
    let anonymous : Principal = Principal.fromText("2vxsx-fae");
    var latest_minter : Principal = Principal.fromText("2vxsx-fae");

    public type Result<T,E> = Result.Result<T, E>;

    public shared ({caller}) func mint() : async Result<(), Error> {
        switch (Principal.equal(anonymous, caller)) {
            case (true) {
                return #err(#Unauthorized);
            };
            case (false) {
                registry.put(nextTokenIndex, caller);
                nextTokenIndex += 1;
                latest_minter := caller;
                return #ok;
            };
        };
    };

    // Challenge 4
    public func transfer(to : Principal, tokenIndex : Nat) : async Result<(), Error> {
        switch (registry.get(tokenIndex)) {
            case (null) {
                return #err(#Unauthorized)
            };
            case (?_) {
                registry.put(tokenIndex, to);
                return #ok;
            };
        };
    };

    // Challenge 5
    public type List<TokenIndex> = ?(TokenIndex, List<TokenIndex>);

    public shared ({caller}) func balance() : async List<TokenIndex> {
        var token_list : List<TokenIndex> = List.nil<TokenIndex>();

        for ((idx, principal) in registry.entries()) {
            if (Principal.equal(principal, caller)) {
                token_list := List.push(idx, token_list);
            };
        };
        return token_list;
    };

    // Challenge 6
    public query func http_request(request : HTTP.Request) : async HTTP.Response {
        let minted_nft_num_msg : Text = Nat.toText(nextTokenIndex);
        let latest_minter_msg : Text = Principal.toText(latest_minter);

        let response = {
            body = Text.encodeUtf8(
                "the number of nft minted (TOTAL) : " # minted_nft_num_msg # " / " #
                "principal of the latest minter : " # latest_minter_msg);
            headers = [("Content-Type", "text/html; charset=UTF-8")];
            status_code = 200 : Nat16;
            streaming_strategy = null
        };
        return(response)
    };

    // Challenge 7
    system func preupgrade() {
        entries := Iter.toArray(registry.entries());
    };
    system func postupgrade() {
        entries := [];
    };
};



