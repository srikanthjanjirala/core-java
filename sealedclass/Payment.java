// A sealed class that can only be permitted to be extended by other classes
public sealed class Payment permits Cash, Crypto, CreditCard {
    
}