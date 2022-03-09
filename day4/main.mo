import Custom "custom";
import Time "mo:base/Time";
import Animal "animal";

actor {
    // 1
    public func fun () : async Custom.Post {
        return {
            title : "Hello world",
            content : "Boring content",
            created : Time.now();
        }
    };

    //2
    var dog : Animal = {
        species = "doge";
        energy = 99;
    }
    
    
    //3 long day at work, didn't manage to do more :/
}