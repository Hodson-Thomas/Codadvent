namespace GiftSelection;

public static class GiftSelector
{
    public static string? SelectGiftFor(Child child) => child.Behavior switch
    {
        Behavior.Naughty => null,
        Behavior.Normal when child.Age < 14 => child.GiftRequests
            .Where(gift => gift.IsFeasible)
            .Reverse()
            .Select(gift => gift.GiftName)
            .FirstOrDefault(),
        Behavior.Normal => child.Kindness > 0.5 
            ? child.GiftRequests
                .Where(gift => gift.IsFeasible)
                .Reverse()
                .Select(gift => gift.GiftName)
                .FirstOrDefault()
            : null,
        Behavior.Nice when child.Age < 14 => child.GiftRequests
            .Where(gift => gift.IsFeasible)
            .Select(gift => gift.GiftName)
            .FirstOrDefault(),
        _ => child.Kindness > 0.5
            ? child.GiftRequests
                .Where(gift => gift.IsFeasible)
                .Select(gift => gift.GiftName)
                .FirstOrDefault()
            : null
    };
}
