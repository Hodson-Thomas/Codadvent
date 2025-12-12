package Gift.Ribbon;

import Gift.GiftException;

public abstract class RibbonException extends GiftException {
    protected RibbonException(String message) {
        super(message);
    }
}
