public static class Building
{
    public static int WhichFloor(string signalStream) =>
        signalStream.Contains("🧝")
            ? signalStream.Where(c => c is '(' or ')').Select(c => c == '(' ? -2 : 3).Sum()
            : signalStream.Where(c => c is '(' or ')').Select(c => c == '(' ? 1 : -1).Sum();
}
