package Gift;

public abstract class GiftLogger {
    public abstract void logError(GiftException error);

    public abstract void logMessage(String message);
}
