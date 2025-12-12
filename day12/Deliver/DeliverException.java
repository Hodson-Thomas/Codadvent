package Gift.Deliver;

import Gift.GiftException;

public abstract class DeliverException extends GiftException {
    protected DeliverException(String message) {
        super(message);
    }
}
