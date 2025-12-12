package Gift.Deliver;

import Gift.Ribbon.RibbonGift;

public interface IDeliver {
    public DeliveredGift deliverGift(RibbonGift gift) throws DeliverException;
}
