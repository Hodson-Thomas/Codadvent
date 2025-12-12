package Gift.Deliver;

import Gift.Ribbon.RibbonGift;

public abstract class DeliveredGift {
    protected RibbonGift gift;

    protected DeliveredGift(RibbonGift gift) {
        this.gift = gift;
    }

    public RibbonGift getGift() {
        return gift;
    }
}
