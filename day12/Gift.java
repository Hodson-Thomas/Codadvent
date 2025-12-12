package Gift;

public abstract class Gift {
    protected IGiftContent content;
    protected IRecipient recipient;

    protected Gift(IGiftContent content, IRecipient recipient) {
        this.content = content;
        this.recipient = recipient;
    }

    public IGiftContent getContent() {
        return content;
    }

    public IRecipient getRecipient() {
        return recipient;
    }
}
