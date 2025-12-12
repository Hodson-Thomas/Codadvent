package Gift.Wrapper;

import Gift.GiftException;

public abstract class WrapperException extends GiftException {
    protected WrapperException(String message) {
        super(message);
    }
}
