import Time "mo:base/Time";
module {
    public type Post = {
        title: Text;
        content: Text;
        created: Time.Time;
    }
};