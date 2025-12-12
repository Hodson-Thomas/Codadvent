package Gift.Ribbon;

import Gift.Wrapper.WrappedGift;

public interface IRibbon {
    public RibbonGift addRibbon(WrappedGift gift) throws RibbonException;
}
