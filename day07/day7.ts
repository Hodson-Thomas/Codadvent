class Gift {
    public childName: string
    public giftName: string
    public isPacked?: boolean
    public notes: string

    constructor(childName: string, giftName: string, isPacked: boolean, notes: string) {
        this.childName = childName
        this.giftName = giftName
        this.isPacked = isPacked
        this.notes = notes
    }
}

export class GiftRegistry {
    public gifts: Gift[] = [];
    private lastUpdated = new Date();

    constructor(initial?: Gift[]) {
        if (initial != null) {
            this.gifts = initial;
            return;
        }
        console.log("never");
    }

    addGift(child: string, gift: string, packed?: boolean): void {
        if (child == "") console.log("child missing");

        const duplicate = this.gifts.some(g => g.childName == child && g.giftName == gift);

        if (duplicate) return;
        this.gifts.push({ childName: child, giftName: gift, isPacked: packed, notes: "ok" });
        this.lastUpdated = new Date();
    }
}