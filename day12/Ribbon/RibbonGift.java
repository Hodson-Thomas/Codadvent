package Gift.Ribbon;

import Gift.Wrapper.WrappedGift;

public abstract class RibbonGift {
    protected WrappedGift giftContent;

    protected RibbonGift(WrappedGift giftContent) {
        this.giftContent = giftContent;
    }

    public WrappedGift getGift() {
        return giftContent;
    }
}
