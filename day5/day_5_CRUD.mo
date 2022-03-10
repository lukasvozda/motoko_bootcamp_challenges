import List "mo:base/List";
import Option "mo:base/Option";
import Time "mo:base/Time";
import Map "mo:base/HashMap";
import Hash "mo:base/Hash";
import Text "mo:base/Text";
import Iter "mo:base/Iter";

actor Blog {
    
    public type PostId = Nat;
    private type Created = Time.Time;
    private type Updated = Time.Time;

    public type Post = {
        title : Text;
        created: Created;
        updated: Updated;
        content : Text;
        tags : ?List.List<Text>;
    };

        
    private stable var next :PostId = 1;
    private stable var stableposts : [(PostId, Post)] = [];
        
    let eq: (Nat, Nat) -> Bool = func(x, y) { x == y };
    private var blogposts = Map.HashMap<PostId, Post>(0, eq, Hash.hash);
    //private var stablemap = Map.HashMap<PostId, Post>(entries.entries(), eq, Hash.hash);


    system func preupgrade() {
        stableposts := Iter.toArray(blogposts.entries());
    };

    system func postupgrade() {
        blogposts := Map.fromIter<PostId, Post>(stableposts.vals(), 10, eq, Hash.hash);
        stableposts := [];
    };

    public func create(post : Post): async PostId {
        let postId = next;
        next += 1;

        let blogpost: Post = {
            created = Time.now();
            updated = Time.now();
            title = post.title;
            content = post.content;
            tags = post.tags;
        };
        
        blogposts.put(postId, blogpost);
        return postId;
    };

    
    public func create_test(): async PostId {
        let postId = 0;
        let blogpost: Post = {
            created = Time.now();
            updated = Time.now();
            title = "Testovací post";
            content = "Test content";
            tags = ?List.nil();
        };
        
        blogposts.put(postId, blogpost);
        return postId;
    };

    public query func get(id : PostId) : async ?Post {
        blogposts.get(id)
    };


    public func update(id : PostId, post : Post) : async Bool {
        let result = blogposts.get(id);

        switch (result){
                        case null {
                return false;
            };
            case (? v){
                let blogpost : Post = {
                    created = v.created;
                    updated = Time.now();
                    title = post.title;
                    content = post.content;
                    tags = post.tags;
                };
                blogposts.put(id, blogpost);
            };
        };
        return true;
    };



    public func delete(id : PostId) : async Bool {
        blogposts.delete(id);
        return true;
    };

    public query func get_all_posts() : async List.List<Post> {
        let iter = blogposts.entries();
        var post_list : List.List<Post> = List.nil();

        for ((postNat, post) in iter){
            post_list := List.push<Post>(post, post_list);
        };
        return post_list;
    };

    public query func list(): async  List.List<(PostId,Post)> {
        // returning records instead of list
        return Iter.toList(blogposts.entries());
    };

    public query func list_array(): async [(PostId, Post)] {
        return Iter.toArray(blogposts.entries());
    };
}

