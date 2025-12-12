package Gift.Wrapper;
import Gift.Gift;

public abstract class WrappedGift {
    protected Gift gift;

    protected WrappedGift(Gift gift) {
        this.gift = gift;
    }

    public Gift getGift() {
        return gift;
    }
}
