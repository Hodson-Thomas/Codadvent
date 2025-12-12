package Gift.Wrapper;

import Gift.Gift;

public interface IWrapper {
    public WrappedGift wrapGift(Gift gift) throws WrapperException;
}
