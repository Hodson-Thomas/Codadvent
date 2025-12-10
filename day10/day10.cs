namespace GiftSelection;

public static class GiftSelector
{
    public static string? SelectGiftFor(Child child) => child.Behavior switch
    {
        Behavior.Naughty => null,
        Behavior.Normal => child.Age >= 14 && child.Kindness < 0.5 
            ? null
            : child.GiftRequests.Where(gift => gift.IsFeasible).Reverse().Select(gift => gift.GiftName).FirstOrDefault(),
        Behavior.Nice => child.Age >= 14 && child.Kindness < 0.5
            ? null
            : child.GiftRequests.Where(gift => gift.IsFeasible).Select(gift => gift.GiftName).FirstOrDefault()
    };
}
